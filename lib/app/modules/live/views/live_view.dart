import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/live_controller.dart';

class LiveView extends GetView<LiveController> {
  const LiveView({super.key});

  static const Color pink = Color(0xFFE81759);
  static const Color purple = Color(0xFF9228D5);
  static const Color darkRed = Color(0xFFC91520);

  @override
  Widget build(BuildContext context) {
    Get.put(LiveController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Main participant video background
                Image.network(
                  'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=900&q=90',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFF46352C),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ),

                // Dark overlay for text visibility
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x99000000),
                        Colors.transparent,
                        Color(0x18000000),
                        Color(0xBB000000),
                      ],
                      stops: [0.0, 0.25, 0.60, 1.0],
                    ),
                  ),
                ),

                SafeArea(
                  child: Stack(
                    children: [
                      // Call duration
                      Positioned(
                        top: 10,
                        right: 22,
                        child: Obx(
                          () => Row(
                            children: [
                              const Icon(
                                Icons.hourglass_empty_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                controller.formattedTime,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Other participant preview
                      // Movable participant preview
                      Obx(
                        () => Positioned(
                          top: controller.previewY.value,
                          left: controller.previewX.value == 0
                              ? null
                              : controller.previewX.value,
                          right: controller.previewX.value == 0 ? 13 : null,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              final screenSize = MediaQuery.of(
                                Get.context!,
                              ).size;

                              controller.previewX.value =
                                  (controller.previewX.value == 0
                                      ? screenSize.width - 112 - 13
                                      : controller.previewX.value) +
                                  details.delta.dx;

                              controller.previewY.value += details.delta.dy;

                              // Keep preview inside the screen
                              controller.previewX.value = controller
                                  .previewX
                                  .value
                                  .clamp(0.0, screenSize.width - 112);

                              controller.previewY.value = controller
                                  .previewY
                                  .value
                                  .clamp(40.0, screenSize.height - 200);
                            },
                            child: Container(
                              width: 112,
                              height: 161,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 12,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.network(
                                      'https://images.unsplash.com/photo-1534528741775-53994a69daeb'
                                      '?auto=format&fit=crop&w=350&q=85',
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        color: const Color(0xFF765D4A),
                                        child: const Icon(
                                          Icons.person,
                                          size: 50,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: _previewIcon(
                                        Icons.cameraswitch_outlined,
                                      ),
                                    ),
                                    Positioned(
                                      left: 8,
                                      bottom: 9,
                                      child: Obx(
                                        () => Text(
                                          controller.isCameraOn.value
                                              ? 'You'
                                              : 'Camera off',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 7,
                                      bottom: 8,
                                      child: Obx(
                                        () => Icon(
                                          controller.isMicOn.value
                                              ? Icons.mic_none
                                              : Icons.mic_off,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Call control panel
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 22,
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 9,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDF8FF),
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 18,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: _roundControl(
                                    icon: Icons.mic_none_rounded,
                                    active: controller.isMicOn,
                                    onTap: controller.toggleMic,
                                  ),
                                ),
                                const SizedBox(width: 7),
                                Expanded(
                                  child: _roundControl(
                                    icon: Icons.videocam_outlined,
                                    active: controller.isCameraOn,
                                    onTap: controller.toggleCamera,
                                  ),
                                ),
                                const SizedBox(width: 7),
                                Expanded(
                                  child: _roundControl(
                                    icon: Icons.volume_up_rounded,
                                    active: controller.isSpeakerOn,
                                    onTap: controller.toggleSpeaker,
                                  ),
                                ),
                                const SizedBox(width: 7),

                                // Like button and count
                                Expanded(
                                  child: Obx(
                                    () => Stack(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: 49,
                                          height: 49,
                                          child: Material(
                                            color: controller.isLiked.value
                                                ? const Color(0xFFFFD6E1)
                                                : const Color(0xFFFFE8EF),
                                            shape: const CircleBorder(),
                                            child: InkWell(
                                              customBorder:
                                                  const CircleBorder(),
                                              onTap: controller.toggleLike,
                                              child: Icon(
                                                controller.isLiked.value
                                                    ? Icons.favorite
                                                    : Icons.favorite_rounded,
                                                color: const Color(0xFF680021),
                                                size: 23,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: -2,
                                          top: -3,
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFC8174F),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Text(
                                              '${controller.likeCount.value}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 9,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 7),

                                // End call
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height: 49,
                                    child: ElevatedButton(
                                      onPressed: controller.endCall,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: darkRed,
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                      ),
                                      child: const FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.call_end_rounded,
                                              size: 19,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'End',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom navigation
        ],
      ),
    );
  }

  Widget _previewIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon, color: Colors.white, size: 15),
    );
  }

  Widget _roundControl({
    required IconData icon,
    required RxBool active,
    required VoidCallback onTap,
  }) {
    return Obx(
      () => SizedBox(
        height: 49,
        child: Material(
          color: active.value
              ? const Color(0xFFF7F0FC)
              : const Color(0xFFE6DDEB),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Icon(icon, color: const Color(0xFF211B2C), size: 23),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem(this.icon, this.label);
}
