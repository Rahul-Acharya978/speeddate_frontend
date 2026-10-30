import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/matchfound_controller.dart';

class MatchfoundView extends GetView<MatchfoundController> {
  const MatchfoundView({super.key});

  static const Color pink = Color(0xFFFF477E);
  static const Color purple = Color(0xFF8749F5);
  static const Color darkPink = Color(0xFFC20D4D);
  static const Color bg = Color(0xFFFFF8FF);
  static const Color textColor = Color(0xFF252033);
  static const Color muted = Color(0xFF765D65);

  @override
  Widget build(BuildContext context) {
    Get.put(MatchfoundController());
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _header(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: Column(
                  children: [
                    const SizedBox(height: 0),
                    _mutualBadge(),
                    const SizedBox(height: 25),
                    _matchedProfiles(),
                    const SizedBox(height: 22),
                    _location(),
                    const SizedBox(height: 5),
                    const Text(
                      "It's a Match!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.7,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'We found someone who looks like a great\n'
                      'match for you.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.45,
                        color: muted,
                      ),
                    ),
                    const SizedBox(height: 22),
                    _speedDateCard(),
                    const SizedBox(height: 24),
                    _connectButton(),
                    const SizedBox(height: 12),
                    _viewProfileButton(),
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
        border: Border(bottom: BorderSide(color: Color(0xFFF3EAF5))),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: Get.back,
            borderRadius: BorderRadius.circular(25),
            child: const SizedBox(
              width: 35,
              height: 45,
              child: Icon(Icons.arrow_back_rounded, size: 24, color: textColor),
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Live',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          const SizedBox(width: 9),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFDFEB),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
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

  // Mutual match badge
  Widget _mutualBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF2E9FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.favorite_rounded, color: Color(0xFF7136DA), size: 14),
          SizedBox(width: 5),
          Text(
            'MUTUAL MATCH',
            style: TextStyle(
              color: Color(0xFF7136DA),
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  // Both profile photos
  Widget _matchedProfiles() {
    return SizedBox(
      height: 124,
      child: Center(
        child: SizedBox(
          width: 244,
          height: 124,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: _profilePhoto(
                  imageUrl:
                      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e'
                      '?auto=format&fit=crop&w=300&q=85',
                  label: 'You',
                  size: 106,
                  isYou: true,
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: _profilePhoto(
                  imageUrl:
                      'https://images.unsplash.com/photo-1534528741775-53994a69daeb'
                      '?auto=format&fit=crop&w=300&q=85',
                  label: 'Riya, 27',
                  size: 106,
                  isYou: false,
                ),
              ),
              Positioned(
                left: 81,
                top: 30,
                child: Container(
                  width: 49,
                  height: 49,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [pink, darkPink],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x35E81759),
                        blurRadius: 12,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.bolt_rounded,
                    color: Colors.white,
                    size: 31,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profilePhoto({
    required String imageUrl,
    required String label,
    required double size,
    required bool isYou,
  }) {
    return SizedBox(
      width: size,
      height: size + 17,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: size,
            height: size,
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x18000000),
                  blurRadius: 13,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    color: const Color(0xFFF0E5F2),
                    child: const Icon(Icons.person, size: 45, color: purple),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Color(0x12000000), blurRadius: 5),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isYou) ...[
                    const Icon(Icons.circle, color: purple, size: 7),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    label,
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
        ],
      ),
    );
  }

  // Matched location
  Widget _location() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.location_pin, color: darkPink, size: 16),
        SizedBox(width: 4),
        Flexible(
          child: Text(
            'Indore, Madhya Pradesh',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              color: muted,
            ),
          ),
        ),
      ],
    );
  }

  // Speed date timer card
  Widget _speedDateCard() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
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
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFEAF0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.videocam_outlined,
                    color: darkPink,
                    size: 23,
                  ),
                ),
                const SizedBox(width: 9),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '3-minute speed date',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Starting automatically',
                        style: TextStyle(fontSize: 12, color: muted),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0E6F8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Obx(
                    () => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          size: 14,
                          color: darkPink,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          controller.formattedTime,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 11),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const LinearProgressIndicator(
                value: 0.80,
                minHeight: 6,
                backgroundColor: Color(0xFFE9DFF0),
                valueColor: AlwaysStoppedAnimation<Color>(purple),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Connect now button
  Widget _connectButton() {
    return Container(
      width: double.infinity,
      height: 53,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [pink, purple],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: pink.withValues(alpha: 0.25),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: controller.connectNow,
          borderRadius: BorderRadius.circular(32),
          child: Obx(
            () => Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.isConnecting.value
                        ? 'Connecting...'
                        : 'Connect Now',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
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
      ),
    );
  }

  // View full profile
  Widget _viewProfileButton() {
    return TextButton(
      onPressed: controller.viewFullProfile,
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF7136DA),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
      ),
      child: const Text(
        'View Full Profile',
        style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500),
      ),
    );
  }

  // Bottom navigation
 }


