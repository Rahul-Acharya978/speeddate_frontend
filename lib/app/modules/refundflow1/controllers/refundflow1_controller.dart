import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sundaymixer/app/modules/refundflow1/views/refundflow1_view.dart';

import '../../refundflow2/views/refundflow2_view.dart';

class Refundflow1Controller extends GetxController {
  //TODO: Implement Refundflow1Controller

  final count = 0.obs;
  final RxInt bottomIndex = 2.obs;
  final RxBool isRetrying = false.obs;
  final RxBool isRefundRequested = false.obs;

  void selectBottomTab(int index) {
    bottomIndex.value = index;

    // Connect your existing Home, Events, Live, Chat and Profile routes.
  }

  void tryAnotherMatch() {
    if (isRetrying.value) return;

    isRetrying.value = true;

    // Connect your matchmaking API or Waitingroom route here.
    Get.snackbar(
      'Try Another Match',
      'Connect your matchmaking API to start another round.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );

    isRetrying.value = false;
  }

  void requestRefund() {
   Get.to(Refundflow2View());
  }

  void showHelp() {
    Get.dialog(
      AlertDialog(
        title: const Text('Match Result Help'),
        content: const Text(
          'No suitable match was found in this round. '
          'You can try another match or request an eligible refund.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
