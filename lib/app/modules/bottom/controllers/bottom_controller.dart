import 'package:get/get.dart';

import '../../events/controllers/events_controller.dart';
import '../../live/controllers/live_gate_controller.dart';
import '../../savedconnection/controllers/savedconnection_controller.dart';

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
    if (index == 4 && Get.isRegistered<SavedconnectionController>()) {
      Get.find<SavedconnectionController>().loadSaves();
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
