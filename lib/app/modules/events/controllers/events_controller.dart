import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sundaymixer/app/data/api_config.dart';

import '../../home/controllers/home_controller.dart';

class EventsController extends GetxController {
  final count = 0.obs;
  final selectedTab = 0.obs;

  final activeCities = <String>{}.obs;
  final selectedDate = ''.obs;
  final favorites = <int>{}.obs;
  final cities = <String>[].obs;
  final isLoading = false.obs;

  final dates = [
    'Today',
    'Tomorrow',
    'Next Week',
    'This Month',
    'Next Month',
  ];

  final liveEvents = <Map<String, dynamic>>[].obs;
  final upcomingEvents = <Map<String, dynamic>>[].obs;

  static const _images = [
    'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?auto=format&fit=crop&w=900&q=80',
    'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=900&q=80',
    'https://images.unsplash.com/photo-1521737711867-e3b97375f902?auto=format&fit=crop&w=900&q=80',
    'https://images.unsplash.com/photo-1511988617509-a57c8a288659?auto=format&fit=crop&w=900&q=80',
  ];

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void toggleCity(String city) {
    if (activeCities.contains(city)) {
      activeCities.remove(city);
    } else {
      activeCities.add(city);
    }
  }

  void toggleFavorite(int index) {
    if (favorites.contains(index)) {
      favorites.remove(index);
    } else {
      favorites.add(index);
    }
  }

  void selectDate(String date) {
    selectedDate.value = selectedDate.value == date ? '' : date;
  }

  void clearFilters() {
    activeCities.clear();
    selectedDate.value = '';
  }

  void applyFilters() {
    Get.back();
  }

  List<Map<String, dynamic>> get filteredLiveEvents {
    return liveEvents.where((event) => _matchesCity(event)).toList();
  }

  List<Map<String, dynamic>> get filteredUpcomingEvents {
    return upcomingEvents
        .where((event) => _matchesCity(event) && _matchesDate(event['startsAt'] as DateTime?))
        .toList();
  }

  bool _matchesCity(Map<String, dynamic> event) {
    if (activeCities.isEmpty) return true;
    return activeCities.contains(event['city']);
  }

  bool _matchesDate(DateTime? start) {
    final filter = selectedDate.value;
    if (filter.isEmpty) return true;
    if (start == null) return false;

    final now = DateTime.now();
    final day = DateTime(start.year, start.month, start.day);
    final today = DateTime(now.year, now.month, now.day);

    switch (filter) {
      case 'Today':
        return day == today;
      case 'Tomorrow':
        return day == today.add(const Duration(days: 1));
      case 'Next Week':
        final from = today.add(const Duration(days: 2));
        final until = today.add(const Duration(days: 8));
        return !day.isBefore(from) && day.isBefore(until);
      case 'This Month':
        return start.year == now.year && start.month == now.month && !day.isBefore(today);
      case 'Next Month':
        final next = DateTime(now.year, now.month + 1, 1);
        return start.year == next.year && start.month == next.month;
      default:
        return true;
    }
  }

  Future<void> fetchEvents({bool showLoader = true}) async {
    try {
      if (showLoader) isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('tokenData') ?? prefs.getString('token') ?? '';
      if (token.isEmpty) return;

      final response = await http.get(
        Uri.parse(ApiConfig.url('/home/events')),
        headers: {
          'Authorization': token.startsWith('Bearer ') ? token : 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode != 200) return;

      final body = jsonDecode(response.body);
      if (body is! Map || body['success'] != true) return;
      final data = body['data'] is Map ? body['data'] as Map : {};

      final live = _readEvents(data['browseLive'] ?? data['liveEvents'], live: true);
      final upcoming = _readEvents(
        data['browseUpcoming'] ?? data['upcomingEvents'],
        live: false,
      );
      liveEvents.assignAll(live);
      upcomingEvents.assignAll(upcoming);

      final names = <String>{
        ...live.map((item) => item['city']?.toString() ?? ''),
        ...upcoming.map((item) => item['city']?.toString() ?? ''),
      }..removeWhere((city) => city.isEmpty);
      cities.assignAll(names.toList()..sort());
      activeCities.removeWhere((city) => !names.contains(city));
    } catch (error) {
      print('Events API Error: $error');
    } finally {
      isLoading.value = false;
    }
  }

  List<Map<String, dynamic>> _readEvents(dynamic raw, {required bool live}) {
    if (raw is! List) return [];
    final events = raw
        .whereType<Map>()
        .map((item) => HomeEvent.fromJson(Map<String, dynamic>.from(item)))
        .toList();

    return events.asMap().entries.map((entry) {
      final event = entry.value;
      final place = event.subtitle.trim().isEmpty ? event.city : event.subtitle.trim();
      return {
        'event': event,
        'title': event.title.isEmpty ? 'Speed dating' : event.title,
        'city': event.city,
        'venue': place,
        'price': event.isFree ? 'Free' : event.priceLabel,
        'joinedLabel': event.joinedLabel,
        'spotsLabel': live ? 'Live now' : event.timeLabel,
        'bookedLabel': event.joinedLabel,
        'time': event.isLive ? 'LIVE NOW' : event.scheduleLabel,
        'date': '${event.dateLabel} • ${event.timeLabel}',
        'tag': event.isFree ? 'Free entry' : 'Upcoming',
        'image': _images[entry.key % _images.length],
        'startsAt': event.startsAt,
      };
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  void increment() => count.value++;
}
