import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FreeeventselfiController extends GetxController {
  final RxInt count = 0.obs;
  final RxBool isTakingSelfie = false.obs;

  final ImagePicker _picker = ImagePicker();

  // Selfie temporarily captured; user must press Done to confirm.
  final Rx<File?> capturedImage = Rx<File?>(null);

  // Confirmed selfie displayed inside _selfieScanner().
  final Rx<File?> selfieImage = Rx<File?>(null);

  void shareScreen() {
    Get.snackbar(
      'Share',
      'Connect your share functionality here.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  Future<void> takeSelfie() async {
    if (isTakingSelfie.value) return;

    try {
      isTakingSelfie.value = true;

      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 85,
      );

      if (image == null) return;

      capturedImage.value = File(image.path);

      // Show the captured image with Close and Done buttons.
      await Get.dialog<void>(_selfiePreviewDialog(), barrierDismissible: false);
    } catch (e) {
      Get.snackbar(
        'Camera Error',
        'Unable to open the camera. Please check camera permission.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isTakingSelfie.value = false;
    }
  }

  Widget _selfiePreviewDialog() {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Obx(() {
          final image = capturedImage.value;

          if (image == null) {
            return const SizedBox.shrink();
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Review Your Selfie',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF272230),
                ),
              ),
              const SizedBox(height: 18),

              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.file(
                  image,
                  width: 260,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        capturedImage.value = null;
                        Get.back<void>();
                      },
                      icon: const Icon(Icons.close_rounded),
                      label: const Text('Close'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFC20D4D),
                        side: const BorderSide(color: Color(0xFFC20D4D)),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final imageToConfirm = capturedImage.value;
                        if (imageToConfirm == null) return;

                        selfieImage.value = imageToConfirm;
                        capturedImage.value = null;

                        Get.back<void>();
                      },
                      icon: const Icon(Icons.check_rounded),
                      label: const Text('Done'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC20D4D),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  void retakeSelfie() {
    takeSelfie();
  }

  void verifySelfie() {
    if (selfieImage.value == null) {
      takeSelfie();
      return;
    }

    Get.dialog(
      selfieSubmittedDialog(),
      barrierDismissible: false,
      barrierColor: const Color(0x990F0715),
    );
  }

  Widget selfieSubmittedDialog() {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top close button
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF2E9FC),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Color(0xFF70565F),
                    size: 20,
                  ),
                ),
              ),
            ),

            // Success icon
            Container(
              height: 96,
              width: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00AD7B).withValues(alpha: 0.12),
              ),
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF05AC7B),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3005AC7B),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 43,
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Selfie Submitted!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.6,
                color: Color(0xFF272230),
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Your selfie has been submitted\nsuccessfully.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Color(0xFF70565F),
              ),
            ),

            const SizedBox(height: 16),

            // Verification status badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xFFEBDDFF),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.refresh_rounded,
                    size: 17,
                    color: Color(0xFF8139D9),
                  ),
                  SizedBox(width: 7),
                  Text(
                    'Verification Under Review',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF45228A),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Privacy card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F0FF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 28,
                    width: 28,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0DDF7),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lock_rounded,
                      color: Color(0xFFC20D4D),
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.45,
                          color: Color(0xFF70565F),
                        ),
                        children: [
                          TextSpan(
                            text:
                                'Your verification selfie is 100% private and will ',
                          ),
                          TextSpan(
                            text: 'never appear',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF272230),
                            ),
                          ),
                          TextSpan(
                            text: ' on your public profile or to other daters.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Continue button
            SizedBox(
              width: double.infinity,
              height: 49,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFC20D4D),
                      Color(0xFFFF477E),

                      Color(0xFF8139D9),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF477E).withValues(alpha: 0.20),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();

                    // TODO: Navigate to your Waiting Room route.
                    // Example: Get.toNamed(Routes.WAITING_ROOM);
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
                        'Continue to Waiting Room',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Event time
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 15,
                  color: Color(0xFFC20D4D),
                ),
                SizedBox(width: 7),
                Flexible(
                  child: Text(
                    'Event starts at 8:00 PM • We’ll notify you shortly',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF70565F),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 23),

            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  size: 12,
                  color: Color(0xFFB6A0A8),
                ),
                SizedBox(width: 5),
                Flexible(
                  child: Text(
                    'SPARKDATE TRUST & SAFETY VERIFIED',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9,
                      letterSpacing: 0.3,
                      color: Color(0xFFB6A0A8),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void openProfile() {
    // Connect your existing profile route here.
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
