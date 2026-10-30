import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sundaymixer/app/modules/bottom/views/bottom_view.dart';

import '../../profile/views/profile_view.dart';

class OtpscreenController extends GetxController {
  //TODO: Implement OtpscreenController

  final count = 0.obs;
  final otp = ''.obs;
  final phoneNumber = '+91 98765 43210'.obs;
  final seconds = 28.obs;

  final textController = TextEditingController();
  final focusNode = FocusNode();

  Timer? _timer;
  // API response variables
  String userId = '';
  String token = '';
  String verificationStatus = '';
  bool isNew = false;
  final RxBool isLoading = false.obs;
  String get formattedTime {
    final m = (seconds.value ~/ 60).toString().padLeft(2, '0');
    final s = (seconds.value % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    if (args is Map) {
      final phone = args['phone']?.toString() ?? '';
      final receivedOtp = args['otp']?.toString() ?? '';

      phoneNumber.value = phone;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (receivedOtp.isNotEmpty) {
          Get.snackbar(
            'Your OTP',
            'Your OTP is $receivedOtp',
            duration: const Duration(seconds: 10),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      });
    }

    startTimer();
  }

  void openKeyboard() {
    focusNode.requestFocus();
  }

  void onOtpChanged(String value) {
    otp.value = value;

    if (value.length == 4) {
      // Keyboard stays open so the user can review the OTP.
      // Call verifyOtp automatically here if your flow requires it.
    }
  }

  void startTimer() {
    _timer?.cancel();
    seconds.value = 28;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void resendOtp() {
    otp.value = '';
    textController.clear();
    startTimer();

    // TODO: Call your actual resend OTP API.
    Get.snackbar(
      'OTP',
      'Connect your resend OTP API here.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> verifyOtp() async {
    final args = Get.arguments;

    final String phone = args is Map
        ? (args['phone']?.toString() ?? '').trim()
        : '';

    // OTP input field se actual entered value
    final String enteredOtp = textController.text.trim().isNotEmpty
        ? textController.text.trim()
        : otp.value.trim();

    if (phone.isEmpty) {
      Get.snackbar('Error', 'Phone number not found.');
      return;
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
      Get.snackbar('Error', 'Phone number must contain 10 digits.');
      return;
    }

    if (!RegExp(r'^[0-9]{4}$').hasMatch(enteredOtp)) {
      Get.snackbar(
        'Invalid OTP',
        'Please enter the complete 4-digit OTP.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (isLoading.value) return;

    try {
      isLoading.value = true;
      focusNode.unfocus();

      final response = await http.post(
        Uri.parse('https://dateapi.spinfotechindia.com/user/verifyotp'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'phone': phone, 'otp': enteredOtp}),
      );

      debugPrint('Verify response code: ${response.statusCode}');
      debugPrint('Verify response body: ${response.body}');

      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 && data['code'] == 200) {
        userId = data['userId']?.toString() ?? '';
        token = data['token']?.toString() ?? '';
        isNew = data['isNew'] == true;
        verificationStatus = data['status']?.toString() ?? '';

        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('userId', userId);
        await prefs.setString('token', token);
        await prefs.setBool('isNew', isNew);
        await prefs.setString('verificationStatus', verificationStatus);
        await prefs.setString('phone', phone);
        print("Token :$token");
        Get.snackbar(
          'Success',
          verificationStatus,
          snackPosition: SnackPosition.BOTTOM,
        );

        final bool isProfileComplete =
            prefs.getBool('isProfileComplete') ?? false;

        if (isProfileComplete) {
          Get.offAll(()=>BottomView());
        } else {
          Get.offAll(() => ProfileView());
        }
      } else {
        Get.snackbar(
          'Verification Failed',
          data['status']?.toString() ?? 'Invalid OTP. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint('Verify OTP error: $e');

      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _timer?.cancel();
    textController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
