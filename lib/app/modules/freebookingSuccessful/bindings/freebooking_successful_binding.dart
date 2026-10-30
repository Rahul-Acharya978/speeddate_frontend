import 'package:get/get.dart';

import '../controllers/freebooking_successful_controller.dart';

class FreebookingSuccessfulBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FreebookingSuccessfulController>(
      () => FreebookingSuccessfulController(),
    );
  }
}
