import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatscreenController extends GetxController {
  //TODO: Implement ChatscreenController

  final count = 0.obs;
  final searchController = TextEditingController();

  final RxString searchQuery = ''.obs;
  final RxString sortBy = 'Active First'.obs;
  final RxInt selectedTab = 3.obs;

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  void changeSort(String value) {
    sortBy.value = value;
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  List<ChatItem> get filteredChats {
    final query = searchQuery.value.trim().toLowerCase();

    final result = sampleChats.where((chat) {
      return chat.name.toLowerCase().contains(query) ||
          chat.message.toLowerCase().contains(query);
    }).toList();

    if (sortBy.value == 'Active First') {
      result.sort((a, b) {
        if (a.isOnline == b.isOnline) return 0;
        return a.isOnline ? -1 : 1;
      });
    } else {
      result.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    }

    return result;
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
    searchController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
class ChatItem {
  final String name;
  final String image;
  final String message;
  final String time;
  final String badge;
  final int unreadCount;
  final bool isOnline;
  final bool isVerified;
  final bool isRead;
  final int sortOrder;

  const ChatItem({
    required this.name,
    required this.image,
    required this.message,
    required this.time,
    this.badge = '',
    this.unreadCount = 0,
    this.isOnline = false,
    this.isVerified = false,
    this.isRead = false,
    required this.sortOrder,
  });
}

const List<ChatItem> sampleChats = [
  ChatItem(
    name: 'Riya Sharma',
    image: 'photo-1494790108377-be9c29b29330',
    message: 'Had a great time talking to you 😊',
    time: '2m',
    badge: '⚡ Speed Date Match',
    unreadCount: 1,
    isOnline: true,
    isVerified: true,
    sortOrder: 1,
  ),
  ChatItem(
    name: 'Ankit',
    image: 'photo-1500648767791-00dcc994a43e',
    message: "Let's catch up again.",
    time: '1h',
    badge: 'Mutual Pass',
    unreadCount: 2,
    sortOrder: 2,
  ),
  ChatItem(
    name: 'Sneha K.',
    image: 'photo-1534528741775-53994a69daeb',
    message: "Are you attending Friday's indie cafe?",
    time: 'Yesterday',
    isVerified: true,
    isRead: true,
    sortOrder: 3,
  ),
  ChatItem(
    name: 'Tanvi Verma',
    image: 'photo-1524504388940-b1c1722653e1',
    message: 'Thanks for the book recommendation.',
    time: '3d',
    isRead: true,
    sortOrder: 4,
  ),
];