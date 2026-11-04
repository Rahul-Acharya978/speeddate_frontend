import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sundaymixer/app/data/api_config.dart';

class HomeEvent {
  HomeEvent({
    required this.id,
    required this.title,
    required this.details,
    required this.city,
    required this.subtitle,
    required this.dateLabel,
    required this.timeLabel,
    required this.scheduleLabel,
    required this.priceLabel,
    required this.isFree,
    required this.meetMinutes,
    required this.joinedLabel,
    required this.startsAt,
    required this.isLive,
    required this.booked,
  });

  final String id;
  final String title;
  final String details;
  final String city;
  final String subtitle;
  final String dateLabel;
  final String timeLabel;
  final String scheduleLabel;
  final String priceLabel;
  final bool isFree;
  final int meetMinutes;
  final String joinedLabel;
  final DateTime? startsAt;
  final bool isLive;
  final bool booked;

  factory HomeEvent.fromJson(Map<String, dynamic> json) {
    final rawStart = json['startsAt']?.toString();
    return HomeEvent(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      details: json['details']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      subtitle: json['subtitle']?.toString() ?? '',
      dateLabel: json['dateLabel']?.toString() ?? '',
      timeLabel: json['timeLabel']?.toString() ?? '',
      scheduleLabel: json['scheduleLabel']?.toString() ?? '',
      priceLabel: json['priceLabel']?.toString() ?? '',
      isFree: json['isFree'] == true,
      meetMinutes: int.tryParse(json['meetMinutes']?.toString() ?? '') ?? 3,
      joinedLabel: json['joinedLabel']?.toString() ?? '0 joined',
      startsAt: rawStart == null
          ? null
          : DateTime.tryParse(rawStart)?.toLocal(),
      isLive: json['isLive'] == true,
      booked: json['booked'] == true,
    );
  }
}

class HomeController extends GetxController {
  // Existing variable - removed nahi kiya
  final count = 0.obs;

  // Profile API URL
  final String profileApiUrl =
      ApiConfig.url('/user/myprofile');
  final String homeEventsApiUrl =
      ApiConfig.url('/home/events');

  // Profile data
  final RxString name = ''.obs;
  final RxInt age = 0.obs;
  final RxString city = ''.obs;
  final RxBool profileVerified = false.obs;
  final RxBool selfieSubmitted = false.obs;
  final RxInt profileCompletionPercent = 0.obs;

  // Loading and error handling
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isEventsLoading = false.obs;
  final Rxn<HomeEvent> bookedEvent = Rxn<HomeEvent>();
  final RxList<HomeEvent> liveEvents = <HomeEvent>[].obs;
  final RxList<HomeEvent> upcomingEvents = <HomeEvent>[].obs;
  final RxList<HomeEvent> yourUpcomingEvents = <HomeEvent>[].obs;
  final Rx<DateTime> clock = DateTime.now().obs;
  Timer? _clockTimer;

  @override
  void onInit() {
    super.onInit();
    fetchMyProfile();
    fetchHomeEvents();
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      clock.value = DateTime.now();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _clockTimer?.cancel();
    super.onClose();
  }

  String startsInLabel(HomeEvent event) {
    clock.value;
    final start = event.startsAt;
    if (start == null) return event.isLive ? 'LIVE NOW' : 'STARTS SOON';
    final diff = start.difference(DateTime.now());
    if (diff.inSeconds <= 0 || event.isLive) return 'LIVE NOW';
    final hours = diff.inHours;
    final minutes = diff.inMinutes.remainder(60);
    final seconds = diff.inSeconds.remainder(60);
    if (hours > 0) {
      return 'STARTS IN ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
    }
    return 'STARTS IN ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> refreshHome() {
    return Future.wait([
      fetchMyProfile(showLoader: false),
      fetchHomeEvents(showLoader: false),
    ]);
  }

  Future<void> fetchHomeEvents({bool showLoader = true}) async {
    try {
      if (showLoader) isEventsLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final token =
          prefs.getString('tokenData') ?? prefs.getString('token') ?? '';
      if (token.isEmpty) return;

      final response = await http.get(
        Uri.parse(homeEventsApiUrl),
        headers: {
          'Authorization': token.startsWith('Bearer ')
              ? token
              : 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode != 200) return;
      final responseData = jsonDecode(response.body);
      if (responseData['success'] != true) return;
      final data = responseData['data'] as Map<String, dynamic>? ?? {};

      final bookedRaw = data['bookedEvent'];
      bookedEvent.value = bookedRaw is Map
          ? HomeEvent.fromJson(Map<String, dynamic>.from(bookedRaw))
          : null;
      liveEvents.assignAll(_readEvents(data['liveEvents']));
      upcomingEvents.assignAll(_readEvents(data['upcomingEvents']));
      yourUpcomingEvents.assignAll(_readEvents(data['yourUpcomingEvents']));
    } catch (e) {
      print('Home events API Error: $e');
    } finally {
      isEventsLoading.value = false;
    }
  }

  List<HomeEvent> _readEvents(dynamic raw) {
    if (raw is! List) return [];
    return raw
        .whereType<Map>()
        .map((item) => HomeEvent.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  // Fetch My Profile API
  Future<void> fetchMyProfile({bool showLoader = true}) async {
    try {
      if (showLoader) isLoading.value = true;
      errorMessage.value = '';

      final prefs = await SharedPreferences.getInstance();

      // Token saved in SharedPreferences
      final token =
          prefs.getString('tokenData') ?? prefs.getString('token') ?? '';
      print("Token : $token");
      if (token.isEmpty) {
        errorMessage.value =
            'Authentication token not found. Please login again.';
        return;
      }

      final response = await http.get(
        Uri.parse(profileApiUrl),
        headers: {
          'Authorization': token.startsWith('Bearer ')
              ? token
              : 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print('Profile API Status: ${response.statusCode}');
      print('Profile API Response: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['success'] == true) {
          final data = responseData['data'];

          name.value = data['name']?.toString() ?? '';
          age.value = int.tryParse(data['age']?.toString() ?? '') ?? 0;
          city.value = data['city']?.toString() ?? '';

          profileVerified.value = data['profileVerified'] == true;
          selfieSubmitted.value = data['selfieSubmitted'] == true;

          profileCompletionPercent.value =
              int.tryParse(
                data['profileCompletionPercent']?.toString() ?? '',
              ) ??
              0;
        } else {
          errorMessage.value =
              responseData['message']?.toString() ?? 'Unable to fetch profile.';
        }
      } else if (response.statusCode == 401) {
        errorMessage.value = 'Session expired. Please login again.';
      } else {
        errorMessage.value =
            'Failed to fetch profile. Status: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Something went wrong: $e';
      print('Profile API Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Existing method - removed nahi kiya
  void increment() => count.value++;
}
