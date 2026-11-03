import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sundaymixer/app/modules/freebookingSuccessful/views/freebooking_successful_view.dart';
import 'package:sundaymixer/app/modules/freeeventselfi/views/freeeventselfi_view.dart';
import 'package:sundaymixer/app/modules/home/controllers/home_controller.dart';

class FreeeventbookingController extends GetxController {
  //TODO: Implement FreeeventbookingController

  final count = 0.obs;
  final RxBool isBooking = false.obs;
  final RxBool isBooked = false.obs;
  HomeEvent? event;

  String get title => event?.title ?? 'Creatives & Introverts';
  String get subtitle => event?.subtitle.isNotEmpty == true
      ? event!.subtitle
      : 'Host: Ananya • SpeedLounge';
  String get city => event?.city.isNotEmpty == true ? event!.city : 'Indore';
  String get timeLabel => event?.timeLabel.isNotEmpty == true ? event!.timeLabel : '8:00 PM';
  String get startsLabel =>
      (event?.scheduleLabel.contains('TONIGHT') ?? true) ? 'STARTS TONIGHT' : 'STARTS SOON';
  String get whenLabel => event == null
      ? 'Today • 8:00 PM'
      : '${event!.dateLabel} • ${event!.timeLabel}';
  String get spotsLabel => event?.joinedLabel ?? '18 spots left';
  String get roundsLabel => '${event?.meetMinutes ?? 3}-min\nchats';
  bool get isFree => event?.isFree ?? true;
  String get priceLabel => event?.priceLabel.isNotEmpty == true ? event!.priceLabel : '₹0';

  void shareEvent() {
    Get.snackbar(
      'Share Event',
      'Connect your event sharing functionality here.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  Future<void> continueToBook() async {
    if (isBooking.value) return;
    isBooking.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('tokenData') ?? prefs.getString('token') ?? '';
      if (token.isEmpty) {
        Get.snackbar('Login', 'Please login again.', snackPosition: SnackPosition.BOTTOM);
        return;
      }
      final response = await http.get(
        Uri.parse('https://dateapi.spinfotechindia.com/user/myprofile'),
        headers: {
          'Authorization': token.startsWith('Bearer ') ? token : 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      final body = jsonDecode(response.body);
      final data = body is Map ? body['data'] : null;
      final verified = data is Map && data['profileVerified'] == true;
      final submitted = data is Map && data['selfieSubmitted'] == true;
      if (verified || submitted) {
        Get.to(() => const FreebookingSuccessfulView());
        return;
      }
      Get.to(() => const FreeeventselfiView());
    } catch (_) {
      Get.snackbar(
        'Booking',
        'Could not check verification. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isBooking.value = false;
    }
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
