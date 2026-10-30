import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/refundflow2_controller.dart';

class Refundflow2View extends GetView<Refundflow2Controller> {
  const Refundflow2View({super.key});

  static const Color pink = Color(0xFFFF477E);
  static const Color purple = Color(0xFF7433D5);
  static const Color darkPink = Color(0xFFC20D4D);
  static const Color bg = Color(0xFFF9F8FF);
  static const Color textColor = Color(0xFF1C2233);
  static const Color muted = Color(0xFF634D55);
  static const Color lightPurple = Color(0xFFECEBFF);

  @override
  Widget build(BuildContext context) {
    Get.put(Refundflow2Controller());
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
         child: Column(
          children: [
            _header(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Request your refund?',
                      style: TextStyle(
                        fontSize: 24,
                        height: 1.2,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.6,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Your matching session wasn't completed, so you're\n"
                          'eligible for a full refund.',
                      style: TextStyle(
                        fontSize: 13.5,
                        height: 1.5,
                        color: muted,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _refundDetailsCard(),
                    const SizedBox(height: 34),
                    _processingCard(),
                    const SizedBox(height: 24),
                    _confirmButton(),
                    const SizedBox(height: 18),
                    _goBackButton(),
                  ],
                ),
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
        border: Border(
          bottom: BorderSide(color: Color(0xFFF0EDF7)),
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: Get.back,
            borderRadius: BorderRadius.circular(24),
            child: const SizedBox(
              width: 35,
              height: 45,
              child: Icon(
                Icons.arrow_back_rounded,
                color: textColor,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Request Refund',
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

  // Event, booking, refund amount and payment destination
  Widget _refundDetailsCard() {
    return Card(margin: EdgeInsets.zero,shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(17)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: const Color(0xFFF0EDF7)),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 49,
                        height: 49,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F1FF),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.campaign_outlined,
                          color: darkPink,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'EVENT',
                              style: TextStyle(
                                color: muted,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.4,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Friday Night Spark',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 15.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8E9FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.circle,
                              color: Color(0xFF4E50E9),
                              size: 8,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Standard Pass',
                              style: TextStyle(
                                color: Color(0xFF4145CE),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 11),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F2FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _bookingRow(
                          'Booking Type',
                          'Speed Dating Session Pass',
                        ),
                        const SizedBox(height: 6),
                        _bookingRow(
                          'Session Outcome',
                          '♧ Match not found',
                          valueColor: darkPink,
                        ),
                        const SizedBox(height: 6),
                        _bookingRow(
                          'Attempts Logged',
                          '2 attempts completed',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1,
              color: Color(0xFFDCDFFF),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 9),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Refund Amount',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              '100% reimbursed to source',
                              style: TextStyle(
                                color: muted,
                                fontSize: 12.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        '₹199',
                        style: TextStyle(
                          color: darkPink,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                          'INR',
                          style: TextStyle(
                            color: muted,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        color: const Color(0xFFF0EDF7),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: lightPurple,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.account_balance_wallet_outlined,
                            color: Color(0xFF4947D9),
                            size: 17,
                          ),
                        ),
                        const SizedBox(width: 9),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Destination',
                                style: TextStyle(
                                  color: muted,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Original payment method',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'UPI / Cards',
                          style: TextStyle(
                            color: muted,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 1),
          ],
        ),
      ),
    );
  }

  Widget _bookingRow(
      String label,
      String value, {
        Color valueColor = textColor,
      }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: const TextStyle(
              color: muted,
              fontSize: 11.5,
            ),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          flex: 6,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: valueColor,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // Processing information
  Widget _processingCard() {
    return Card(margin: EdgeInsets.zero,shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(17)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 17, 15, 17),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFEFF),
          borderRadius: BorderRadius.circular(17),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0B000000),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shield_rounded,
                color: Color(0xFF454BE8),
                size: 19,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Speedy Processing',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Refunds are sent directly back to your\n'
                        'original payment method. Standard\n'
                        'processing typically takes 2–5 business\n'
                        'days depending on your bank.',
                    style: TextStyle(
                      color: muted,
                      fontSize: 12.5,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Confirm refund button
  Widget _confirmButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [pink, darkPink, purple],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: pink.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: controller.confirmRefund,
          borderRadius: BorderRadius.circular(32),
          child: const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(width: 7),
                Text(
                  'Confirm Refund Request',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Go back button
  Widget _goBackButton() {
    return SizedBox(
      width: double.infinity,
      height: 49,
      child: ElevatedButton(
        onPressed: controller.goBack,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFFEFF),
          foregroundColor: textColor,
          elevation: 2,
          shadowColor: const Color(0x20000000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'Go Back',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Bottom navigation
 }

