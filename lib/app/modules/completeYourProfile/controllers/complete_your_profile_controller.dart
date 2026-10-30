import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CompleteYourProfileController extends GetxController {
  final count = 0.obs;
  final RxInt completion = 0.obs;

  // Existing single city field retained for compatibility.
  final RxString selectedCity = 'Indore'.obs;

  // Multiple city selection.
  final RxList<String> selectedCities = <String>['Indore'].obs;

  final String profileApiUrl =
      'https://dateapi.spinfotechindia.com/user/myprofile';

  final String completeProfileApiUrl =
      'https://dateapi.spinfotechindia.com/user/completeprofile';

  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<String> cities = <String>[].obs;
  final RxBool isCitiesLoading = false.obs;

  Future<void> fetchCities() async {
    try {
      isCitiesLoading.value = true;

      final response = await http.get(
        Uri.parse(
          'https://dateapi.spinfotechindia.com/user/getcity?page=0&limit=10',
        ),
        headers: {'Accept': 'application/json'},
      );

      debugPrint('Cities API Status: ${response.statusCode}');
      debugPrint('Cities API Response: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            jsonDecode(response.body) as Map<String, dynamic>;

        if (responseData['success'] == true && responseData['data'] is List) {
          final List<String> apiCities = (responseData['data'] as List)
              .where(
                (item) =>
                    item is Map &&
                    item['name'] != null &&
                    item['isDisabled'] != true,
              )
              .map<String>((item) => item['name'].toString())
              .toList();

          cities.assignAll(apiCities);

          // Keep existing selected cities that are still available.
          final availableSelectedCities = selectedCities
              .where((city) => cities.contains(city))
              .toList();

          if (availableSelectedCities.isNotEmpty) {
            selectedCities.assignAll(availableSelectedCities);
            selectedCity.value = selectedCities.first;
          } else if (cities.isNotEmpty) {
            selectedCities.assignAll([cities.first]);
            selectedCity.value = cities.first;
          }
        }
      }
    } catch (e) {
      debugPrint('Fetch Cities Error: $e');
    } finally {
      isCitiesLoading.value = false;
    }
  }
  // final List<String> cities = [
  //   'Indore',
  //   'Bhopal',
  //   'Mumbai',
  //   'Delhi NCR',
  //   'Bengaluru',
  // ];

  final RxList<String> selectedInterests = <String>[].obs;

  final RxList<String> selectedFocus = <String>[].obs;

  // Profession categories pagination (infinite_scroll_pagination v5.x).
  static const int _professionPageSize = 10;
  int _professionTotalPages = 1;

  late final PagingController<int, Map<String, dynamic>>
  professionPagingController = PagingController<int, Map<String, dynamic>>(
    getNextPageKey: (state) {
      if (state.pages == null || state.pages!.isEmpty) {
        return 1;
      }

      final keys = state.keys;
      if (keys == null || keys.isEmpty) {
        return 1;
      }

      if (keys.last >= _professionTotalPages) {
        return null;
      }

      return keys.last + 1;
    },
    fetchPage: fetchProfessionCategories,
  );

  Future<List<Map<String, dynamic>>> fetchProfessionCategories(
    int pageKey,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final String token =
        prefs.getString('tokenData') ?? prefs.getString('token') ?? '';

    if (token.isEmpty) {
      throw Exception('Authentication token not found. Please login again.');
    }

    final url =
        Uri.parse(
          'https://dateapi.spinfotechindia.com/getProfessionCategories',
        ).replace(
          queryParameters: {
            'page': pageKey.toString(),
            'limit': _professionPageSize.toString(),
          },
        );

    final response = await http.get(
      url,
      headers: {
        'Authorization': token.startsWith('Bearer ') ? token : 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    debugPrint('Profession API Status: ${response.statusCode}');
    debugPrint('Profession API Response: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load profession categories: ${response.statusCode}',
      );
    }

    final Map<String, dynamic> body =
        jsonDecode(response.body) as Map<String, dynamic>;

    if (body['code'] != 200 || body['data'] is! List) {
      throw Exception(
        body['msg']?.toString() ?? 'Invalid profession categories response.',
      );
    }

    final pagination = body['pagination'];
    if (pagination is Map) {
      _professionTotalPages =
          int.tryParse(pagination['totalPages']?.toString() ?? '') ?? 1;
    } else {
      _professionTotalPages = 1;
    }

    return (body['data'] as List)
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .where((item) => item['name'] != null)
        .toList();
  }

  // Existing profile fetch API.
  Future<void> fetchMyProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final prefs = await SharedPreferences.getInstance();

      final token =
          prefs.getString('tokenData') ?? prefs.getString('token') ?? '';

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

      debugPrint('Profile API Status: ${response.statusCode}');
      debugPrint('Profile API Response: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;

        if (responseData['success'] == true) {
          final data = responseData['data'] as Map<String, dynamic>;

          completion.value =
              int.tryParse(
                data['profileCompletionPercent']?.toString() ?? '',
              ) ??
              0;

          // Load saved cities when the API returns them.
          final apiCities = data['interestedCity'];

          if (apiCities is List && apiCities.isNotEmpty) {
            selectedCities.assignAll(
              apiCities.map((e) => e.toString()).toList(),
            );
            selectedCity.value = selectedCities.first;
          }

          // Load saved interests.
          final apiInterests = data['interestedField'];

          if (apiInterests is List && apiInterests.isNotEmpty) {
            selectedInterests.assignAll(
              apiInterests.map((e) => e.toString()).toList(),
            );
          }

          // Load saved networking focus.
          final apiFocus = data['networkingFocus'];

          if (apiFocus is List && apiFocus.isNotEmpty) {
            selectedFocus.assignAll(apiFocus.map((e) => e.toString()).toList());
          }

          if (completion.value >= 100) {
            await prefs.setBool('isProfileComplete', true);
          }
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
      debugPrint('Profile API Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Select or deselect a city.

  void selectCity(String city) {
    if (selectedCities.contains(city)) {
      if (selectedCities.length == 1) {
        Get.snackbar(
          'Select City',
          'Please select at least one city.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      selectedCities.remove(city);
    } else {
      selectedCities.add(city);
    }

    // Keep the single-city field synchronized.
    selectedCity.value = selectedCities.first;

    _updateCompletion();
  }

  void toggleInterest(String interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.add(interest);
    }

    _updateCompletion();
  }

  void toggleFocus(String field) {
    if (selectedFocus.contains(field)) {
      selectedFocus.remove(field);
    } else {
      selectedFocus.add(field);
    }

    _updateCompletion();
  }

  void _updateCompletion() {
    int value = 60;

    if (selectedCities.isNotEmpty) value += 10;
    if (selectedInterests.isNotEmpty) value += 15;

    if (selectedInterests.contains('Networking') && selectedFocus.isNotEmpty) {
      value += 15;
    }

    completion.value = value.clamp(0, 100);
  }

  // Save complete profile API.
  Future<void> saveAndContinue() async {
    if (selectedCities.isEmpty) {
      Get.snackbar(
        'Select City',
        'Please select at least one interested city.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (selectedInterests.isEmpty) {
      Get.snackbar(
        'Select your interests',
        'Please select at least one interest to continue.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (isSaving.value) return;

    try {
      isSaving.value = true;
      errorMessage.value = '';

      final prefs = await SharedPreferences.getInstance();

      final token =
          prefs.getString('tokenData') ?? prefs.getString('token') ?? '';

      if (token.isEmpty) {
        Get.snackbar(
          'Login Required',
          'Authentication token not found. Please login again.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final Map<String, dynamic> requestBody = {
        'interestedCity': selectedCities.toList(),
        'interestedField': selectedInterests.toList(),
        'networkingFocus': selectedInterests.contains('Networking')
            ? selectedFocus.toList()
            : <String>[],
        // Replace with the actual uploaded image path/URL
        // if the backend requires a real profile photo.
        'profilePhoto': 'image',
      };

      debugPrint('Complete Profile Request: ${jsonEncode(requestBody)}');

      final response = await http.post(
        Uri.parse(completeProfileApiUrl),
        headers: {
          'Authorization': token.startsWith('Bearer ')
              ? token
              : 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('Complete Profile Status: ${response.statusCode}');
      debugPrint('Complete Profile Response: ${response.body}');

      Map<String, dynamic> responseData;

      try {
        responseData = jsonDecode(response.body) as Map<String, dynamic>;
      } catch (_) {
        throw Exception('Invalid response received from server.');
      }

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          responseData['success'] == true) {
        final data = responseData['data'];

        final int serverCompletion = data is Map
            ? int.tryParse(
                    data['profileCompletionPercent']?.toString() ?? '',
                  ) ??
                  0
            : 0;

        completion.value = serverCompletion;

        // Save completion only after successful API response.
        await prefs.setBool('isProfileComplete', serverCompletion >= 100);

        // Save updated selections locally too.
        await prefs.setStringList('interestedCities', selectedCities.toList());

        Get.dialog(
          Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF7F0FF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Color(0xFF927B91),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    height: 84,
                    width: 84,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFFDDF9EE),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF08B58E),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 38,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    'Profile Complete!',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF24202D),
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "Your preferences are saved. You're ready "
                    "to jump into live speed dating sessions.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Color(0xFF70575D),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Card(margin: EdgeInsets.zero,shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(18)),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F0FF),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Profile Status',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF70575D),
                                  ),
                                ),
                              ),
                              Text(
                                '100% Completed',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF00A77D),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 8,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFFF4F7B),
                                    Color(0xFFC21D75),
                                    Color(0xFF8B4DE8),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Color(0xFF00B98B),
                        size: 20,
                      ),
                      SizedBox(width: 9),
                      Expanded(
                        child: Text(
                          'Instant Speed Matchmaking Unlocked',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  const Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Color(0xFF00B98B),
                        size: 20,
                      ),
                      SizedBox(width: 9),
                      Expanded(
                        child: Text(
                          'Priority Access to Live Lobbies',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFB9134B),
                            Colors.pink,
                            Color(0xFF8B4DE8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFFFF4F7B,
                            ).withValues(alpha: 0.25),
                            blurRadius: 15,
                            offset: const Offset(0, 7),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          Get.offAllNamed('/bottom');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Explore Events',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward, size: 19),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      'Stay on Profile',
                      style: TextStyle(
                        color: Color(0xFF63474B),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          barrierDismissible: false,
        );

        if (serverCompletion >= 100) {
          // Replace '/bottom' with your actual BottomView route.
          Get.offAllNamed('/bottom');
        }
      } else {
        errorMessage.value =
            responseData['message']?.toString() ??
            'Unable to save profile. Please try again.';

        Get.snackbar(
          'Failed',
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();
      debugPrint('Complete Profile Error: $e');

      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSaving.value = false;
    }
  }

  void onNavigationTap(int index) {
    // Connect your existing GetX routes here.
  }

  @override
  void onInit() {
    super.onInit();
    fetchMyProfile();
    fetchCities();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    professionPagingController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
