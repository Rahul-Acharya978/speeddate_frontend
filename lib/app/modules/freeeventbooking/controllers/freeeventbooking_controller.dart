import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
