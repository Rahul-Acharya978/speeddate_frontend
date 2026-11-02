import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:livekit_client/livekit_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sundaymixer/app/modules/waitingroom/views/waitingroom_view.dart';

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
  Timer? _timer;
  Room? _room;
  EventsListener<RoomEvent>? _roomListener;
  String? _activeEventId;
  String? _failedEventId;
  int _joinGeneration = 0;

  static const String tokenApiUrl =
      'https://dateapi.spinfotechindia.com/livekit/token';

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
    _activeEventId = null;
    _failedEventId = null;
  }

  void ensureJoined(String? eventId) {
    if (eventId == null || eventId.isEmpty) return;
    if (_activeEventId == eventId || _failedEventId == eventId) return;
    _activeEventId = eventId;
    Future.microtask(() => joinEvent(eventId));
  }

  Future<void> joinEvent(String eventId) async {
    final generation = _joinGeneration;
    isConnecting.value = true;
    try {
      await leaveRoom(keepEvent: true);
      final session = await _requestSession(eventId);
      final room = Room();
      _room = room;
      _roomListener = room.createListener()
        ..on<TrackSubscribedEvent>((_) => _syncTracks())
        ..on<TrackUnsubscribedEvent>((_) => _syncTracks())
        ..on<LocalTrackPublishedEvent>((_) => _syncTracks())
        ..on<LocalTrackUnpublishedEvent>((_) => _syncTracks())
        ..on<ParticipantDisconnectedEvent>((_) => _syncTracks());

      await room.connect(session.url, session.token);
      if (generation != _joinGeneration) {
        await room.disconnect();
        return;
      }
      await room.localParticipant?.setMicrophoneEnabled(isMicOn.value);
      await room.localParticipant?.setCameraEnabled(isCameraOn.value);
      _syncTracks();
    } catch (error) {
      _failedEventId = eventId;
      await leaveRoom();
      Get.snackbar(
        'Live',
        'Could not join this event',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isConnecting.value = false;
    }
  }

  Future<({String url, String token})> _requestSession(String eventId) async {
    final prefs = await SharedPreferences.getInstance();
    final token =
        prefs.getString('tokenData') ?? prefs.getString('token') ?? '';
    if (token.isEmpty) {
      throw Exception('Login required');
    }

    final response = await http.post(
      Uri.parse(tokenApiUrl),
      headers: {
        'Authorization': token.startsWith('Bearer ') ? token : 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'eventId': eventId}),
    );

    final body = jsonDecode(response.body);
    final data = body is Map ? body['data'] : null;
    if (response.statusCode != 200 || data is! Map) {
      throw Exception('Token request failed');
    }

    final url = data['url']?.toString() ?? '';
    final roomToken = data['token']?.toString() ?? '';
    if (url.isEmpty || roomToken.isEmpty) {
      throw Exception('Live session is incomplete');
    }
    return (url: url, token: roomToken);
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
  }

  Future<void> leaveRoom({bool keepEvent = false}) async {
    if (!keepEvent) _activeEventId = null;
    remoteVideo.value = null;
    localVideo.value = null;
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
              await leaveRoom();
              Get.off(() => const WaitingroomView());
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
    leaveRoom();
    super.onClose();
  }

  void increment() => count.value++;
}
