import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sundaymixer/app/modules/bottom/views/bottom_view.dart';
import 'package:sundaymixer/app/modules/login/views/login_view.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController

  final count = 0.obs;
  Timer? _timer;
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
    print('Splash Controller Initialized');
  }
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();

    final String token =
        prefs.getString('token') ?? prefs.getString('tokenData') ?? '';

    if (token.isNotEmpty) {
      Get.offAll(() => BottomView());
    } else {
      Get.offAll(() => LoginView());
    }
  }
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void increment() => count.value++;
}
