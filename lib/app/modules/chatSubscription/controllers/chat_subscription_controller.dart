import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../subscriptionsuccessful/views/subscriptionsuccessful_view.dart';

class ChatSubscriptionController extends GetxController {
  //TODO: Implement ChatSubscriptionController

  final count = 0.obs;
  void onSubscribe() {
   Get.to(SubscriptionsuccessfulView());
  }

  void onMaybeLater() {
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
