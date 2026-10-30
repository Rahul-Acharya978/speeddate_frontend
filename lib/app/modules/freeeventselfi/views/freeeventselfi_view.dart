import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/freeeventselfi_controller.dart';

class FreeeventselfiView extends GetView<FreeeventselfiController> {
  const FreeeventselfiView({super.key});

  static const Color pink = Color(0xFFFF477E);
  static const Color purple = Color(0xFF8139D9);
  static const Color darkPink = Color(0xFFC20D4D);
  static const Color bg = Color(0xFFFFF8FF);
  static const Color textColor = Color(0xFF272230);
  static const Color muted = Color(0xFF70565F);

  @override
  Widget build(BuildContext context) {
    Get.put(FreeeventselfiController());
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                child: Column(
                  children: [
                    _eventBadge(),
                    const SizedBox(height: 8),
                    _verificationBadge(),
                    const SizedBox(height: 10),
                    const Text(
                      'Verify your identity',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Take a quick selfie to help keep SparkDate safe\n'
                      'and authentic.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: muted,
                        fontSize: 14,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 22),
                    _selfieScanner(),
                    const SizedBox(height: 30),
                    _privacyCard(),
                    const SizedBox(height: 16),
                    _tipsList(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            _bottomActions(),
          ],
        ),
      ),
    );
  }

  // Header
  Widget _header() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: bg,
        border: Border(bottom: BorderSide(color: Color(0xFFF2EAF6))),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: Get.back,
            borderRadius: BorderRadius.circular(25),
            child: const SizedBox(
              width: 30,
              height: 44,
              child: Icon(Icons.arrow_back_rounded, size: 23, color: textColor),
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Free Event Selfie Verification',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ),
          IconButton(
            onPressed: controller.shareScreen,
            icon: const Icon(Icons.share_outlined, size: 21, color: muted),
          ),
          GestureDetector(
            onTap: controller.openProfile,
            child: Container(
              width: 33,
              height: 33,
              decoration: const BoxDecoration(
                color: darkPink,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_outline_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // First event badge
  Widget _eventBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFECE0FF),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, color: purple, size: 9),
          SizedBox(width: 6),
          Text(
            '1ST FREE SPEED-DATE EVENT',
            style: TextStyle(
              color: Color(0xFF45228A),
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  // Quick verification badge
  Widget _verificationBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF0E5F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified_user_outlined, size: 13, color: darkPink),
          SizedBox(width: 5),
          Text(
            'Quick Verification',
            style: TextStyle(
              color: darkPink,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // Dashed circular camera scanner
  Widget _selfieScanner() {
    return Obx(() {
      final selfie = controller.selfieImage.value;

      return SizedBox(
        width: 224,
        height: 224,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 208,
              height: 208,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFE8EF),
              ),
            ),

            Container(
              width: 184,
              height: 184,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF0E7FF),
              ),
            ),

            CustomPaint(
              size: const Size(184, 184),
              painter: _DashedCirclePainter(
                color: const Color(0xFFFF477E),
                strokeWidth: 4,
                dashLength: 13,
                gapLength: 9,
              ),
            ),

            // Captured selfie or camera placeholder
            ClipOval(
              child: Container(
                width: 144,
                height: 144,
                color: Colors.white,
                child: selfie != null
                    ? Image.file(
                        selfie,
                        width: 144,
                        height: 144,
                        fit: BoxFit.cover,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFEAF0),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: Color(0xFFC20D4D),
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Position Face',
                            style: TextStyle(
                              color: Color(0xFF70565F),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),
            ),

            // Retake selfie button appears after capture
            if (selfie != null)
              Positioned(
                top: 24,
                right: 24,
                child: GestureDetector(
                  onTap: controller.retakeSelfie,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      color: Color(0xFFC20D4D),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.refresh_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),

            Positioned(
              bottom: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 9,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      color: selfie != null
                          ? const Color(0xFF10B981)
                          : const Color(0xFF8139D9),
                      size: 8,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      selfie != null ? 'SELFIE CAPTURED' : 'LIVE SCAN READY',
                      style: TextStyle(
                        color: selfie != null
                            ? const Color(0xFF00966D)
                            : const Color(0xFF8139D9),
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
  // Widget _selfieScanner() {
  //   return SizedBox(
  //     width: 224,
  //     height: 224,
  //     child: Stack(
  //       alignment: Alignment.center,
  //       children: [
  //         Container(
  //           width: 208,
  //           height: 208,
  //           decoration: const BoxDecoration(
  //             shape: BoxShape.circle,
  //             color: Color(0xFFFFE8EF),
  //           ),
  //         ),
  //         Container(
  //           width: 184,
  //           height: 184,
  //           decoration: const BoxDecoration(
  //             shape: BoxShape.circle,
  //             color: Color(0xFFF0E7FF),
  //           ),
  //         ),
  //         CustomPaint(
  //           size: const Size(184, 184),
  //           painter: _DashedCirclePainter(
  //             color: pink,
  //             strokeWidth: 4,
  //             dashLength: 13,
  //             gapLength: 9,
  //           ),
  //         ),
  //         Container(
  //           width: 144,
  //           height: 144,
  //           decoration: const BoxDecoration(
  //             shape: BoxShape.circle,
  //             color: Colors.white,
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Container(
  //                 width: 56,
  //                 height: 56,
  //                 decoration: const BoxDecoration(
  //                   color: Color(0xFFFFEAF0),
  //                   shape: BoxShape.circle,
  //                 ),
  //                 child: const Icon(
  //                   Icons.camera_alt_rounded,
  //                   color: darkPink,
  //                   size: 28,
  //                 ),
  //               ),
  //               const SizedBox(height: 12),
  //               const Text(
  //                 'Position Face',
  //                 style: TextStyle(
  //                   color: muted,
  //                   fontSize: 12,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Positioned(
  //           bottom: 1,
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(22),
  //               boxShadow: const [
  //                 BoxShadow(
  //                   color: Color(0x14000000),
  //                   blurRadius: 9,
  //                   offset: Offset(0, 3),
  //                 ),
  //               ],
  //             ),
  //             child: const Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Icon(Icons.circle, color: purple, size: 8),
  //                 SizedBox(width: 5),
  //                 Icon(Icons.circle, color: purple, size: 8),
  //                 SizedBox(width: 5),
  //                 Text(
  //                   'LIVE SCAN READY',
  //                   style: TextStyle(
  //                     color: purple,
  //                     fontSize: 10.5,
  //                     fontWeight: FontWeight.w800,
  //                     letterSpacing: 0.2,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Privacy information
  Widget _privacyCard() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(31),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(19, 19, 17, 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(31),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                color: Color(0xFFECE0FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lock_rounded,
                color: Color(0xFF7439D8),
                size: 19,
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your selfie is only used for\nverification.',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14.5,
                      height: 1.3,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'It will not be shown on your profile or to other users.',
                    style: TextStyle(color: muted, fontSize: 12, height: 1.4),
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.verified_outlined, size: 15, color: purple),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Your profile photo is separate from this verification selfie.',
                          style: TextStyle(
                            color: purple,
                            fontSize: 11.5,
                            height: 1.35,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Selfie tips
  Widget _tipsList() {
    return Column(
      children: [
        _tipRow(
          icon: Icons.face_rounded,
          iconColor: pink,
          iconBg: const Color(0xFFFFDCE5),
          text: 'Keep your face clearly visible',
        ),
        const SizedBox(height: 4),
        _tipRow(
          icon: Icons.wb_sunny_outlined,
          iconColor: darkPink,
          iconBg: const Color(0xFFFFDCE5),
          text: 'Use good lighting',
        ),
        const SizedBox(height: 4),
        _tipRow(
          icon: Icons.remove_circle_outline_rounded,
          iconColor: purple,
          iconBg: const Color(0xFFECE0FF),
          text: 'Remove sunglasses or face coverings',
        ),
      ],
    );
  }

  Widget _tipRow({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String text,
  }) {
    return Card(margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 11),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fixed bottom button and note

  Widget _bottomActions() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(10, 12, 10, 27),
      color: bg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            final isCaptured = controller.selfieImage.value != null;
            final isLoading = controller.isTakingSelfie.value;

            return Container(
              width: double.infinity,
              height: 53,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [darkPink, pink, purple],
                  stops: [0.20, 0.48, 1.0],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: pink.withValues(alpha: 0.25),
                    blurRadius: 16,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: isLoading
                      ? null
                      : () {
                          if (isCaptured) {
                            controller.verifySelfie();
                          } else {
                            controller.takeSelfie();
                          }
                        },
                  borderRadius: BorderRadius.circular(30),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isLoading)
                          const SizedBox(
                            height: 19,
                            width: 19,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        else
                          Icon(
                            isCaptured
                                ? Icons.check_circle_outline_rounded
                                : Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 21,
                          ),
                        const SizedBox(width: 8),
                        Text(
                          isLoading
                              ? 'Opening Camera...'
                              : isCaptured
                              ? 'Submit'
                              : 'Take a Selfie',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (!isLoading) ...[
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 9),
          const Text(
            'Your first event is free. No payment is required.',
            textAlign: TextAlign.center,
            style: TextStyle(color: muted, fontSize: 11.5),
          ),
        ],
      ),
    );
  }
}

// Dashed circular border painter
class _DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;

  _DashedCirclePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.gapLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide - strokeWidth) / 2;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final circumference = 2 * 3.141592653589793 * radius;
    final dashCount = (circumference / (dashLength + gapLength)).floor();

    for (int i = 0; i < dashCount; i++) {
      final startAngle =
          (i * (dashLength + gapLength) / radius) - (3.141592653589793 / 2);

      final sweepAngle = dashLength / radius;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DashedCirclePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashLength != dashLength ||
        oldDelegate.gapLength != gapLength;
  }
}
