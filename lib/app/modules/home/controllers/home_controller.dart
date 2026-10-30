import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  // Existing variable - removed nahi kiya
  final count = 0.obs;

  // Profile API URL
  final String profileApiUrl =
      'https://dateapi.spinfotechindia.com/user/myprofile';

  // Profile data
  final RxString name = ''.obs;
  final RxInt age = 0.obs;
  final RxString city = ''.obs;
  final RxBool profileVerified = false.obs;
  final RxInt profileCompletionPercent = 0.obs;

  // Loading and error handling
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyProfile();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Fetch My Profile API
  Future<void> fetchMyProfile() async {
    try {
      isLoading.value = true;
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
