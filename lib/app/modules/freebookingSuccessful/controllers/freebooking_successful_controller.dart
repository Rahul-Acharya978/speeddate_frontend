import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sundaymixer/app/data/api_config.dart';

import '../../freeeventselfi/views/freeeventselfi_view.dart';

class FreebookingSuccessfulController extends GetxController {
  //TODO: Implement FreebookingSuccessfulController

  final count = 0.obs;
  final String eventName = 'Creatives & Introverts';
  final String bookingId = '#FREE-SPD-94281';
  final String attendeeName = 'Raj Kumar';

  final RxBool isVerifying = false.obs;
  final RxBool showSelfie = false.obs;

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
    loadSelfiePrompt();
  }

  Future<void> loadSelfiePrompt() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('tokenData') ?? prefs.getString('token') ?? '';
      if (token.isEmpty) return;
      final response = await http.get(
        Uri.parse(ApiConfig.url('/user/myprofile')),
        headers: {
          'Authorization': token.startsWith('Bearer ') ? token : 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode != 200) return;
      final body = jsonDecode(response.body);
      final data = body is Map ? body['data'] : null;
      if (data is! Map) return;
      final required = data['selfieRequired'] == true;
      final verified = data['profileVerified'] == true;
      final submitted = data['selfieSubmitted'] == true;
      showSelfie.value = required && !verified && !submitted;
    } catch (_) {}
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
