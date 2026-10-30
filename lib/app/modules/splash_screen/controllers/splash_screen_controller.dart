import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sundaymixer/app/modules/bottom/views/bottom_view.dart';
import 'package:sundaymixer/app/modules/login/views/login_view.dart';

import '../../../routes/app_pages.dart';
import '../../profile/views/profile_view.dart';

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

    final String userId = prefs.getString('userId') ?? '';
    final String token = prefs.getString('token') ?? '';
    final bool isProfileComplete =
        prefs.getBool('isProfileComplete') ?? false;

    if (userId.isNotEmpty && token.isNotEmpty) {
      if (isProfileComplete) {
        // Login and profile already completed.
        Get.offAll(() => BottomView());
      } else {
        // Login completed, profile still pending.
        Get.offAll(() => ProfileView());
      }
    } else {
      // No saved login session.
      Get.offAll(() => LoginView());
    }
  }
  @override
  void onReady() {
    super.onReady();
    print('Splash onReady Called');

    _timer = Timer(const Duration(seconds: 2), () {
      print('Navigating to Login');

      Get.offAllNamed(Routes.LOGIN);
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void increment() => count.value++;
}
