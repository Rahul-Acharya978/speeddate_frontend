import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Refundflow3Controller extends GetxController {
  //TODO: Implement Refundflow3Controller

  final count = 0.obs;
  final RxInt bottomIndex = 2.obs;

  final String eventName = 'Friday Night Sparks';
  final String refundAmount = '₹199';
  final String paymentMethod = 'Original payment method\n(UPI / Bank)';
  final String referenceNumber = 'RF-849201';
  final String requestDate = 'Today, 8:14 PM';

  void selectBottomTab(int index) {
    bottomIndex.value = index;

    // Connect your existing Home, Events, Live, Chat
    // and Profile routes here.
  }

  Future<void> copyReference() async {
    await Clipboard.setData(ClipboardData(text: referenceNumber));

    Get.snackbar(
      'Copied',
      'Refund reference number copied.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );
  }

  void backToHome() {
    // Replace with your actual Home route if needed.
    Get.back();
  }

  void viewEventDetails() {
    // Navigate to your existing event details screen.
    Get.snackbar(
      'Event Details',
      'Connect your event details route here.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  void showHelp() {
    Get.dialog(
      AlertDialog(
        title: const Text('Refund Status'),
        content: const Text(
          'Your refund request has been initiated. '
          'The payment provider may take 2–5 business days '
          'to process the refund.',
        ),
        actions: [TextButton(onPressed: Get.back, child: const Text('OK'))],
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
