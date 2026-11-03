import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sundaymixer/app/data/api_config.dart';
import 'package:sundaymixer/app/modules/login/views/login_view.dart';

class UserprofileController extends GetxController {
  final count = 0.obs;
  final isLoading = false.obs;
  final name = ''.obs;
  final age = 0.obs;
  final gender = ''.obs;
  final city = ''.obs;
  final about = ''.obs;
  final photoUrl = ''.obs;
  final verified = false.obs;
  final completion = 0.obs;
  final interested = <String>[].obs;
  final professional = <String>[].obs;
  final eventsJoined = 0.obs;
  final mutualMatches = 0.obs;

  String get nameLine {
    if (name.value.isEmpty && age.value <= 0) return 'Your profile';
    if (age.value <= 0) return name.value;
    if (name.value.isEmpty) return '${age.value}';
    return '${name.value}, ${age.value}';
  }

  Future<void> loadProfile() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('tokenData') ?? prefs.getString('token') ?? '';
      if (token.isEmpty) return;

      final response = await http.get(
        Uri.parse(ApiConfig.url('/user/myprofile')),
        headers: {
          'Authorization': token.startsWith('Bearer ') ? token : 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode != 200 || response.body.isEmpty) return;
      final body = jsonDecode(response.body);
      if (body is! Map || body['success'] != true || body['data'] is! Map) return;
      final data = body['data'] as Map;

      name.value = data['name']?.toString() ?? '';
      age.value = int.tryParse(data['age']?.toString() ?? '') ?? 0;
      gender.value = data['gender']?.toString() ?? '';
      city.value = data['city']?.toString() ?? '';
      about.value = data['about']?.toString() ?? '';
      verified.value = data['profileVerified'] == true;
      completion.value = int.tryParse(data['profileCompletionPercent']?.toString() ?? '') ?? 0;
      interested.assignAll(_strings(data['interestedField']));
      professional.assignAll(_strings(data['networkingFocus']));
      eventsJoined.value = int.tryParse(data['eventsJoined']?.toString() ?? '') ?? 0;
      mutualMatches.value = int.tryParse(data['mutualMatches']?.toString() ?? '') ?? 0;
      photoUrl.value = _photoUrl(data['photo']?.toString() ?? '');
    } catch (error) {
      print('Profile load error: $error');
    } finally {
      isLoading.value = false;
    }
  }

  List<String> _strings(dynamic raw) {
    if (raw is! List) return [];
    return raw.map((item) => item.toString().trim()).where((item) => item.isNotEmpty).toList();
  }

  String _photoUrl(String path) {
    if (path.isEmpty) return '';
    if (path.startsWith('http')) return path;
    return ApiConfig.url(path.startsWith('/') ? path : '/$path');
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('token');
    await prefs.remove('tokenData');
    await prefs.remove('isProfileComplete');
    Get.offAll(() => LoginView());
  }

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  void increment() => count.value++;
}
