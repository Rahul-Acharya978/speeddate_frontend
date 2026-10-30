import 'package:get/get.dart';

import '../controllers/freeeventselfi_controller.dart';

class FreeeventselfiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FreeeventselfiController>(
      () => FreeeventselfiController(),
    );
  }
}
