import 'package:get/get.dart';

import '../controllers/waitingroom_controller.dart';

class WaitingroomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WaitingroomController>(
      () => WaitingroomController(),
    );
  }
}
