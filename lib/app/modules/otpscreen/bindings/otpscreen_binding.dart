import 'package:get/get.dart';

import '../controllers/otpscreen_controller.dart';

class OtpscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpscreenController>(
      () => OtpscreenController(),
    );
  }
}
