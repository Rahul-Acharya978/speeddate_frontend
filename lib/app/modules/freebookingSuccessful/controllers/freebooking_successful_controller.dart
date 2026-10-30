import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../freeeventselfi/views/freeeventselfi_view.dart';

class FreebookingSuccessfulController extends GetxController {
  //TODO: Implement FreebookingSuccessfulController

  final count = 0.obs;
  final String eventName = 'Creatives & Introverts';
  final String bookingId = '#FREE-SPD-94281';
  final String attendeeName = 'Raj Kumar';

  final RxBool isVerifying = false.obs;

  Future<void> copyBookingId() async {
    await Clipboard.setData(
      ClipboardData(text: bookingId),
    );

    Get.snackbar(
      'Copied',
      'Booking ID copied successfully.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  void verifyWithSelfie() {
    // Navigate to your existing selfie verification flow.
    Get.to(FreeeventselfiView());
  }

  void backToHome() {
    // Replace with your actual Home route if required.
    Get.back();
  }

  void shareBooking() {
    // Connect share_plus or your existing sharing functionality.
    Get.snackbar(
      'Share Booking',
      'Connect your booking sharing functionality here.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
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
