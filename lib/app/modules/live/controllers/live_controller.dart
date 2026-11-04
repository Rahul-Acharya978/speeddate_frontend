import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:sundaymixer/app/data/speed_date_api.dart';
import 'package:sundaymixer/app/modules/waitingroom/views/waitingroom_view.dart';
import 'package:sundaymixer/app/modules/live/views/call_ended_view.dart';

class LiveController extends GetxController {
  //TODO: Implement LiveController

  final count = 0.obs;
  final RxInt seconds = 0.obs;
  final RxBool isMicOn = true.obs;
  final RxBool isCameraOn = true.obs;
  final RxBool isSpeakerOn = true.obs;
  final RxBool isLiked = false.obs;
  final RxInt likeCount = 3.obs;
  final RxInt bottomIndex = 2.obs;
  final RxBool isCallEnded = false.obs;
  final RxDouble previewX = 0.0.obs;
  final RxDouble previewY = 0.0.obs;
  final RxBool isConnecting = false.obs;
  final Rxn<VideoTrack> remoteVideo = Rxn<VideoTrack>();
  final Rxn<VideoTrack> localVideo = Rxn<VideoTrack>();
  final RxBool sawRemote = false.obs;
  Timer? _timer;
  Timer? _poll;
  Room? _room;
  EventsListener<RoomEvent>? _roomListener;
  String? _activeEventId;
  String? _connectedRoom;
  String _partnerId = '';
  String _partnerName = '';
  String _partnerPhoto = '';
  int _partnerAge = 0;
  int _joinGeneration = 0;
  int roundLimit = 213;
  int introLimit = 33;
  bool _redirecting = false;
  bool _syncing = false;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    _timer?.cancel();

    seconds.value = 0;
    isCallEnded.value = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isCallEnded.value) {
        timer.cancel();
        return;
      }

      if (_activeEventId != null) {
        if (seconds.value < roundLimit) seconds.value++;
        return;
      }

      if (seconds.value >= 180) {
        timer.cancel();
        endCall();
        return;
      }

      seconds.value++;
    });
  }

  String get formattedTime {
    final minutes = (seconds.value ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds.value % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  void allowRejoin() {
    _joinGeneration++;
    _poll?.cancel();
    _activeEventId = null;
    _connectedRoom = null;
  }

  void ensureJoined(String? eventId) {
    if (eventId == null || eventId.isEmpty) return;
    if (_activeEventId == eventId) return;
    _activeEventId = eventId;
    _redirecting = false;
    _poll?.cancel();
    _poll = Timer.periodic(const Duration(seconds: 1), (_) => syncCall());
    Future.microtask(syncCall);
  }

  Future<void> syncCall() async {
    final eventId = _activeEventId;
    if (eventId == null || _redirecting || _syncing) return;
    _syncing = true;
    try {
      var status = await SpeedDateApi.status(eventId);
      if (status.phase == 'not_joined') {
        status = await SpeedDateApi.join(eventId);
      }
      roundLimit = status.roundSeconds;
      if (status.introSeconds > 0) introLimit = status.introSeconds;
      if (status.phase == 'incall' && status.token.isNotEmpty) {
        _rememberPartner(status);
        seconds.value = status.elapsedSeconds;
        if (_connectedRoom != status.room) {
          final connected = await _connectPair(status.url, status.token);
          if (connected) _connectedRoom = status.room;
        }
        return;
      }
      if (status.phase != 'incall') {
        _redirecting = true;
        _poll?.cancel();
        await leaveRoom(keepEvent: true);
        _openNext(eventId);
      }
    } catch (_) {
    } finally {
      _syncing = false;
    }
  }

  Future<bool> _connectPair(String url, String token) async {
    final generation = _joinGeneration;
    isConnecting.value = true;
    try {
      await leaveRoom(keepEvent: true);
      _connectedRoom = null;
      final room = Room();
      _room = room;
      _roomListener = room.createListener()
        ..on<TrackSubscribedEvent>((_) => _syncTracks())
        ..on<TrackUnsubscribedEvent>((_) => _syncTracks())
        ..on<LocalTrackPublishedEvent>((_) => _syncTracks())
        ..on<LocalTrackUnpublishedEvent>((_) => _syncTracks())
        ..on<ParticipantDisconnectedEvent>((_) => _syncTracks());
      await room.connect(url, token);
      if (generation != _joinGeneration) {
        await room.disconnect();
        return false;
      }
      await room.localParticipant?.setMicrophoneEnabled(isMicOn.value);
      await room.localParticipant?.setCameraEnabled(isCameraOn.value);
      _syncTracks();
      return true;
    } catch (_) {
      Get.snackbar(
        'Live',
        'Could not connect the video call',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isConnecting.value = false;
    }
  }

  void _syncTracks() {
    VideoTrack? local;
    final localPublications = _room?.localParticipant?.videoTrackPublications;
    if (localPublications != null) {
      for (final publication in localPublications) {
        final track = publication.track;
        if (track != null && isCameraOn.value) local = track;
      }
    }
    localVideo.value = local;

    VideoTrack? remote;
    final people = _room?.remoteParticipants.values;
    if (people != null) {
      for (final person in people) {
        for (final publication in person.videoTrackPublications) {
          final track = publication.track;
          if (track != null) remote = track;
        }
      }
    }
    remoteVideo.value = remote;
    if (remote != null) sawRemote.value = true;
  }

  Future<void> leaveRoom({bool keepEvent = false}) async {
    if (!keepEvent) _activeEventId = null;
    remoteVideo.value = null;
    localVideo.value = null;
    sawRemote.value = false;
    await _roomListener?.dispose();
    _roomListener = null;
    await _room?.disconnect();
    _room = null;
  }

  void toggleMic() {
    isMicOn.toggle();
    _room?.localParticipant?.setMicrophoneEnabled(isMicOn.value);
  }

  void toggleCamera() {
    isCameraOn.toggle();
    _room?.localParticipant?.setCameraEnabled(isCameraOn.value);
    _syncTracks();
  }

  void toggleSpeaker() {
    isSpeakerOn.toggle();
    Hardware.instance.setSpeakerphoneOn(isSpeakerOn.value);
  }

  void toggleLike() {
    isLiked.toggle();
    likeCount.value += isLiked.value ? 1 : -1;
  }

  void endCall() {
    _timer?.cancel();
    isCallEnded.value = true;

    Get.dialog(
      AlertDialog(
        title: const Text('End Live Call?'),
        content: const Text('Are you sure you want to end this call?'),
        actions: [
          TextButton(
            onPressed: () {
              isCallEnded.value = false;
              Get.back();
              _resumeTimer();
            },
            child: const Text('Continue Call'),
          ),
          TextButton(
            onPressed: () async {
              final eventId = _activeEventId;
              Get.back();
              if (eventId == null) {
                await leaveRoom();
                Get.off(() => const WaitingroomView());
                return;
              }
              try {
                await SpeedDateApi.rotate(eventId);
              } catch (_) {}
              _redirecting = true;
              _poll?.cancel();
              await leaveRoom(keepEvent: true);
              _openNext(eventId);
            },
            child: const Text(
              'End Call',
              style: TextStyle(color: Color(0xFFD71920)),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void selectBottomTab(int index) {
    bottomIndex.value = index;

    // Connect Home, Events, Chat and Profile routes here.
  }

  @override
  void onReady() {
    super.onReady();
  }

  void _resumeTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isCallEnded.value) {
        timer.cancel();
        return;
      }
      if (_activeEventId != null) {
        if (seconds.value < roundLimit) seconds.value++;
        return;
      }
      if (seconds.value >= 180) {
        timer.cancel();
        endCall();
        return;
      }
      seconds.value++;
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    _poll?.cancel();
    leaveRoom();
    super.onClose();
  }

  void _rememberPartner(SpeedDateStatus status) {
    if (status.partnerId.isEmpty) return;
    _partnerId = status.partnerId;
    _partnerName = status.partnerName;
    _partnerPhoto = status.partnerPhoto;
    _partnerAge = status.partnerAge;
  }

  void _openNext(String eventId) {
    final talkedLongEnough = seconds.value >= introLimit || seconds.value >= roundLimit;
    if (talkedLongEnough && _partnerId.isNotEmpty) {
      final partnerId = _partnerId;
      _partnerId = '';
      Get.off(() => CallEndedView(
            eventId: eventId,
            partnerId: partnerId,
            name: _partnerName.isEmpty ? 'Your match' : _partnerName,
            photo: _partnerPhoto,
            age: _partnerAge,
            seconds: seconds.value,
            roundSeconds: roundLimit,
          ));
      return;
    }
    Get.off(() => WaitingroomView(eventId: eventId));
  }

  void increment() => count.value++;
}
