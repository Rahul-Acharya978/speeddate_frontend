import 'package:get/get.dart';

import '../controllers/freeeventbooking_controller.dart';

class FreeeventbookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FreeeventbookingController>(
      () => FreeeventbookingController(),
    );
  }
}
