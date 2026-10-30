import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/likesaveevent_controller.dart';

class LikesaveeventView extends GetView<LikesaveeventController> {
  const LikesaveeventView({super.key});

  static const Color bg = Color(0xFFFFF8FF);
  static const Color pink = Color(0xFFFF4777);
  static const Color purple = Color(0xFF9548E8);
  static const Color dark = Color(0xFF26202D);
  static const Color muted = Color(0xFF765D70);

  @override
  Widget build(BuildContext context) {
    Get.put(LikesaveeventController());
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            _topBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _heading(),
                    const SizedBox(height: 24),

                    Obx(() {
                      final events = controller.visibleEvents;

                      if (events.isEmpty) {
                        return _emptyState();
                      }

                      return Column(
                        children: events.map((event) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: _eventCard(event),
                          );
                        }).toList(),
                      );
                    }),

                    const SizedBox(height: 0),
                    _ticketAlert(),
                  ],
                ),
              ),
            ),
            _bottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _topBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
      decoration: const BoxDecoration(
        color: bg,
        border: Border(bottom: BorderSide(color: Color(0xFFF5EAF5))),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: Get.back,
            child: const Icon(Icons.arrow_back, size: 23, color: dark),
          ),
          const SizedBox(width: 20),
          const Text(
            'Events',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: dark,
            ),
          ),
          const SizedBox(width: 7),
          Obx(
            () => Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFDCE5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${controller.count} saved',
                style: const TextStyle(
                  color: Color(0xFFB9134B),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            height: 34,
            width: 34,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFBC0750),
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

  Widget _heading() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      'Bookmarked Mixers',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.7,
                        color: dark,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.circle, size: 9, color: pink),
                ],
              ),
              SizedBox(height: 3),
              Text(
                'Instant access to your shortlisted\nspeed dates',
                style: TextStyle(fontSize: 12, height: 1.35, color: muted),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Obx(
          () => Material(
            color: const Color(0xFFF0E7F5),
            borderRadius: BorderRadius.circular(30),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: controller.toggleSimulateEmpty,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 9,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.swap_horiz, size: 17, color: muted),
                    const SizedBox(width: 7),
                    Text(
                      controller.simulateEmpty.value
                          ? 'Show\nEvents'
                          : 'Simulate\nEmpty',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        height: 1.15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5B4056),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _eventCard(SavedEvent event) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF49344D).withValues(alpha: 0.13),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 193,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  event.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFF1E4ED),
                      child: const Icon(
                        Icons.image_outlined,
                        size: 50,
                        color: muted,
                      ),
                    );
                  },
                ),
                Positioned(
                  left: 10,
                  top: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF0F4),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      event.badge,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: dark,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 12,
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => _confirmRemove(event),
                      child: const SizedBox(
                        height: 42,
                        width: 42,
                        child: Icon(Icons.favorite, color: pink, size: 24),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF201A27),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      event.price,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Text(
                event.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                  color: dark,
                ),
              ),
              Spacer(),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: event.category == 'Speed Rounds'
                        ? const Color(0xFFEBDDFF)
                        : const Color(0xFFFFDCE5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    event.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: event.category == 'Speed Rounds'
                          ? const Color(0xFF7025D4)
                          : const Color(0xFFB9134B),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                color: Color(0xFFE91E63),
                size: 16,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  '${event.date} • ${event.time}',
                  style: const TextStyle(fontSize: 12, color: muted),
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Color(0xFF853AF4),
                size: 17,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  event.location,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: muted),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              _avatarStack(event.avatars),
              const SizedBox(width: 8),

              Flexible(
                child: Text(
                  event.joined,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: muted),
                ),
              ),

              Spacer(),
              SizedBox(
                width: 115,
                height: 37,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [pink, Color(0xFFDA4DA7), purple],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: pink.withValues(alpha: 0.15),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () => controller.openEvent(event),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'View Event',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _confirmRemove(SavedEvent event) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        title: const Text(
          'Remove Bookmark?',
          style: TextStyle(color: dark, fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Remove "${event.title}" from your saved events?',
          style: const TextStyle(color: muted),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text('Cancel', style: TextStyle(color: muted)),
          ),
          TextButton(
            onPressed: () {
              controller.toggleFavorite(event.id);
              Get.back();
              Get.snackbar(
                'Removed',
                'Event removed from saved events',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white,
                colorText: dark,
              );
            },
            child: const Text(
              'Remove',
              style: TextStyle(color: pink, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatarStack(List<String> avatars) {
    const colors = [Color(0xFFE9D8FF), Color(0xFFFFD5DE), Color(0xFFFFD9DD)];

    return SizedBox(
      height: 30,
      width: avatars.isEmpty ? 0 : 30 + (avatars.length - 1) * 19.0,
      child: Stack(
        children: List.generate(avatars.length, (index) {
          return Positioned(
            left: index * 19.0,
            child: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colors[index % colors.length],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: Text(
                avatars[index],
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF61345F),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Container(
            height: 75,
            width: 75,
            decoration: const BoxDecoration(
              color: Color(0xFFFFE5ED),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.favorite_border, size: 36, color: pink),
          ),
          const SizedBox(height: 18),
          const Text(
            'No Bookmarked Events',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: dark,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your saved events will appear here.\nExplore events and save your favorites!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, height: 1.5, color: muted),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              controller.restoreEvents();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: pink,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text('Show Events'),
          ),
        ],
      ),
    );
  }

  Widget _ticketAlert() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      color: const Color(0xFFF2E9FA),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 19,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.notifications_active_outlined,
              color: Color(0xFFE91E63),
              size: 21,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ticket Alerts Active',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: dark,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'We will ping you 2 hours before spots sell out.',
                  style: TextStyle(fontSize: 12, color: muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNavigation() {
    final items = [
      (Icons.favorite_border, 'Home'),
      (Icons.calendar_today_outlined, 'Events'),
      (Icons.bolt, 'Live'),
      (Icons.chat_bubble_outline, 'Chat'),
      (Icons.account_circle_outlined, 'Profile'),
    ];

    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 12),
      decoration: BoxDecoration(
        color: bg,
        border: const Border(top: BorderSide(color: Color(0xFFF2E7F2))),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8),
        ],
      ),
      child: Row(
        children: List.generate(items.length, (index) {
          final selected = index == 1;
          final item = items[index];

          return Expanded(
            child: GestureDetector(
              onTap: () {
                if (!selected) {
                  Get.snackbar(
                    item.$2,
                    'Connect this tab to your GetX route.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.white,
                    colorText: dark,
                  );
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: selected ? 56 : 36,
                    width: selected ? 56 : 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: selected
                          ? const LinearGradient(
                              colors: [Color(0xFFE91E63), Color(0xFF7B1FA2)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                    ),
                    child: Icon(
                      item.$1,
                      size: selected ? 24 : 22,
                      color: selected ? Colors.white : const Color(0xFF674D5B),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.$2,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                      color: selected
                          ? const Color(0xFFCC1457)
                          : const Color(0xFF674D5B),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
