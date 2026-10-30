import 'package:get/get.dart';

import '../controllers/subscriptionsuccessful_controller.dart';

class SubscriptionsuccessfulBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionsuccessfulController>(
      () => SubscriptionsuccessfulController(),
    );
  }
}
