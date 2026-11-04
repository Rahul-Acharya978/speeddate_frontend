import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sundaymixer/app/data/speed_date_api.dart';
import 'package:sundaymixer/app/modules/live/views/live_view.dart';
import 'package:sundaymixer/app/modules/refundflow1/views/refundflow1_view.dart';

class WaitingroomController extends GetxController {
  final count = 0.obs;
  final RxInt remainingSeconds = 0.obs;
  final RxBool hasWait = false.obs;
  final RxInt waitingSingles = 0.obs;
  final RxInt matchCount = 0.obs;
  final RxInt matchTarget = 3.obs;
  final RxInt bottomIndex = 2.obs;
  final RxBool isSearching = true.obs;
  final RxBool refundEligible = false.obs;
  final RxString refundMessage = ''.obs;
  final RxString eventName = ''.obs;
  final RxInt averageWaitSeconds = (-1).obs;
  final RxInt roundSeconds = 213.obs;

  Timer? _timer;
  Timer? _poll;
  String? _eventId;
  bool _openingLive = false;
  bool _shownError = false;

  @override
  void onInit() {
    super.onInit();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (hasWait.value && remainingSeconds.value > 0) {
        remainingSeconds.value--;
      }
    });
  }

  void watch(String? eventId) {
    if (eventId == null || eventId.isEmpty) return;
    if (_eventId == eventId && _poll != null) return;
    _eventId = eventId;
    _openingLive = false;
    refreshStatus();
    _poll?.cancel();
    _poll = Timer.periodic(const Duration(seconds: 1), (_) => refreshStatus());
  }

  Future<void> refreshStatus() async {
    final eventId = _eventId;
    if (eventId == null || _openingLive) return;
    try {
      var status = await SpeedDateApi.status(eventId);
      if (status.phase == 'not_joined') {
        status = await SpeedDateApi.join(eventId);
      }
      _apply(status);
      _shownError = false;
      if (status.phase == 'incall' && status.room.isNotEmpty) {
        _openingLive = true;
        _poll?.cancel();
        Get.off(() => LiveView(eventId: eventId));
      }
    } catch (error) {
      if (_shownError) return;
      _shownError = true;
      Get.snackbar(
        'Live',
        '$error'.replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _apply(SpeedDateStatus status) {
    eventName.value = status.eventName;
    waitingSingles.value = status.waitingSingles;
    matchCount.value = status.matchCount;
    matchTarget.value = status.matchTarget == 0 ? 3 : status.matchTarget;
    refundEligible.value = status.refundEligible;
    refundMessage.value = status.refundMessage;
    roundSeconds.value = status.roundSeconds;
    averageWaitSeconds.value = status.averageWaitSeconds ?? -1;
    if (status.waitSeconds == null) {
      hasWait.value = false;
      remainingSeconds.value = 0;
    } else {
      hasWait.value = true;
      remainingSeconds.value = status.waitSeconds!;
    }
  }

  String get formattedTime {
    if (!hasWait.value) return '--:--';
    final minutes = (remainingSeconds.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds.value % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String get roundLabel {
    final minutes = roundSeconds.value ~/ 60;
    final seconds = (roundSeconds.value % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String get averageWaitLabel {
    if (averageWaitSeconds.value < 0) return 'Avg. wait: --';
    final minutes = (averageWaitSeconds.value / 60).round();
    return 'Avg. wait: ${minutes}m';
  }

  String attemptSubtitle(int number) {
    if (number <= matchCount.value) return 'Confirmed';
    if (number == matchCount.value + 1) return 'Searching';
    return 'Queued';
  }

  bool attemptConfirmed(int number) => number <= matchCount.value;

  bool attemptSearching(int number) => number == matchCount.value + 1;

  String get confirmedLine {
    final countLabel = matchCount.value == 1 ? '1 match confirmed' : '${matchCount.value} matches confirmed';
    return '$countLabel  •  Next pairing starting soon';
  }

  void selectBottomTab(int index) {
    bottomIndex.value = index;
  }

  void requestRefund() {
    if (!refundEligible.value) {
      Get.snackbar(
        'Refund',
        refundMessage.value.isEmpty
            ? 'A refund is available when matches are below the promised number.'
            : refundMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    Get.to(() => const Refundflow1View(), arguments: _eventId);
  }

  Future<void> exitAndRequestRefund() async {
    final eventId = _eventId;
    _poll?.cancel();
    _eventId = null;
    if (eventId != null) {
      try {
        await SpeedDateApi.leave(eventId);
      } catch (_) {}
    }
    Get.back();
  }

  @override
  void onClose() {
    _timer?.cancel();
    _poll?.cancel();
    super.onClose();
  }

  void increment() => count.value++;
}
