import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sundaymixer/app/modules/matchfound/views/matchfound_view.dart';

import '../controllers/waitingroom_controller.dart';

class WaitingroomView extends GetView<WaitingroomController> {
  const WaitingroomView({super.key});

  static const Color pink = Color(0xFFFF477E);
  static const Color purple = Color(0xFF8749F5);
  static const Color darkPink = Color(0xFFC20D4D);
  static const Color bg = Color(0xFFFFF8FF);
  static const Color textColor = Color(0xFF252033);
  static const Color muted = Color(0xFF765D65);

  @override
  Widget build(BuildContext context) {
    Get.put(WaitingroomController());
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            _header(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 26,
                      ),
                      child: Column(
                        children: [
                          _queueBadge(),
                          const SizedBox(height: 32),
                          _countdown(),
                          const SizedBox(height: 27),
                          const Text(
                            'Your speed date will start automatically\n'
                            'when a match is found.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: muted,
                              fontSize: 14,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 24),
                          _findingMatchCard(),
                          const SizedBox(height: 9),
                          _matchAttemptsCard(),
                          const SizedBox(height: 13),
                          _lobbySection(),
                          const SizedBox(height: 20),
                          _waitingButton(),
                          const SizedBox(height: 17),
                          _exitButton(),
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

  // Top app bar
  Widget _header() {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 17),
      decoration: const BoxDecoration(
        color: bg,
        border: Border(bottom: BorderSide(color: Color(0xFFF3EAF5))),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: Get.back,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: textColor,
              size: 23,
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            'Live',
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFDFEB),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.circle, size: 8, color: pink),
                SizedBox(width: 5),
                Text(
                  'LIVE',
                  style: TextStyle(
                    color: darkPink,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Get.snackbar(
                'Notifications',
                'No new notifications.',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: textColor,
              size: 23,
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

  // Queue status
  Widget _queueBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF1EAF9),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, color: darkPink, size: 9),
          SizedBox(width: 8),
          Text(
            'Queue Active • Event #284',
            style: TextStyle(
              color: textColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Gradient countdown ring
  Widget _countdown() {
    return SizedBox(
      width: 202,
      height: 202,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(202, 202),
            painter: _CountdownRingPainter(),
          ),
          Container(
            width: 172,
            height: 172,
            decoration: const BoxDecoration(
              color: Color(0xFFFCE8F2),
              shape: BoxShape.circle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    controller.formattedTime,
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 41,
                      height: 1.05,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'Expected time left\nof 3:00 pool',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: muted,
                    fontSize: 11.5,
                    height: 1.25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Finding match card
  Widget _findingMatchCard() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF2EAFE),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.track_changes_rounded,
                    color: purple,
                    size: 23,
                  ),
                ),
                const SizedBox(width: 13),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Finding your best match...',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "We're matching you based on your event\n"
                        'preferences.',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.4,
                          color: muted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Obx(
                  () => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1E9FC),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.people_alt_outlined,
                          size: 14,
                          color: purple,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${controller.waitingSingles.value} singles waiting',
                          style: const TextStyle(
                            color: textColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.speed_rounded, size: 13, color: muted),
                const SizedBox(width: 4),
                const Text(
                  'Avg. wait: 3m',
                  style: TextStyle(
                    color: muted,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Match attempts
  Widget _matchAttemptsCard() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 14),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'MATCH ATTEMPTS',
                  style: TextStyle(
                    color: muted,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
                const Spacer(),
                Obx(
                  () => Text(
                    '${controller.matchAttempt.value} of 3',
                    style: const TextStyle(
                      color: darkPink,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            Row(
              children: [
                Expanded(
                  child: _attemptItem(
                    number: 1,
                    title: 'Match 1',
                    subtitle: 'Confirmed',
                    color: const Color(0xFFF7EEFF),
                    statusColor: const Color(0xFF079B70),
                    icon: Icons.check_rounded,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: _attemptItem(
                    number: 2,
                    title: 'Match 2',
                    subtitle: 'Searching',
                    color: const Color(0xFFFFE9ED),
                    statusColor: const Color(0xFFB92775),
                    icon: Icons.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: _attemptItem(
                    number: 3,
                    title: 'Match 3',
                    subtitle: 'Queued',
                    color: const Color(0xFFFFF9FB),
                    statusColor: const Color(0xFFEEDFE7),
                    icon: Icons.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 13),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.verified_outlined,
                  size: 14,
                  color: Color(0xFF079B70),
                ),
                SizedBox(width: 5),
                Flexible(
                  child: Text(
                    '1 match confirmed  •  Next pairing starting soon',
                    style: TextStyle(fontSize: 11.5, color: muted),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _attemptItem({
    required int number,
    required String title,
    required String subtitle,
    required Color color,
    required Color statusColor,
    required IconData icon,
  }) {
    return Container(
      height: 71,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(38),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 23,
            height: 23,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
              boxShadow: number == 2
                  ? [
                      BoxShadow(
                        color: statusColor.withValues(alpha: 0.25),
                        blurRadius: 8,
                      ),
                    ]
                  : [],
            ),
            child: Icon(icon, color: Colors.white, size: number == 1 ? 16 : 10),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              height: 1.1,
              fontWeight: FontWeight.w700,
              color: number == 3 ? const Color(0xFFAA969F) : textColor,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 9.5,
              height: 1.1,
              color: number == 3 ? const Color(0xFFAA969F) : statusColor,
            ),
          ),
        ],
      ),
    );
  }

  // Event lobby
  Widget _lobbySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Text(
                'IN THIS EVENT LOBBY',
                style: TextStyle(
                  color: muted,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                ),
              ),
              Spacer(),
              Text(
                'Active Room',
                style: TextStyle(
                  color: darkPink,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
              width: 151,
              height: 38,
              child: Stack(
                children: [
                  for (int i = 0; i < 4; i++)
                    Positioned(
                      left: i * 27.0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            'https://i.pravatar.cc/100?img=${i + 40}',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: const Color(0xFFF1E5F2),
                              child: const Icon(
                                Icons.person,
                                size: 18,
                                color: purple,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    left: 112,
                    child: Container(
                      width: 36,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFDDE5),
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        '+10',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: darkPink,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Compatible singles ready',
                style: TextStyle(color: muted, fontSize: 11.5),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Waiting in queue button
  Widget _waitingButton() {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [pink, purple]),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: pink.withValues(alpha: 0.20),
            blurRadius: 13,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Obx(
        () => Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(32),
            onTap: () {
              Get.to(MatchfoundView());
              // Get.snackbar(
              //   'Live Queue',
              //   controller.isSearching.value
              //       ? 'You are waiting for your next match.'
              //       : 'You have left the queue.',
              //   snackPosition: SnackPosition.BOTTOM,
              //   margin: const EdgeInsets.all(14),
              // );
            },
            child: Center(
              child: Text(
                controller.isSearching.value
                    ? 'Waiting in Queue'
                    : 'Queue Paused',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Exit and refund
  Widget _exitButton() {
    return SizedBox(
      width: double.infinity,
      height: 49,
      child: OutlinedButton(
        onPressed: controller.exitAndRequestRefund,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: textColor,
          side: const BorderSide(color: Color(0xFFF1EAF4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: const Text(
          'Exit & Request Refund',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // Bottom navigation
}

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem(this.icon, this.label);
}

// Circular pink-purple progress ring
class _CountdownRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 5;

    final rect = Rect.fromCircle(center: center, radius: radius);

    final backgroundPaint = Paint()
      ..color = const Color(0xFFF1E5F5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final progressPaint = Paint()
      ..shader = const SweepGradient(
        colors: [Color(0xFFFF477E), Color(0xFFCB4CB6), Color(0xFF8749F5)],
        startAngle: 0,
        endAngle: math.pi * 2,
        transform: GradientRotation(math.pi / 2),
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, -math.pi / 2, math.pi * 1.55, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
