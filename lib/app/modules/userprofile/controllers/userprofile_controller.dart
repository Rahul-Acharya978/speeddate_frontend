import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sundaymixer/app/modules/login/views/login_view.dart';

class UserprofileController extends GetxController {
  //TODO: Implement UserprofileController

  final count = 0.obs;

  void logout()async{
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('userId');
    await prefs.remove('token');
    await prefs.remove('isProfileComplete');

    Get.offAll(()=>LoginView());
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
