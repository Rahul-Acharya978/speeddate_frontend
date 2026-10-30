import 'package:get/get.dart';

import '../controllers/chat_subscription_controller.dart';

class ChatSubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatSubscriptionController>(
      () => ChatSubscriptionController(),
    );
  }
}
