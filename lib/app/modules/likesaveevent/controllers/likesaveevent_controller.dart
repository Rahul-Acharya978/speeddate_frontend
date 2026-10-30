import 'package:get/get.dart';

class LikesaveeventController extends GetxController {
  //TODO: Implement LikesaveeventController

  final count1 = 0.obs;
  final RxList<SavedEvent> savedEvents = <SavedEvent>[
    SavedEvent(
      id: '1',
      image:
      'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=900',
      badge: '♧ Popular',
      title: 'Friday Night Speed Dating',
      category: 'Indore',
      date: '25 Sep',
      time: '7:30 PM',
      location: 'Downtown Cafe, Old Palasia',
      price: '₹249',
      joined: '24 joined',
      avatars: ['E', 'M', 'S'],
    ),
    SavedEvent(
      id: '2',
      image:
      'https://images.unsplash.com/photo-1528605248644-14dd04022da1?w=900',
      badge: 'ϟ Selling Fast',
      title: 'Coffee & Connections',
      category: 'Speed Rounds',
      date: '27 Sep',
      time: '6:00 PM',
      location: 'Bean House, Vijay Nagar',
      price: '₹199',
      joined: '18 joined',
      avatars: ['J', 'L'],
    ),
    SavedEvent(
      id: '3',
      image:
      'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=900',
      badge: '✧ Curated Singles',
      title: 'Weekend Singles Meetup',
      category: 'Rooftop',
      date: '29 Sep',
      time: '7:00 PM',
      location: 'Sky Lounge, AB Road',
      price: '₹299',
      joined: '32 joined',
      avatars: ['A', 'D', 'K'],
    ),
  ].obs;

  final RxBool simulateEmpty = false.obs;

  int get count => savedEvents.length;

  List<SavedEvent> get visibleEvents {
    if (simulateEmpty.value) {
      return [];
    }
    return savedEvents.toList();
  }

  void toggleFavorite(String id) {
    savedEvents.removeWhere((event) => event.id == id);
  }

  void toggleSimulateEmpty() {
    simulateEmpty.toggle();
  }

  void restoreEvents() {
    simulateEmpty.value = false;
  }
  void openEvent(SavedEvent event) {
    Get.snackbar(
      'Event Details',
      event.title,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
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

  void increment() => count1.value++;
}

class SavedEvent {
  final String id;
  final String image;
  final String badge;
  final String title;
  final String category;
  final String date;
  final String time;
  final String location;
  final String price;
  final String joined;
  final List<String> avatars;

  SavedEvent({
    required this.id,
    required this.image,
    required this.badge,
    required this.title,
    required this.category,
    required this.date,
    required this.time,
    required this.location,
    required this.price,
    required this.joined,
    required this.avatars,
  });
}

