import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sundaymixer/app/modules/otpscreen/views/otpscreen_view.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  static const Color pink = Color(0xFFFF4F7B);
  static const Color purple = Color(0xFF8528EE);
  static const Color background = Color(0xFFFBF8FD);
  static const Color dark = Color(0xFF25212B);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: dark),
        ),
        title: const Text(
          'Login',
          style: TextStyle(
            color: dark,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const SizedBox(height: 85),

              const Text(
                "Let's get you connected",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: dark,
                  letterSpacing: -0.6,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Enter your WhatsApp number to start your\n'
                'speed dating journey.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.55,
                  color: Color(0xFF777184),
                ),
              ),

              const SizedBox(height: 42),

              Row(
                children: const [
                  Text(
                    'WhatsApp Number',
                    style: TextStyle(fontSize: 12, color: Color(0xFF514B5A)),
                  ),
                  SizedBox(width: 7),
                  Icon(Icons.chat_bubble, size: 13, color: Color(0xFF25D366)),
                  Spacer(),
                  Icon(Icons.lock_outline, size: 12, color: Color(0xFFFF3864)),
                  SizedBox(width: 4),
                  Text(
                    'Encrypted',
                    style: TextStyle(fontSize: 10, color: Color(0xFFFF3864)),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Gradient border input
              Container(
                height: 61,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [pink, purple]),
                  borderRadius: BorderRadius.circular(17),
                  boxShadow: [
                    BoxShadow(
                      color: purple.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 5),

                      Container(
                        height: 43,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F0FC),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('🇮🇳', style: TextStyle(fontSize: 17)),
                            const SizedBox(width: 7),
                            const Text(
                              '+91',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: dark,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              size: 19,
                              color: Color(0xFF514B5A),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: TextField(
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          style: const TextStyle(
                            fontSize: 15,
                            color: dark,
                            letterSpacing: 0.5,
                          ),
                          decoration: const InputDecoration(
                            hintText: '98765 43210',
                            hintStyle: TextStyle(
                              color: Color(0xFFBDB4B8),
                              fontSize: 15,
                            ),
                            counterText: '',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 9),

              Row(
                children: const [
                  Icon(Icons.circle, color: Color(0xFF25D366), size: 7),
                  SizedBox(width: 6),
                  Text(
                    'OTP will be sent directly to your WhatsApp',
                    style: TextStyle(fontSize: 10, color: Color(0xFF777184)),
                  ),
                ],
              ),

              const Spacer(),

              // Continue button
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [pink, purple]),
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: pink.withOpacity(0.28),
                      blurRadius: 15,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(35),
                    onTap: () async {
                      final result = await controller.sendOtp();

                      if (result != null) {
                        Get.to(
                          () => OtpscreenView(),
                          arguments: {
                            'phone': result['phone'],
                            'otp': result['otp'],
                          },
                        );
                      }
                    },

                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue with WhatsApp',
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
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
