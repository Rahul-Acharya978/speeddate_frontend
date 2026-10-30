import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../freebookingSuccessful/views/freebooking_successful_view.dart';
import '../controllers/freeeventbooking_controller.dart';

class FreeeventbookingView extends GetView<FreeeventbookingController> {
  const FreeeventbookingView({super.key});

  static const Color pink = Color(0xFFFF477E);
  static const Color purple = Color(0xFF8139D9);
  static const Color darkPink = Color(0xFFC20D4D);
  static const Color bg = Color(0xFFFFF8FF);
  static const Color textColor = Color(0xFF25202F);
  static const Color muted = Color(0xFF70565F);

  @override
  Widget build(BuildContext context) {
    Get.put(FreeeventbookingController());
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _eventBanner(),
                    const SizedBox(height: 16),
                    _eventHeading(),
                    const SizedBox(height: 16),
                    _featureCards(),
                    const SizedBox(height: 16),
                    _matchmakingCard(),
                    const SizedBox(height: 20),
                    _benefitsSection(),
                    const SizedBox(height: 16),
                    _pricingCard(),
                    const SizedBox(height: 16),
                    _button2('Book Free Events', () {
                      Get.to(FreebookingSuccessfulView());
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _button2(String text, VoidCallback onTap, {bool compact = false}) =>
      SizedBox(
        width: double.infinity,
        height: compact ? 48 : 56,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFC20D4D), // Left: Dark pink
                Color(0xFFFF477E), // Center: Bright pink
                Color(0xFF8139D9), // Right: Purple
              ],
              stops: [0.0, 0.48, 1.0],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.pink.withOpacity(0.35),
                blurRadius: 18,
                spreadRadius: 2,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.confirmation_num_outlined,
                    color: Colors.white,
                    size: 19,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: compact ? 12 : 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 7),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  // Header
  Widget _header() {
    return SizedBox(
      height: 64,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            InkWell(
              onTap: Get.back,
              child: const Icon(
                Icons.arrow_back_rounded,
                color: textColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Text(
                'Free Event Booking',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ),
            IconButton(
              onPressed: controller.shareEvent,
              icon: const Icon(Icons.share_outlined, color: muted, size: 21),
            ),
            const SizedBox(width: 4),
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
      ),
    );
  }

  // Event image banner
  Widget _eventBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: double.infinity,
        height: 197,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4'
              '?auto=format&fit=crop&w=1000&q=85',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFF654336),
                child: const Icon(
                  Icons.restaurant_rounded,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x18000000),
                    Color(0x00000000),
                    Color(0x80000000),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF2F4),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle, size: 8, color: pink),
                    SizedBox(width: 7),
                    Text(
                      'STARTS TONIGHT',
                      style: TextStyle(
                        color: darkPink,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.circle, size: 4, color: Color(0xFFD5B8C2)),
                    SizedBox(width: 8),
                    Text(
                      '8:00 PM',
                      style: TextStyle(
                        color: muted,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 12,
              bottom: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xD926202D),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_fire_department_rounded,
                      color: pink,
                      size: 15,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Fast Filling',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
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

  // Event title and details
  Widget _eventHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.auto_awesome, color: darkPink, size: 15),
            SizedBox(width: 5),
            Text(
              'SPONTANEOUS CONNECTION',
              style: TextStyle(
                color: darkPink,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        const Text(
          'Creatives & Introverts',
          style: TextStyle(
            fontSize: 26,
            height: 1.15,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
            color: textColor,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Host: Ananya • SpeedLounge',
          style: TextStyle(fontSize: 13.5, color: muted),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _infoChip(
              Icons.location_on_outlined,
              'Indore',
              const Color(0xFFF0E7FF),
            ),
            _infoChip(
              Icons.calendar_today_outlined,
              'Today • 8:00 PM',
              const Color(0xFFF0E7FF),
            ),
          ],
        ),
        SizedBox(height: 10,),
        _infoChip(
          Icons.public,
          '18 spots left',
          const Color(0xFFFFDDE3),
          textColor: darkPink,
        ),
      ],
    );
  }

  Widget _infoChip(
    IconData icon,
    String text,
    Color color, {
    Color textColor = FreeeventbookingView.textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Three feature cards
  Widget _featureCards() {
    return Row(
      children: [
        Expanded(
          child: _featureCard(
            icon: Icons.groups_rounded,
            iconColor: purple,
            iconBg: const Color(0xFFF1E8FF),
            title: 'PARTICIPANTS',
            value: '18 spots\nleft',
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: _featureCard(
            icon: Icons.timer_outlined,
            iconColor: darkPink,
            iconBg: const Color(0xFFFFD9E0),
            title: 'SPEED\nROUNDS',
            value: '3-min\nchats',
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: _featureCard(
            icon: Icons.favorite_rounded,
            iconColor: purple,
            iconBg: const Color(0xFFE9DDFF),
            title: 'MUTUALS',
            value: 'Save\nmatches',
          ),
        ),
      ],
    );
  }

  Widget _featureCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String value,
  }) {
    return Card(
      child: Container(
        height: 150,
        padding: const EdgeInsets.fromLTRB(4, 12, 4, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 21),
            ),
            const SizedBox(height: 9),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: muted,
                fontSize: 10.5,
                height: 1.25,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: textColor,
                fontSize: 17,
                height: 1.25,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Matchmaking information
  Widget _matchmakingCard() {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF6EFFF),
          borderRadius: BorderRadius.circular(17),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 37,
              height: 37,
              decoration: const BoxDecoration(
                color: Color(0xFF8950F5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.bolt_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Zero-pressure matchmaking',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Confidential chemistry feedback at the '
                    'end of each round. Connect only when '
                    'you both say yes.',
                    style: TextStyle(fontSize: 13, height: 1.55, color: muted),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Benefits
  Widget _benefitsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What you'll get",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
        ),
        const SizedBox(height: 11),
        Card(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              children: [
                _BenefitRow('Meet curated, friendly people'),
                SizedBox(height: 12),
                _BenefitRow('Discover highly compatible matches'),
                SizedBox(height: 12),
                _BenefitRow('Save mutual connections directly to chats'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Pricing card
  Widget _pricingCard() {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              decoration: BoxDecoration(
                color: darkPink,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.card_giftcard_rounded,
                    color: Colors.white,
                    size: 12,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'FIRST EVENT FREE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Event Pass',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'One-time speed mixer pass',
                        style: TextStyle(color: muted, fontSize: 12.5),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      '₹99',
                      style: TextStyle(
                        color: Color(0xFFB7A5AB),
                        fontSize: 11,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(height: 1),
                    const Text(
                      '₹0',
                      style: TextStyle(
                        color: darkPink,
                        fontSize: 38,
                        height: 1,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            Card(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F0FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    _PriceRow(
                      label: 'Event Pass (Welcome Gift)',
                      value: 'FREE',
                      valueColor: darkPink,
                    ),
                    SizedBox(height: 9),
                    _PriceRow(label: 'Convenience & Match Fee', value: '₹0'),
                    SizedBox(height: 13),
                    _PriceRow(
                      label: 'Total',
                      value: '₹0',
                      bold: true,
                      valueColor: darkPink,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.verified_user_outlined, color: purple, size: 17),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    '100% on us! No UPI, card, or payment required.',
                    style: TextStyle(
                      color: muted,
                      fontSize: 12.5,
                      height: 1.35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Fixed bottom booking button
}

class _BenefitRow extends StatelessWidget {
  final String text;

  const _BenefitRow(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Color(0xFFFFDCE4),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_rounded,
            color: Color(0xFFC20D4D),
            size: 17,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: FreeeventbookingView.textColor,
              fontSize: 13,
              height: 1.35,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  final Color valueColor;

  const _PriceRow({
    required this.label,
    required this.value,
    this.bold = false,
    this.valueColor = const Color(0xFF25202F),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: bold
                  ? FreeeventbookingView.textColor
                  : FreeeventbookingView.muted,
              fontSize: bold ? 17 : 12,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: bold ? 21 : 12,
            fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
