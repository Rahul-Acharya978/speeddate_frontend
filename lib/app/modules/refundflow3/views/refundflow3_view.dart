import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/refundflow3_controller.dart';

class Refundflow3View extends GetView<Refundflow3Controller> {
  const Refundflow3View({super.key});

  static const Color pink = Color(0xFFFF477E);
  static const Color purple = Color(0xFF7433D5);
  static const Color darkPink = Color(0xFFC20D4D);
  static const Color bg = Color(0xFFF9F8FF);
  static const Color textColor = Color(0xFF1C2233);
  static const Color muted = Color(0xFF634D55);
  static const Color green = Color(0xFF00865D);

  @override
  Widget build(BuildContext context) {
    Get.put(Refundflow3Controller());
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 30,
                      ),
                      child: Column(
                        children: [
                          _successIcon(),
                          const SizedBox(height: 17),
                          const Text(
                            'Refund requested successfully',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.55,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 7),
                          const Text(
                            'Your refund has been initiated and is being\n'
                            'processed by our automated billing desk.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.55,
                              color: muted,
                            ),
                          ),
                          const SizedBox(height: 26),
                          _refundSummaryCard(),
                          const SizedBox(height: 60),
                          _backHomeButton(),
                          const SizedBox(height: 24),
                          _eventDetailsButton(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header
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
              'Refund Status',
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

  // Green success icon
  Widget _successIcon() {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: green,
        border: Border.all(color: const Color(0xFF9BEBD0), width: 5),
        boxShadow: const [
          BoxShadow(color: Color(0x3588EAC4), blurRadius: 20, spreadRadius: 5),
        ],
      ),
      child: const Icon(Icons.check_rounded, size: 43, color: Colors.white),
    );
  }

  // Main refund details card
  Widget _refundSummaryCard() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            // Event name and processing status
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 15, 0, 15),
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F8FF),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.confirmation_num_outlined,
                      color: darkPink,
                      size: 17,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        controller.eventName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFBDF8E7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.circle, size: 7, color: Color(0xFF006B50)),
                          SizedBox(width: 5),
                          Text(
                            'Processing',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF004F3B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Refund amount
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF9FE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Text(
                      'REFUND AMOUNT',
                      style: TextStyle(
                        color: muted,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      controller.refundAmount,
                      style: const TextStyle(
                        color: darkPink,
                        fontSize: 32,
                        height: 1.2,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.7,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Payment destination
            _infoRow(
              icon: Icons.account_balance_wallet_outlined,
              label: 'Destination',
              value: controller.paymentMethod,
            ),

            const SizedBox(height: 12),

            // Refund reference
            Row(
              children: [
                const Icon(Icons.tag_rounded, color: muted, size: 18),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Reference',
                    style: TextStyle(color: muted, fontSize: 13),
                  ),
                ),
                InkWell(
                  onTap: controller.copyReference,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF0FF),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          controller.referenceNumber,
                          style: const TextStyle(
                            color: Color(0xFF4145D9),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.copy_rounded,
                          color: Color(0xFF4145D9),
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Request date
            _infoRow(
              icon: Icons.access_time_rounded,
              label: 'Request Date',
              value: controller.requestDate,
              compact: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
    bool compact = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: muted, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: muted, fontSize: 13),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          flex: 0,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: textColor,
              fontSize: compact ? 12 : 13,
              height: 1.4,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // Back to Home button
  Widget _backHomeButton() {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [pink, darkPink, purple],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: pink.withValues(alpha: 0.16),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: controller.backToHome,
          borderRadius: BorderRadius.circular(30),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Back to Home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Event details button
  Widget _eventDetailsButton() {
    return SizedBox(
      width: double.infinity,
      height: 49,
      child: ElevatedButton(
        onPressed: controller.viewEventDetails,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: textColor,
          elevation: 2,
          shadowColor: const Color(0x20000000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'View Event Details',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // Bottom navigation
}
