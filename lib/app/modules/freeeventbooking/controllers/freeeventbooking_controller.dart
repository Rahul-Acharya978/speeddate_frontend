import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreeeventbookingController extends GetxController {
  //TODO: Implement FreeeventbookingController

  final count = 0.obs;
  final RxBool isBooking = false.obs;
  final RxBool isBooked = false.obs;

  void shareEvent() {
    Get.snackbar(
      'Share Event',
      'Connect your event sharing functionality here.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  void bookFreeEvent() {
    if (isBooking.value || isBooked.value) return;

    Get.dialog(
      AlertDialog(
        title: const Text('Book Free Event'),
        content: const Text(
          'Confirm your free booking for Creatives & Introverts? '
              'The total payable amount is ₹0.',
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();

              // Connect your booking API here.
              Get.snackbar(
                'Free Event',
                'Connect your booking API to confirm your reservation.',
                snackPosition: SnackPosition.BOTTOM,
                margin: const EdgeInsets.all(16),
              );
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

  void openProfile() {
    Get.snackbar(
      'Profile',
      'Connect your profile route here.',
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
