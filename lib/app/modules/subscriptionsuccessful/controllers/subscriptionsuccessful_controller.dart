import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SubscriptionsuccessfulController extends GetxController {
  //TODO: Implement SubscriptionsuccessfulController

  final count = 0.obs;


  void onStartChatting() {
    // TODO: Navigate to your chat screen.
    Get.snackbar(
      'Start Chatting',
      'Connect your chat screen navigation here.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFF7EEFC),
      colorText: const Color(0xFF211D29),
      margin: const EdgeInsets.all(16),
    );
  }

  void onViewMatches() {
    // TODO: Navigate to your matches screen.
    Get.snackbar(
      'My Matches',
      'Connect your matches screen navigation here.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFF7EEFC),
      colorText: const Color(0xFF211D29),
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
