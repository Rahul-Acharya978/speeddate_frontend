import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bottom/views/bottom_view.dart';
import '../../home/views/home_view.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;
  final nameController = TextEditingController();

  final RxString dob = ''.obs;
  final RxString gender = ''.obs;
  final RxString city = ''.obs;
  final RxString imagePath = ''.obs;
  final RxString selfiePath = ''.obs;
  final RxBool isLoading = false.obs;
  DateTime? selectedDob;

  final RxList<String> cities = <String>[].obs;
  final RxBool isCitiesLoading = false.obs;

  Future<void> getCities() async {
    try {
      isCitiesLoading.value = true;

      var request = http.Request(
        'GET',
        Uri.parse(
          'https://dateapi.spinfotechindia.com/user/getcity?page=0&limit=10',
        ),
      );

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> result = jsonDecode(responseBody);

        if (result['success'] == true && result['data'] is List) {
          cities.assignAll(
            (result['data'] as List)
                .where((item) => item['isDisabled'] != true)
                .map<String>((item) => item['name'].toString())
                .toList(),
          );
        } else {
          cities.clear();
        }
      } else {
        debugPrint('Get Cities Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Get Cities Exception: $e');
    } finally {
      isCitiesLoading.value = false;
    }
  }
  // final List<String> cities = [
  //   'Indore',
  //   'Bhopal',
  //   'Gwalior',
  //   'Delhi',
  //   'Mumbai',
  // ];

  File? get selectedImage =>
      imagePath.value.isEmpty ? null : File(imagePath.value);
  File? get selectedSelfie =>
      selfiePath.value.isEmpty ? null : File(selfiePath.value);
  Future<void> pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1200,
    );

    if (image != null) {
      imagePath.value = image.path;
    }
  }

  // Capture selfie separately for the API.
  Future<void> pickSelfie() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
      maxWidth: 1200,
    );

    if (image != null) {
      selfiePath.value = image.path;
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final now = DateTime.now();
    final latestBirthDate = DateTime(now.year - 18, now.month, now.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: latestBirthDate,
      firstDate: DateTime(1940),
      lastDate: latestBirthDate,
      helpText: 'Select your date of birth',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFC20D4C),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF25212B),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDob = picked;

      dob.value =
          '${picked.day.toString().padLeft(2, '0')} / '
          '${picked.month.toString().padLeft(2, '0')} / '
          '${picked.year}';
    }
  }

  // Future<void> continueProfile() async {
  //   if (nameController.text.trim().isEmpty) {
  //     _error('Please enter your full name.');
  //     return;
  //   }
  //
  //   if (selectedDob == null) {
  //     _error('Please select your date of birth.');
  //     return;
  //   }
  //
  //   if (gender.value.isEmpty) {
  //     _error('Please select your gender.');
  //     return;
  //   }
  //
  //   if (city.value.isEmpty) {
  //     _error('Please select your city.');
  //     return;
  //   }
  //
  //   if (imagePath.value.isEmpty) {
  //     _error('Please select your profile image.');
  //     return;
  //   }
  //
  //   // Selfie is optional.
  //
  //   if (isLoading.value) return;
  //
  //   try {
  //     isLoading.value = true;
  //
  //     final prefs = await SharedPreferences.getInstance();
  //
  //     final String token = prefs.getString('token') ?? '';
  //     final String userId = prefs.getString('userId') ?? '';
  //
  //     if (token.isEmpty || userId.isEmpty) {
  //       _error('Login session not found. Please login again.');
  //       return;
  //     }
  //
  //     // Check profile image path before uploading.
  //     final profileFile = File(imagePath.value);
  //
  //     if (!await profileFile.exists()) {
  //       _error(
  //         'Selected profile image is no longer available. Please select it again.',
  //       );
  //       return;
  //     }
  //
  //     final request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse('https://dateapi.spinfotechindia.com/user/register'),
  //     );
  //
  //     request.headers['Authorization'] = 'Bearer $token';
  //     request.headers['Accept'] = 'application/json';
  //
  //     // Text fields
  //     request.fields['fullName'] = nameController.text.trim();
  //
  //     request.fields['dob'] = selectedDob!.toUtc().toIso8601String();
  //
  //     request.fields['gender'] = gender.value;
  //     request.fields['yourCity'] = city.value;
  //     request.fields['_id'] = userId;
  //
  //     // Required profile image
  //     request.files.add(
  //       await http.MultipartFile.fromPath('userImg', imagePath.value),
  //     );
  //
  //     // Optional selfie: add only when a valid file exists.
  //     if (selfiePath.value.trim().isNotEmpty) {
  //       final selfieFile = File(selfiePath.value);
  //
  //       if (await selfieFile.exists()) {
  //         request.files.add(
  //           await http.MultipartFile.fromPath('selfie', selfiePath.value),
  //         );
  //       }
  //     }
  //
  //     debugPrint('Register API: ${request.url}');
  //     debugPrint('User ID: $userId');
  //     debugPrint('Selfie included: ${selfiePath.value.isNotEmpty}');
  //
  //     final streamedResponse = await request.send();
  //
  //     final response = await http.Response.fromStream(streamedResponse);
  //
  //     debugPrint('Register status: ${response.statusCode}');
  //     debugPrint('Register response: ${response.body}');
  //
  //     if (response.statusCode == 200) {
  //       final prefs = await SharedPreferences.getInstance();
  //
  //       await prefs.setBool('isProfileComplete', true);
  //       Get.snackbar(
  //         'Success',
  //         'Profile registered successfully.',
  //         snackPosition: SnackPosition.BOTTOM,
  //       );
  //
  //       Get.offAll(() => BottomView());
  //     } else {
  //       Get.snackbar(
  //         'Registration Failed',
  //         response.body.isNotEmpty ? response.body : 'Please try again.',
  //         snackPosition: SnackPosition.BOTTOM,
  //       );
  //     }
  //   } catch (e) {
  //     debugPrint('Register API error: $e');
  //
  //     Get.snackbar(
  //       'Error',
  //       'Unable to register profile. Please try again.',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> continueProfile() async {
    if (nameController.text.trim().isEmpty) {
      _error('Please enter your full name.');
      return;
    }

    if (selectedDob == null) {
      _error('Please select your date of birth.');
      return;
    }

    if (gender.value.isEmpty) {
      _error('Please select your gender.');
      return;
    }

    if (city.value.isEmpty) {
      _error('Please select your city.');
      return;
    }

    if (imagePath.value.isEmpty) {
      _error('Please select your profile image.');
      return;
    }

    if (isLoading.value) return;

    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();

      final String token = prefs.getString('token') ?? '';
      final String userId = prefs.getString('userId') ?? '';

      if (token.isEmpty || userId.isEmpty) {
        _error('Login session not found. Please login again.');
        return;
      }

      final profileFile = File(imagePath.value);

      if (!await profileFile.exists()) {
        _error('Image file not found. Please select the image again.');
        return;
      }

      // Check that the selected image is not empty.
      final int imageSize = await profileFile.length();

      if (imageSize == 0) {
        _error('Selected image is empty. Please choose another image.');
        return;
      }

      final uri = Uri.parse(
        'https://dateapi.spinfotechindia.com/user/register',
      );

      final request = http.MultipartRequest('POST', uri);

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      // Text fields
      request.fields.addAll({
        'fullName': nameController.text.trim(),
        'dob': selectedDob!.toUtc().toIso8601String(),
        'gender': gender.value,
        'yourCity': city.value,
        '_id': userId,
      });

      // Profile image: field name must match backend upload middleware.
      final profileMultipartFile = await http.MultipartFile.fromPath(
        'userImg',
        profileFile.path,
        filename: profileFile.uri.pathSegments.last,
      );

      request.files.add(profileMultipartFile);

      // Optional selfie
      if (selfiePath.value.isNotEmpty) {
        final selfieFile = File(selfiePath.value);

        if (await selfieFile.exists() && await selfieFile.length() > 0) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'selfie',
              selfieFile.path,
              filename: selfieFile.uri.pathSegments.last,
            ),
          );
        }
      }

      // Debug request before sending.
      debugPrint('========== PROFILE REGISTER ==========');
      debugPrint('URL: $uri');
      debugPrint('User ID: $userId');
      debugPrint('Image path: ${profileFile.path}');
      debugPrint('Image size: $imageSize bytes');
      debugPrint('Fields: ${request.fields}');
      debugPrint(
        'Files: ${request.files.map((f) => '${f.field} -> ${f.filename} (${f.length} bytes)').toList()}',
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('HTTP Status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      debugPrint('======================================');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Save only after successful API response.
        await prefs.setBool('isProfileComplete', true);

        Get.snackbar(
          'Success',
          'Profile updated successfully.',
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.offAll(() => BottomView());
      } else {
        Get.snackbar(
          'Registration Failed',
          response.body.isNotEmpty ? response.body : 'Please try again.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e, stackTrace) {
      debugPrint('Profile API error: $e');
      debugPrint('$stackTrace');

      Get.snackbar(
        'Error',
        'Unable to register profile. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _error(String message) {
    Get.snackbar('Required', message, snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onInit() {
    super.onInit();
    getCities();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
