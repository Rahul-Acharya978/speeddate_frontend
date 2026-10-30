import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../connectionProfilDetail/views/connection_profil_detail_view.dart';

class SavedconnectionController extends GetxController {
  //TODO: Implement SavedconnectionController

  final count = 0.obs;
  final RxInt selectedTab = 0.obs;
  final RxInt bottomIndex = 4.obs;

  final List<Map<String, dynamic>> theyLikedYou = [
    {
      'name': 'Priya Sharma',
      'age': 27,
      'city': 'Indore',
      'message': 'Liked your profile recently',
      'event': 'Met at Friday Speed',
      'date': '23 Sep 2026',
      'time': '8:00 PM',
      'duration': '03:00 conversation',
      'badge': 'Liked You',
      'image': 'https://i.pravatar.cc/150?img=47',
      'eventIcon': 'speed',
    },
    {
      'name': 'Tanvi Joshi',
      'age': 26,
      'city': 'Bhopal',
      'message': 'Sent you a super vibe',
      'event': 'Met at Bhopal Singles Mixer',
      'date': '24 Sep 2026',
      'time': '7:30 PM',
      'duration': '03:00 conversation',
      'badge': 'Liked You',
      'image': 'https://i.pravatar.cc/150?img=44',
      'eventIcon': 'speed',
    },
    {
      'name': 'Sneha Kapoor',
      'age': 25,
      'city': 'Bengaluru',
      'message': 'Matched 92% dating vibe',
      'event': 'Met at Friday Speed',
      'date': '23 Sep 2026',
      'time': '8:15 PM',
      'duration': '03:00 conversation',
      'badge': 'Liked You',
      'image': 'https://i.pravatar.cc/150?img=49',
      'eventIcon': 'speed',
    },
    {
      'name': 'Riya Sharma',
      'age': 26,
      'city': 'Mumbai',
      'message': 'Liked your profile',
      'event': 'Met at Sunday Rooftop',
      'date': '21 Sep 2026',
      'time': '7:00 PM',
      'duration': '03:00 conversation',
      'badge': 'Liked You',
      'image': 'https://i.pravatar.cc/150?img=45',
      'eventIcon': 'coffee',
    },
    {
      'name': 'Ananya Sen',
      'age': 26,
      'city': 'Bhopal',
      'message': 'You caught her attention',
      'event': 'Met at Creatives & Introverts',
      'date': '22 Sep 2026',
      'time': '8:45 PM',
      'duration': '03:00 conversation',
      'badge': 'Liked You',
      'image': 'https://i.pravatar.cc/150?img=46',
      'eventIcon': 'coffee',
    },
  ];

  final List<Map<String, dynamic>> youLiked = [
    {
      'name': 'Ananya Sen',
      'age': 26,
      'city': 'Mumbai',
      'message': 'You saved Ananya. Waiting for her to save you.',
      'event': 'Met at Sunday Rooftop',
      'date': '21 Sep 2026',
      'time': '7:30 PM',
      'duration': '03:00 conversation',
      'image': 'https://i.pravatar.cc/150?img=46',
      'eventIcon': 'sun',
    },
    {
      'name': 'Meera Rajput',
      'age': 27,
      'city': 'Indore',
      'message': 'You saved Meera. Waiting for her to save you.',
      'event': 'Met at Friday Speed',
      'date': '23 Sep 2026',
      'time': '8:30 PM',
      'duration': '03:00 conversation',
      'image': 'https://i.pravatar.cc/150?img=48',
      'eventIcon': 'speed',
    },
    {
      'name': 'Kriti Sanon',
      'age': 25,
      'city': 'Delhi',
      'message': 'You saved Kriti. Waiting for her response.',
      'event': 'Met at Coffee & Connections',
      'date': '20 Sep 2026',
      'time': '6:00 PM',
      'duration': '03:00 conversation',
      'image': 'https://i.pravatar.cc/150?img=43',
      'eventIcon': 'coffee',
    },
  ];

  final List<Map<String, dynamic>> mutualLikes = [
    {
      'name': 'Riya Sharma',
      'age': 27,
      'city': 'Indore',
      'message': 'You both saved each other',
      'event': 'Met at Friday Speed',
      'date': '23 Sep 2026',
      'time': '8:00 PM',
      'duration': '03:00 conversation',
      'image': 'https://i.pravatar.cc/150?img=45',
      'eventIcon': 'speed',
    },
    {
      'name': 'Sneha Kapoor',
      'age': 25,
      'city': 'Bengaluru',
      'message': 'You both saved each other',
      'event': 'Met at Friday Speed',
      'date': '23 Sep 2026',
      'time': '8:15 PM',
      'duration': '03:00 conversation',
      'image': 'https://i.pravatar.cc/150?img=49',
      'eventIcon': 'speed',
    },
    {
      'name': 'Ananya S.',
      'age': 26,
      'city': 'Bhopal',
      'message': 'You both saved each other',
      'event': 'Met at Creatives & Introverts',
      'date': '22 Sep 2026',
      'time': '8:45 PM',
      'duration': '03:00 conversation',
      'image': 'https://i.pravatar.cc/150?img=46',
      'eventIcon': 'coffee',
    },
  ];

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void changeBottomTab(int index) {
    bottomIndex.value = index;

    // Connect your actual app routes here.
    // Example: Get.offNamed(Routes.HOME);
  }

  void likeBack(Map<String, dynamic> person) {
    Get.snackbar(
      'Liked!',
      'You liked ${person['name']} back.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFFCE7F3),
      colorText: const Color(0xFFBE185D),
      margin: const EdgeInsets.all(16),
    );
  }

  void startChat(Map<String, dynamic> person) {
    Get.snackbar(
      'Mutual Match',
      'Opening chat with ${person['name']}',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );

    // Navigate to your ChatView here.
  }

  void viewProfile(Map<String, dynamic> person) {
    Get.to(ConnectionProfilDetailView());

    // Navigate to your profile details page here.
  }

  List<Map<String, dynamic>> get currentList {
    switch (selectedTab.value) {
      case 0:
        return theyLikedYou;
      case 1:
        return youLiked;
      default:
        return mutualLikes;
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
