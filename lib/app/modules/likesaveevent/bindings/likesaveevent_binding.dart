import 'package:get/get.dart';

import '../controllers/likesaveevent_controller.dart';

class LikesaveeventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LikesaveeventController>(
      () => LikesaveeventController(),
    );
  }
}
