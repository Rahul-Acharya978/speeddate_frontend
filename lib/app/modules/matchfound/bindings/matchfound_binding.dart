import 'package:get/get.dart';

import '../controllers/matchfound_controller.dart';

class MatchfoundBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MatchfoundController>(
      () => MatchfoundController(),
    );
  }
}
