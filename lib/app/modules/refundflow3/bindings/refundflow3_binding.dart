import 'package:get/get.dart';

import '../controllers/refundflow3_controller.dart';

class Refundflow3Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Refundflow3Controller>(
      () => Refundflow3Controller(),
    );
  }
}
