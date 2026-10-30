import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../refundflow1/views/refundflow1_view.dart';

class WaitingroomController extends GetxController {
  //TODO: Implement WaitingroomController

  final count = 0.obs;
  final RxInt remainingSeconds = 157.obs;
  final RxInt waitingSingles = 14.obs;
  final RxInt matchAttempt = 2.obs;
  final RxInt confirmedMatches = 1.obs;
  final RxInt bottomIndex = 2.obs;
  final RxBool isSearching = true.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startCountdown();
  }

  void startCountdown() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0 && isSearching.value) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  String get formattedTime {
    final minutes = (remainingSeconds.value ~/ 60)
        .toString()
        .padLeft(2, '0');
    final seconds = (remainingSeconds.value % 60)
        .toString()
        .padLeft(2, '0');

    return '$minutes:$seconds';
  }

  void selectBottomTab(int index) {
    bottomIndex.value = index;
    // Connect your existing app routes here.
  }

  void exitAndRequestRefund() {
    Get.to(Refundflow1View());
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
