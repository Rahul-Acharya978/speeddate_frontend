import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/live_gate_controller.dart';

class LiveGateView extends GetView<LiveGateController> {
  const LiveGateView({super.key});

  static const Color pink = Color(0xFFFF477E);
  static const Color purple = Color(0xFF7A2BE2);

  @override
  Widget build(BuildContext context) {
    Get.put(LiveGateController());
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2A0A2E), Color(0xFF8E1D55), Color(0xFF5B2BE0)],
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            final phase = controller.phase.value;
            if (phase == 'countdown' || phase == 'opening') return _countdown();
            if (phase == 'checking') return _center('Looking for your live event...');
            if (phase == 'error') {
              return _center(controller.message.value, action: 'Try again');
            }
            if (phase == 'ready') {
              return _center(
                'You are set for ${controller.eventName.value}. Tap Live again to rejoin.',
                action: 'Rejoin',
              );
            }
            return _center(
              'You do not have a live booked event right now.',
              action: 'Check again',
            );
          }),
        ),
      ),
    );
  }

  Widget _countdown() {
    final seconds = controller.secondsLeft.value;
    final opening = controller.phase.value == 'opening';
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 168,
              height: 168,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 168,
                    height: 168,
                    child: CircularProgressIndicator(
                      value: opening ? null : seconds / 5,
                      strokeWidth: 8,
                      color: Colors.white,
                      backgroundColor: Colors.white24,
                    ),
                  ),
                  Text(
                    opening ? 'Go' : '$seconds',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 64,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Text(
              controller.eventName.value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              opening
                  ? 'Connecting you now.'
                  : 'You have a live event running. You will be connected in $seconds seconds.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.45,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _center(String text, {String? action}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.bolt, color: Colors.white, size: 48),
            const SizedBox(height: 16),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (action != null) ...[
              const SizedBox(height: 22),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [pink, purple]),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: ElevatedButton(
                  onPressed: controller.begin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  child: Text(action),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
