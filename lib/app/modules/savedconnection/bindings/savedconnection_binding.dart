import 'package:get/get.dart';

import '../controllers/savedconnection_controller.dart';

class SavedconnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SavedconnectionController>(
      () => SavedconnectionController(),
    );
  }
}
