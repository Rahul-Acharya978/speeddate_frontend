import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/freebooking_successful_controller.dart';

class FreebookingSuccessfulView
    extends GetView<FreebookingSuccessfulController> {
  const FreebookingSuccessfulView({super.key});

  static const Color pink = Color(0xFFFF477E);
  static const Color purple = Color(0xFF9146F5);
  static const Color darkPink = Color(0xFFC20D4D);
  static const Color bg = Color(0xFFFFF8FF);
  static const Color textColor = Color(0xFF272230);
  static const Color muted = Color(0xFF725B63);
  static const Color lightPurple = Color(0xFFF5EEFF);
  static const Color green = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    Get.put(FreebookingSuccessfulController());
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 22),
                child: Column(
                  children: [
                    _successIcon(),
                    const SizedBox(height: 7),
                    const Text(
                      "You're Booked!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 27,
                        height: 1.2,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.7,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Your first free event has been reserved.\n'
                      'Get ready to connect!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: muted, fontSize: 14, height: 1.5),
                    ),
                    const SizedBox(height: 20),
                    _bookingTicket(),
                    const SizedBox(height: 16),
                    _identityCard(),
                    const SizedBox(height: 56),
                    _verifyButton(),
                    const SizedBox(height: 9),
                    _homeButton(),
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
    return SizedBox(
      height: 63,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            InkWell(
              onTap: Get.back,
              borderRadius: BorderRadius.circular(24),
              child: const SizedBox(
                width: 30,
                height: 44,
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 23,
                  color: textColor,
                ),
              ),
            ),
            const SizedBox(width: 9),
            const Expanded(
              child: Text(
                'Free Booking Successful',
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
              onPressed: controller.shareBooking,
              icon: const Icon(Icons.share_outlined, color: muted, size: 21),
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
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Success badge
  Widget _successIcon() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: green,
        border: Border.all(color: const Color(0xFFB8F1DE), width: 6),
        boxShadow: [
          BoxShadow(
            color: green.withValues(alpha: 0.18),
            blurRadius: 18,
            spreadRadius: 3,
          ),
        ],
      ),
      child: const Icon(Icons.check_rounded, color: Colors.white, size: 39),
    );
  }

  // Booking ticket card
  Widget _bookingTicket() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 14,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Gradient top strip
            Container(
              height: 6,
              width: 333,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [pink, Color(0xFFCA40C9), purple],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pass and booking status
                  Row(
                    children: [
                      Flexible(
                        child: _pill(
                          'FREE EVENT · ₹0',
                          const Color(0xFFE4F9F1),
                          const Color(0xFF00966D),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Flexible(
                        child: _pill(
                          '● LIVE TONIGHT • Booked',
                          const Color(0xFFF0E6FA),
                          textColor,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 17),

                  // Event title and thumbnail
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Creatives & Introverts',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Round 1 forming • 3-min micro dates',
                              style: TextStyle(color: muted, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4'
                          '?auto=format&fit=crop&w=180&q=80',
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) {
                            return Container(
                              width: 56,
                              height: 56,
                              color: lightPurple,
                              child: const Icon(
                                Icons.event_rounded,
                                color: purple,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // Event information
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F0FF),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: const Column(
                      children: [
                        _TicketInfoRow(
                          icon: Icons.access_time_rounded,
                          title: 'TIME SLOT',
                          value: 'Today • 8:00 PM (Round 1 forming)',
                        ),
                        SizedBox(height: 8),
                        _TicketInfoRow(
                          icon: Icons.near_me_outlined,
                          title: 'VENUE ACCESS',
                          value: 'Indore • High Street Lounge (Virtual)',
                        ),
                        SizedBox(height: 8),
                        _TicketInfoRow(
                          icon: Icons.account_circle_outlined,
                          title: 'ATTENDEE',
                          value: 'Raj Kumar',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Perforated ticket divider
                  Row(
                    children: [
                      _ticketNotch(),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final count = (constraints.maxWidth / 9).floor();

                            return Row(
                              children: List.generate(
                                count,
                                (index) => Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 2,
                                    ),
                                    height: 1,
                                    color: const Color(0xFFF1CFD9),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      _ticketNotch(),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Payment amount and booking ID
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Amount Paid',
                              style: TextStyle(
                                color: muted,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 3),
                            Row(
                              children: [
                                Text(
                                  '₹0',
                                  style: TextStyle(
                                    color: Color(0xFF00966D),
                                    fontSize: 19,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(width: 3),
                                Flexible(
                                  child: Text(
                                    '(Welcome Pass)',
                                    style: TextStyle(
                                      color: muted,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Booking ID',
                            style: TextStyle(
                              color: muted,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 3),
                          InkWell(
                            onTap: controller.copyBookingId,
                            borderRadius: BorderRadius.circular(18),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEDE3FF),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    controller.bookingId,
                                    style: const TextStyle(
                                      color: Color(0xFF6430D9),
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.copy_rounded,
                                    color: Color(0xFF6430D9),
                                    size: 13,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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

  Widget _pill(String label, Color bgColor, Color fgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fgColor,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _ticketNotch() {
    return Container(
      width: 20,
      height: 20,
      decoration: const BoxDecoration(
        color: FreebookingSuccessfulView.bg,
        shape: BoxShape.circle,
      ),
    );
  }

  // Identity verification notice
  Widget _identityCard() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 15, 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF0E8F8),
          borderRadius: BorderRadius.circular(30),
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
                Icons.verified_user_outlined,
                color: darkPink,
                size: 21,
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Identity Check Required',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Complete your quick selfie verification before '
                    'joining the live room to keep our speed dating '
                    'space authentic, secure, and genuine for everyone.',
                    style: TextStyle(color: muted, fontSize: 12.5, height: 1.55),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Verify with selfie button
  Widget _verifyButton() {
    return _gradientButton(
      text: 'Verify with Selfie',
      icon: Icons.arrow_forward_rounded,
      onTap: controller.verifyWithSelfie,
    );
  }

  // Back to Home button
  Widget _homeButton() {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFFFF), Color(0xFFF1E9FC), Color(0xFFE5D5F8)],
        ),

        border: Border.all(color: const Color(0xFFE9DDF7), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: controller.backToHome,
          borderRadius: BorderRadius.circular(30),
          child: const Center(
            child: Text(
              'Back to Home',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF272230),
                shadows: [
                  Shadow(
                    color: Colors.white,
                    offset: Offset(0, 1),
                    blurRadius: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _gradientButton({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 53,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFC20D4D), Color(0xFFFF5087), purple],
          stops: [0.0, 0.52, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: pink.withValues(alpha: 0.24),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable ticket information row
class _TicketInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _TicketInfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 27,
          height: 27,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 15, color: const Color(0xFFC20D4D)),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: FreebookingSuccessfulView.muted,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: FreebookingSuccessfulView.textColor,
                  fontSize: 12.5,
                  height: 1.3,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
