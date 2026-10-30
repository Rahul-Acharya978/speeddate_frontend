import 'package:get/get.dart';

import '../controllers/complete_your_profile_controller.dart';

class CompleteYourProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompleteYourProfileController>(
      () => CompleteYourProfileController(),
    );
  }
}
