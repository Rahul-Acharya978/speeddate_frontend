import 'package:get/get.dart';

import '../../chatSubscription/views/chat_subscription_view.dart';

class ConnectionProfilDetailController extends GetxController {
  //TODO: Implement ConnectionProfilDetailController

  final count = 0.obs;
  final RxBool isFavorite = true.obs;
  final RxBool isChatStarting = false.obs;
  final RxInt selectedTab = 2.obs;

  final String profileName = 'Riya Sharma';
  final int age = 27;
  final String location = 'Indore, India';
  final String eventName = 'Friday Speed Dating Night';
  final String eventDate = '23 Sep 2026, 8:00 PM';
  final String conversationDuration = '03:00 min';

  final List<String> interests = [
    '✈️ Travel',
    '♫ Music',
    '☕ Coffee',
    '🎬 Movies',
  ];

  void toggleFavorite() {
    isFavorite.toggle();
  }

  void startChat() {
    isChatStarting.value = true;

   Get.to(ChatSubscriptionView());

    isChatStarting.value = false;
  }

  void onTabSelected(int index) {
    selectedTab.value = index;

    // Connect your actual GetX routes here.
    if (index != 2) {
      Get.snackbar(
        'Navigation',
        'Connect the ${['Home', 'Events', 'Live', 'Chat', 'Profile'][index]} route.',
        snackPosition: SnackPosition.BOTTOM,
      );
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
