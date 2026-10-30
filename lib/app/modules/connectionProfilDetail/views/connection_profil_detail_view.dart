import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/connection_profil_detail_controller.dart';

class ConnectionProfilDetailView
    extends GetView<ConnectionProfilDetailController> {
  const ConnectionProfilDetailView({super.key});

  static const Color bg = Color(0xFFFFF8FF);
  static const Color pink = Color(0xFFFF4777);
  static const Color darkPink = Color(0xFFBC0750);
  static const Color purple = Color(0xFF7838D4);
  static const Color dark = Color(0xFF26202D);
  static const Color muted = Color(0xFF806A79);
  static const Color lightPurple = Color(0xFFF3E9FF);

  @override
  Widget build(BuildContext context) {
    Get.put(ConnectionProfilDetailController());
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _profileCard(),
                    const SizedBox(height: 24),
                    _speedDateCard(),
                    const SizedBox(height: 24),
                    _timelineCard(),
                    const SizedBox(height: 24),
                    _startChatSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Top app bar
  Widget _appBar() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: Get.back,
            child: const Icon(Icons.arrow_back_ios_new, size: 21, color: dark),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Text(
              'Connection Profile Detail',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: dark,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.tune, size: 22, color: dark),
          const SizedBox(width: 15),
          Container(
            height: 34,
            width: 34,
            decoration: const BoxDecoration(
              color: darkPink,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 21,
            ),
          ),
        ],
      ),
    );
  }

  // Profile image and about
  Widget _profileCard() {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 438,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=900',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFFEBDCE6),
                        child: const Icon(
                          Icons.person,
                          size: 100,
                          color: muted,
                        ),
                      );
                    },
                  ),

                  // Dark gradient at the bottom
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Color(0xD9000000),
                        ],
                        stops: [0.35, 0.55, 1],
                      ),
                    ),
                  ),

                  // Live match badge
                  Positioned(
                    left: 15,
                    top: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.circle, size: 8, color: darkPink),
                          SizedBox(width: 5),
                          Text(
                            'LIVE EVENT MATCH',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: dark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Favorite button
                  Positioned(
                    right: 14,
                    top: 16,
                    child: Obx(
                      () => Material(
                        color: Colors.white.withValues(alpha: 0.10),
                        shape: const CircleBorder(),
                        child: InkWell(
                          onTap: controller.toggleFavorite,
                          customBorder: const CircleBorder(),
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: Icon(
                              controller.isFavorite.value
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: darkPink,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Profile details at bottom
                  Positioned(
                    left: 16,
                    right: 12,
                    bottom: 15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                '${controller.profileName}, ${controller.age}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.verified, color: pink, size: 20),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                              size: 15,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Indore, India  ·  Speed Match #1',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [pink, Color(0xFFE92E75)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 14,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Mutual Match',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.check, size: 14, color: Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // About section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ABOUT',
                    style: TextStyle(
                      color: Color(0xFF9B777C),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Love travel, music and meaningful conversations. '
                    'Always searching for great filter coffee and indie gigs.',
                    style: TextStyle(fontSize: 14, height: 1.6, color: dark),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 5,
                    runSpacing: 7,
                    children: controller.interests.map((interest) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: lightPurple,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          interest,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: dark,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Speed date context
  Widget _speedDateCard() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 33,
                  width: 33,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEBDDFF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.bolt, color: purple, size: 21),
                ),
                const SizedBox(width: 7),
                const Expanded(
                  child: Text(
                    'Speed Date Context',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: dark,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBDDFF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Verified Session',
                    style: TextStyle(
                      color: purple,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _contextCell('Event', 'Friday Speed Dating Night'),
                      const SizedBox(height: 8),
                      _contextCell('Match Order', 'Match #1'),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: [
                      _contextCell('Date & Time', controller.eventDate),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(9),
                        color: const Color(0xFFF7F0FC),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Conversation Time',
                              style: TextStyle(
                                color: Color(0xFF654B5B),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.timer_outlined,
                                  color: pink,
                                  size: 17,
                                ),
                                SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    '03:00 min',
                                    style: TextStyle(
                                      color: darkPink,
                                      fontSize: 14,
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
              ],
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(9),
              color: const Color(0xFFF2E9FA),
              child: const Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.thumb_up_alt_outlined,
                        size: 15,
                        color: darkPink,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'Saved by you:',
                          style: TextStyle(fontSize: 12, color: muted),
                        ),
                      ),
                      Text(
                        '23 Sep 2026 • 8:04 PM',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: dark,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.favorite_border, size: 15, color: purple),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'Saved by them:',
                          style: TextStyle(fontSize: 12, color: muted),
                        ),
                      ),
                      Text(
                        '23 Sep 2026 • 8:06 PM',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: dark,
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

  Widget _contextCell(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(9),
      color: const Color(0xFFF7F0FC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF654B5B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              height: 1.2,
              color: dark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Connection timeline
  Widget _timelineCard() {
    final milestones = [
      ('Met at Event', '23 Sep • 8:00 PM'),
      ('Speed Date Completed', '03:00 duration • Video session'),
      ('You Saved Profile', '8:04 PM • Spark sent'),
      ('They Saved You', '8:06 PM • Spark reciprocated'),
      ('Mutual Match Confirmed', '8:06 PM • Ready to connect!'),
    ];

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(24),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Connection Timeline',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: dark,
                    ),
                  ),
                ),
                Text(
                  '${milestones.length} milestones',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: muted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            ...List.generate(milestones.length, (index) {
              final isLast = index == milestones.length - 1;

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      child: Column(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: isLast ? purple : darkPink,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isLast ? Icons.favorite : Icons.check,
                              color: Colors.white,
                              size: 13,
                            ),
                          ),
                          if (!isLast)
                            Expanded(
                              child: Container(
                                width: 1.5,
                                color: const Color(0xFFE5C9DC),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 0),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 0,
                          bottom: isLast ? 0 : 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              milestones[index].$1,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: isLast ? purple : dark,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              milestones[index].$2,
                              style: const TextStyle(
                                fontSize: 12,
                                color: muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // Start chat button
  Widget _startChatSection() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(32),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 15),
        decoration: BoxDecoration(
          color: const Color(0xFFF0E6F8),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 53,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFF4777),
                      Color(0xFFD41466),
                      Color(0xFF7434D6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: pink.withValues(alpha: 0.22),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: controller.startChat,
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.isChatStarting.value
                                ? 'Starting Chat...'
                                : 'Start Chat with ${controller.profileName}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 7),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 19,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 14, color: muted),
                SizedBox(width: 5),
                Text(
                  'Secure end-to-end conversation',
                  style: TextStyle(
                    fontSize: 11,
                    color: muted,
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

  // Bottom navigation
}
