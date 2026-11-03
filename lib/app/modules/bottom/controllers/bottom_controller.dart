import 'package:get/get.dart';

import '../../events/controllers/events_controller.dart';
import '../../live/controllers/live_gate_controller.dart';
import '../../userprofile/controllers/userprofile_controller.dart';

class BottomController extends GetxController {
  //TODO: Implement BottomController

  final count = 0.obs;
  final RxInt selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
    if (index == 1 && Get.isRegistered<EventsController>()) {
      Get.find<EventsController>().fetchEvents();
    }
    if (index == 2 && Get.isRegistered<LiveGateController>()) {
      Get.find<LiveGateController>().begin();
    }
    if (index == 4 && Get.isRegistered<UserprofileController>()) {
      Get.find<UserprofileController>().loadProfile();
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
