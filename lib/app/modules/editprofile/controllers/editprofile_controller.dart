import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditprofileController extends GetxController {
  //TODO: Implement EditprofileController

  final count = 0.obs;
  final nameController = TextEditingController(text: 'Raj Kumar');
  final cityController =
  TextEditingController(text: 'Indore, Madhya Pradesh');

  final Rxn<File> profileImage = Rxn<File>();

  final dateOfBirth = '14 / 08 / 1999'.obs;
  final gender = 'Man'.obs;

  final lookingFor = <String>[
    'Dating',
    'Networking',
  ].obs;

  final selectedInterests = <String>[
    'Software & Tech',
    'Startups & VC',
    'Product / SaaS',
  ].obs;

  final profileCompletion = 85.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickProfileImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1000,
      );

      if (image != null) {
        profileImage.value = File(image.path);
        updateCompletion();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Unable to select profile photo.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeProfileImage() {
    profileImage.value = null;
    updateCompletion();
  }

  void clearName() {
    nameController.clear();
    updateCompletion();
  }

  Future<void> selectDateOfBirth(BuildContext context) async {
    final parts = dateOfBirth.value
        .replaceAll(' ', '')
        .split('/');

    DateTime initialDate = DateTime(1999, 8, 14);

    if (parts.length == 3) {
      initialDate = DateTime(
        int.tryParse(parts[2]) ?? 1999,
        int.tryParse(parts[1]) ?? 8,
        int.tryParse(parts[0]) ?? 14,
      );
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      helpText: 'Select Date of Birth',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFB9134B),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF28232E),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      dateOfBirth.value =
      '${picked.day.toString().padLeft(2, '0')} / '
          '${picked.month.toString().padLeft(2, '0')} / '
          '${picked.year}';

      updateCompletion();
    }
  }

  void toggleLookingFor(String value) {
    if (lookingFor.contains(value)) {
      lookingFor.remove(value);
    } else {
      lookingFor.add(value);
    }

    updateCompletion();
  }

  void toggleInterest(String value) {
    if (selectedInterests.contains(value)) {
      selectedInterests.remove(value);
    } else {
      selectedInterests.add(value);
    }

    updateCompletion();
  }

  void updateCompletion() {
    int score = 0;

    if (nameController.text.trim().isNotEmpty) score += 20;
    if (dateOfBirth.value.isNotEmpty) score += 15;
    if (gender.value.isNotEmpty) score += 10;
    if (cityController.text.trim().isNotEmpty) score += 15;
    if (lookingFor.isNotEmpty) score += 15;
    if (selectedInterests.isNotEmpty) score += 15;
    if (profileImage.value != null) score += 10;

    profileCompletion.value = score;
  }

  void saveProfile() {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar(
        'Required',
        'Please enter your full name.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // TODO: Call your update-profile API here.
    // Send name, dateOfBirth, gender, city,
    // lookingFor, selectedInterests and profileImage.

    Get.snackbar(
      'Success',
      'Profile details are ready to save.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFEBDDFF),
      colorText: const Color(0xFF28232E),
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
    nameController.dispose();
    cityController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
