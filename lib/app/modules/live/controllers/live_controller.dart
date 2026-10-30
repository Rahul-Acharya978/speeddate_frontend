import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  Timer? _timer;

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

  void toggleMic() => isMicOn.toggle();

  void toggleCamera() => isCameraOn.toggle();

  void toggleSpeaker() => isSpeakerOn.toggle();

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
            onPressed: () => Get.back(),
            child: const Text('Continue Call'),
          ),
          TextButton(
            onPressed: () {
            Get.to(WaitingroomView());

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

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void increment() => count.value++;
}
