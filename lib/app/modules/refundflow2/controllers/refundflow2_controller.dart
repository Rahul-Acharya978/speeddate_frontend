import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../refundflow3/views/refundflow3_view.dart';

class Refundflow2Controller extends GetxController {
  //TODO: Implement Refundflow2Controller

  final count = 0.obs;
  final RxInt bottomIndex = 2.obs;
  final RxBool isSubmitting = false.obs;
  final RxBool refundConfirmed = false.obs;

  void selectBottomTab(int index) {
    bottomIndex.value = index;

    // Connect your existing app navigation routes here.
  }

  void showHelp() {
    Get.dialog(
      AlertDialog(
        title: const Text('Refund Help'),
        content: const Text(
          'Your matching session was not completed. '
          'Review the refund details before confirming your request.',
        ),
        actions: [TextButton(onPressed: Get.back, child: const Text('OK'))],
      ),
    );
  }

  void confirmRefund() {
    if (isSubmitting.value || refundConfirmed.value) return;

    Get.dialog(
      AlertDialog(
        title: const Text('Confirm Refund'),
        content: const Text(
          'Do you want to request a refund of ₹199 to your original payment method?',
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          TextButton(
            onPressed: () {
             Get.to(Refundflow3View());
            },
            child: const Text(
              'Confirm',
              style: TextStyle(color: Color(0xFFC20D4D)),
            ),
          ),
        ],
      ),
    );
  }

  void goBack() {
    Get.back();
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
