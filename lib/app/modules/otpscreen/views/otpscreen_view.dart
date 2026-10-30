import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/otpscreen_controller.dart';

class OtpscreenView extends GetView<OtpscreenController> {
  const OtpscreenView({super.key});

  static const Color pink = Color(0xFFFF4779);
  static const Color purple = Color(0xFF8528EE);
  static const Color dark = Color(0xFF25212B);

  @override
  Widget build(BuildContext context) {
    Get.put(OtpscreenController());
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9FD),
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF9EDFA), Color(0xFFFFF9FC), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 55,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back, color: dark),
                    ),
                    const Expanded(
                      child: Text(
                        'WhatsApp Verification',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: dark,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),

                      const Text(
                        'Verify your WhatsApp',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.6,
                          color: dark,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Enter the 4-digit code sent to your WhatsApp.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF777184),
                        ),
                      ),

                      const SizedBox(height: 18),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: const Color(0xFFF3E4FC)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                           Image.asset("assets/images/whatsapplogo.png",height: 15,),
                            const SizedBox(width: 9),
                            Obx(
                              () => Text(
                                controller.phoneNumber.value,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: dark,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: const Icon(
                                Icons.edit_outlined,
                                size: 16,
                                color: purple,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Hidden TextField opens the real numeric keyboard.
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: controller.openKeyboard,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Keep a real editable field for keyboard input.
                            SizedBox(
                              width: 1,
                              height: 1,
                              child: Opacity(
                                opacity: 0,
                                child: TextField(
                                  controller: controller.textController,
                                  focusNode: controller.focusNode,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  autofillHints: const [
                                    AutofillHints.oneTimeCode,
                                  ],
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4),
                                  ],
                                  onChanged: controller.onOtpChanged,
                                  onSubmitted: (_) => controller.verifyOtp(),
                                ),
                              ),
                            ),

                            Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(4, (index) {
                                  final value = controller.otp.value;
                                  final active =
                                      controller.focusNode.hasFocus &&
                                      index == value.length &&
                                      value.length < 4;

                                  return Container(
                                    width: 55,
                                    height: 64,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 7,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: active
                                            ? pink
                                            : const Color(0xFFF0E4FA),
                                        width: active ? 1.8 : 1,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: purple.withOpacity(0.05),
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      index < value.length ? value[index] : '',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: dark,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      Obx(
                        () => Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            const Text(
                              "Didn't receive code? ",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF777184),
                              ),
                            ),
                            GestureDetector(
                              onTap: controller.seconds.value == 0
                                  ? controller.resendOtp
                                  : null,
                              child: Text(
                                controller.seconds.value == 0
                                    ? 'Resend OTP'
                                    : 'Resend in ${controller.formattedTime}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: purple,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      Container(
                        width: double.infinity,
                        height: 53,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [pink, purple],
                          ),
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                              color: pink.withOpacity(0.25),
                              blurRadius: 14,
                              offset: const Offset(0, 7),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: controller.verifyOtp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Verify & Continue',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Change WhatsApp Number',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF514B5A),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              size: 17,
                              color: Color(0xFF514B5A),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
