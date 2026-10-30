import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MatchfoundController extends GetxController {
  //TODO: Implement MatchfoundController

  final count = 0.obs;
  final RxInt seconds = 8.obs;
  final RxInt bottomIndex = 2.obs;
  final RxBool isConnecting = false.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  String get formattedTime {
    final minutes = (seconds.value ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds.value % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  void connectNow() {
    isConnecting.value = true;

    // Connect your real video-call / matching flow here.
    Get.snackbar(
      'Connecting',
      'Starting your speed date...',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );

    isConnecting.value = false;
  }

  void viewFullProfile() {
    // Navigate to your existing matched user's profile page.
    Get.snackbar(
      'Matched Profile',
      'Connect your profile details route here.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  void selectBottomTab(int index) {
    bottomIndex.value = index;

    // Connect your existing Home, Events, Live, Chat and Profile routes.
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
