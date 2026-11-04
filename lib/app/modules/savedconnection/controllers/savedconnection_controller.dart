import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/api_config.dart';
import '../../../data/speed_date_api.dart';
import '../../connectionProfilDetail/views/connection_profil_detail_view.dart';

class SavedconnectionController extends GetxController {
  final count = 0.obs;
  final RxInt selectedTab = 0.obs;
  final RxInt bottomIndex = 4.obs;
  final RxBool loading = false.obs;

  final RxList<Map<String, dynamic>> theyLikedYou = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> youLiked = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> mutualLikes = <Map<String, dynamic>>[].obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  Future<void> loadSaves() async {
    loading.value = true;
    try {
      final data = await SpeedDateApi.saves();
      theyLikedYou.assignAll(_cards(data['theyLikedYou']));
      youLiked.assignAll(_cards(data['youLiked']));
      mutualLikes.assignAll(_cards(data['mutual']));
    } catch (error) {
      debugPrint('Saved profiles error: $error');
    } finally {
      loading.value = false;
    }
  }

  List<Map<String, dynamic>> _cards(dynamic raw) {
    if (raw is! List) return [];
    return raw.whereType<Map>().map((item) {
      final card = Map<String, dynamic>.from(item);
      card['image'] = _photo(card['photo']?.toString() ?? '');
      card['eventIcon'] = 'speed';
      return card;
    }).toList();
  }

  String _photo(String photo) {
    if (photo.isEmpty) return '';
    if (photo.startsWith('http')) return photo;
    return ApiConfig.url(photo);
  }

  Future<void> likeBack(Map<String, dynamic> person) async {
    final eventId = person['eventId']?.toString() ?? '';
    final partnerId = person['partnerId']?.toString() ?? '';
    if (eventId.isEmpty || partnerId.isEmpty) return;
    try {
      await SpeedDateApi.saveProfile(
        eventId: eventId,
        partnerId: partnerId,
        save: true,
        durationSeconds: 0,
      );
      await loadSaves();
      selectedTab.value = 2;
    } catch (error) {
      Get.snackbar('Could not save', error.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void startChat(Map<String, dynamic> person) {
    Get.snackbar(
      'Mutual Match',
      'Opening chat with ${person['name']}',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  void viewProfile(Map<String, dynamic> person) {
    Get.to(() => const ConnectionProfilDetailView());
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
    loadSaves();
  }
}
