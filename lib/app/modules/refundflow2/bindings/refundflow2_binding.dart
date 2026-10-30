import 'package:get/get.dart';

import '../controllers/refundflow2_controller.dart';

class Refundflow2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Refundflow2Controller>(
      () => Refundflow2Controller(),
    );
  }
}
