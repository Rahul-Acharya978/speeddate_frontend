import 'package:get/get.dart';

import '../../chat/views/chat_view.dart';

class ConnectionProfilDetailController extends GetxController {
  //TODO: Implement ConnectionProfilDetailController

  final count = 0.obs;
  final RxBool isFavorite = true.obs;
  final RxBool isChatStarting = false.obs;
  final RxInt selectedTab = 2.obs;

  Map<String, dynamic> person = {};

  void bind(Map<String, dynamic> value) {
    person = value;
  }

  String get profileName {
    final name = person['name']?.toString().trim() ?? '';
    return name.isEmpty ? 'Member' : name;
  }

  String get firstName => profileName.split(' ').first;

  int get age {
    final value = person['age'];
    if (value is num && value > 0) return value.round();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  String get location => person['city']?.toString().trim() ?? '';

  String get photo => person['image']?.toString() ?? '';

  String get eventTitle {
    final raw = person['event']?.toString().trim() ?? '';
    final name = raw.replaceFirst(RegExp(r'^Met at '), '');
    return name.isEmpty ? 'Live event' : name;
  }

  String get eventDate {
    final date = person['date']?.toString().trim() ?? '';
    final time = person['time']?.toString().trim() ?? '';
    if (date.isEmpty) return time;
    return time.isEmpty ? date : '$date, $time';
  }

  String get conversationDuration {
    final raw = person['duration']?.toString().trim() ?? '';
    if (raw.isEmpty) return '';
    return raw.replaceAll(' conversation', '');
  }

  bool get isMutual => (person['message']?.toString() ?? '').toLowerCase().contains('both');

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
    Get.to(() => ChatView(person: person));
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
