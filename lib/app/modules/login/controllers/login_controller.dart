import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  final TextEditingController phoneController = TextEditingController();
  final RxBool isLoading = false.obs;
  Future<Map<String, dynamic>?> sendOtp() async {
    final phone = phoneController.text.trim();

    if (!RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
      Get.snackbar('Invalid Number', 'Enter a valid 10-digit number.');
      return null;
    }

    if (isLoading.value) return null;

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse('https://dateapi.spinfotechindia.com/user/sendotp'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'phone': phone}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['code'] == 200) {
        return {'phone': phone, 'otp': data['otp'].toString()};
      }

      Get.snackbar('Error', data['status']?.toString() ?? 'Unable to send OTP');

      return null;
    } catch (e) {
      debugPrint('OTP API Error: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.');
      return null;
    } finally {
      isLoading.value = false;
    }
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
    phoneController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
