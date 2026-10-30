import 'package:get/get.dart';

import '../controllers/refundflow1_controller.dart';

class Refundflow1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Refundflow1Controller>(
      () => Refundflow1Controller(),
    );
  }
}
