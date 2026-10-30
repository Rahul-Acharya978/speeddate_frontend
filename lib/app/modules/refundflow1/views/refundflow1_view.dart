import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/refundflow1_controller.dart';

class Refundflow1View extends GetView<Refundflow1Controller> {
  const Refundflow1View({super.key});

  static const Color pink = Color(0xFFFF477E);
  static const Color purple = Color(0xFF7433D5);
  static const Color darkPink = Color(0xFFC20D4D);
  static const Color bg = Color(0xFFF9F8FF);
  static const Color textColor = Color(0xFF1C2233);
  static const Color muted = Color(0xFF634D55);

  @override
  Widget build(BuildContext context) {
    Get.put(Refundflow1Controller());
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
                child: Column(
                  children: [
                    _attemptBadge(),
                    const SizedBox(height: 20),
                    _searchIllustration(),
                    const SizedBox(height: 20),
                    const Text(
                      "We couldn't find a match",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      "We couldn't find a suitable match during this 3-\n"
                      "minute round. Don't worry, your event pass is\n"
                      "completely protected.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, height: 1.6, color: muted),
                    ),
                    const SizedBox(height: 30),
                    _eventDetailsCard(),
                    const SizedBox(height: 40),
                    _tryAnotherMatchButton(),
                    const SizedBox(height: 12),
                    _refundButton(),
                    const SizedBox(height: 28),
                    const Text(
                      'Try one more matching round or get your eligible\n'
                      'refund.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: muted, fontSize: 13, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Top header
  Widget _header() {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 17),
      decoration: const BoxDecoration(
        color: bg,
        border: Border(bottom: BorderSide(color: Color(0xFFF0EDF7))),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: Get.back,
            borderRadius: BorderRadius.circular(24),
            child: const SizedBox(
              width: 35,
              height: 45,
              child: Icon(Icons.arrow_back_rounded, color: textColor, size: 24),
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Match Result',
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconButton(
            onPressed: controller.showHelp,
            icon: const Icon(
              Icons.help_outline_rounded,
              color: muted,
              size: 21,
            ),
          ),
          Container(
            width: 33,
            height: 33,
            decoration: const BoxDecoration(
              color: darkPink,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              color: Colors.white,
              size: 19,
            ),
          ),
        ],
      ),
    );
  }

  // Attempt badge
  Widget _attemptBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E2FF),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, color: Color(0xFF4D4BEA), size: 9),
          SizedBox(width: 6),
          Text(
            'Attempt 1 of 2 • Priority Queue',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF29265F),
            ),
          ),
        ],
      ),
    );
  }

  // Circular search illustration
  Widget _searchIllustration() {
    return SizedBox(
      width: 164,
      height: 164,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 144,
            height: 144,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE9E7FF),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE9A9D2).withValues(alpha: 0.22),
                  blurRadius: 28,
                  spreadRadius: 4,
                ),
              ],
            ),
          ),
          Container(
            width: 112,
            height: 112,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x18000000),
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFD8DEFF), width: 2),
            ),
          ),
          Container(
            width: 37,
            height: 37,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFF4C7E0), width: 2),
            ),
          ),
          const Icon(Icons.explore, size: 39, color: Color(0xFFAC42B7)),
        ],
      ),
    );
  }

  // Event and format details
  Widget _eventDetailsCard() {
    return Card(margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(17)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            _detailRow(
              icon: Icons.card_membership_outlined,
              label: 'Event',
              value: 'Friday Night Sparks',
            ),
            const Divider(height: 1, color: Color(0xFFE9E7FF)),
            _detailRow(
              icon: Icons.timer_outlined,
              label: 'Format',
              value: '3-min live encounter',
            ),
            const Divider(height: 1, color: Color(0xFFE9E7FF)),
          ],
        ),
      ),
    );
  }

  Widget _detailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFECEBFF),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, color: const Color(0xFF514AF3), size: 18),
          ),
          const SizedBox(width: 11),
          Text(label, style: const TextStyle(color: muted, fontSize: 13)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: textColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Try another match
  Widget _tryAnotherMatchButton() {
    return Container(
      width: double.infinity,
      height: 46,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [pink, Color(0xFF7133D3)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: pink.withValues(alpha: 0.15),
            blurRadius: 9,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: controller.tryAnotherMatch,
          borderRadius: BorderRadius.circular(30),
          child: Obx(
            () => Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.bolt_rounded, color: Colors.white, size: 22),
                  const SizedBox(width: 5),
                  Text(
                    controller.isRetrying.value
                        ? 'Finding Another Match...'
                        : 'Try Another Match',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 19,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Refund button
  Widget _refundButton() {
    return SizedBox(
      width: double.infinity,
      height: 49,
      child: ElevatedButton(
        onPressed: controller.requestRefund,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFFEFF),
          foregroundColor: textColor,
          elevation: 2,
          shadowColor: const Color(0x26000000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.currency_exchange_rounded, size: 19),
            SizedBox(width: 8),
            Text(
              'Request Refund',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // Bottom navigation
}
