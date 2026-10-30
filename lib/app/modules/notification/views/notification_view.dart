import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  static const Color pink = Color(0xFFEB4078);
  static const Color darkPink = Color(0xFFB9134B);
  static const Color purple = Color(0xFF7932E6);
  static const Color bg = Color(0xFFFFF7FC);
  static const Color textDark = Color(0xFF24212C);
  static const Color textMuted = Color(0xFF876D7A);
  static const Color border = Color(0xFFF4E3ED);

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationController());
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(child: _notificationBody()),
           ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: border)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: Get.back,
                icon: const Icon(Icons.arrow_back, color: textDark),
              ),
              const Expanded(
                child: Text(
                  'Notifications',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textDark,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.snackbar(
                    'Notifications',
                    'All notifications marked as read',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: const Text(
                  'Mark all as read',
                  style: TextStyle(
                    fontSize: 12,
                    color: darkPink,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _filterChip('All', 0, count: '3'),
                _filterChip('Events', 1),
                _filterChip('Matches', 2),
                _filterChip('Messages', 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, int index, {String? count}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Obx(() {
        final selected = controller.selectedFilter.value == index;

        return GestureDetector(
          onTap: () => controller.selectedFilter.value = index,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            decoration: BoxDecoration(
              gradient: selected
                  ? const LinearGradient(colors: [pink, darkPink, purple])
                  : null,
              color: selected ? null : const Color(0xFFF9F0FB),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: selected ? Colors.transparent : border),
            ),
            child: Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: selected ? Colors.white : textMuted,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                if (count != null) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      count,
                      style: const TextStyle(
                        fontSize: 9,
                        color: darkPink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _notificationBody() {
    return Obx(() {
      final filter = controller.selectedFilter.value;

      final today = [
        _NotificationData(
          type: 2,
          title: 'Your live event is starting soon',
          description: 'Friday Night Sparks starts in 10 minutes.',
          time: '10 min ago',
          icon: Icons.bolt,
          iconColor: darkPink,
          bgColor: const Color(0xFFFFEDF4),
          action: 'Join Waiting Room',
          tag: 'LIVE',
          isNew: true,
        ),
        _NotificationData(
          type: 1,
          title: 'You have a new match!  ♡',
          description: 'Riya selected you for a 3-minute speed date.',
          time: '25 min ago',
          icon: Icons.favorite,
          iconColor: purple,
          bgColor: const Color(0xFFF5EEFF),
          action: 'View Speed Date',
          tag: 'Match Found',
          isNew: true,
        ),
        _NotificationData(
          type: 1,
          title: "It's a Mutual Match!  ♡",
          description: "You and Riya both saved each other's profiles.",
          time: '1 hr ago',
          icon: Icons.auto_awesome,
          iconColor: darkPink,
          bgColor: const Color(0xFFFFF0F6),
          action: 'View Connection',
          isNew: true,
        ),
        _NotificationData(
          type: 3,
          title: 'Riya sent you a message',
          description: '"Had a great time talking to you 😊"',
          time: '2 hrs ago',
          icon: Icons.chat,
          iconColor: purple,
          bgColor: Colors.white,
          action: 'Reply in Chat',
        ),
      ];

      final earlier = [
        _NotificationData(
          type: 0,
          title: 'Event reminder',
          description: 'Sunday Brunch Singles is tomorrow at 11:30 AM.',
          time: 'Yesterday',
          icon: Icons.calendar_month,
          iconColor: purple,
          bgColor: Colors.white,
          tag: 'Confirmed RSVP',
        ),
        _NotificationData(
          type: 1,
          title: 'Your profile was saved',
          description: 'Riya saved your profile after your speed date.',
          time: 'Yesterday',
          icon: Icons.bookmark,
          iconColor: purple,
          bgColor: Colors.white,
          tag: 'Waiting for mutual match',
        ),
        _NotificationData(
          type: 0,
          title: 'Refund requested',
          description:
              'Your refund request for Friday Night Sparks has been received.',
          time: '2 days ago',
          icon: Icons.receipt_long,
          iconColor: const Color(0xFF765D70),
          bgColor: Colors.white,
          tag: 'Processing',
        ),
        _NotificationData(
          type: 0,
          title: 'Refund processed',
          description:
              'Your refund has been successfully initiated to your original payment method.',
          time: '3 days ago',
          icon: Icons.check_circle,
          iconColor: const Color(0xFF008A55),
          bgColor: Colors.white,
          tag: 'Completed',
        ),
      ];

      final all = [...today, ...earlier];

      final filtered = filter == 0
          ? all
          : all.where((item) => item.type == filter).toList();

      final todayItems = filtered
          .where((item) => today.contains(item))
          .toList();
      final earlierItems = filtered
          .where((item) => earlier.contains(item))
          .toList();

      return ListView(
        padding: const EdgeInsets.fromLTRB(14, 24, 14, 20),
        children: [
          if (todayItems.isNotEmpty) ...[
            _sectionTitle('TODAY', '${todayItems.length} updates'),
            const SizedBox(height: 12),
            ...todayItems.map(_notificationCard),
          ],
          if (earlierItems.isNotEmpty) ...[
            const SizedBox(height: 10),
            _sectionTitle('EARLIER', '${earlierItems.length} history'),
            const SizedBox(height: 12),
            ...earlierItems.map(_notificationCard),
          ],
          if (filtered.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 70),
              child: Center(
                child: Text(
                  'No notifications yet',
                  style: TextStyle(color: textMuted),
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget _sectionTitle(String title, String count) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: textMuted,
            letterSpacing: 0.3,
          ),
        ),
        if (title == 'TODAY') ...[
          const SizedBox(width: 7),
          const CircleAvatar(radius: 3, backgroundColor: darkPink),
        ],
        const Spacer(),
        Text(count, style: const TextStyle(fontSize: 10, color: textMuted)),
      ],
    );
  }

  Widget _notificationCard(_NotificationData item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: item.bgColor,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: item.isNew ? const Color(0xFFFBE0EC) : border,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: item.iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(item.icon, color: item.iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: textDark,
                        ),
                      ),
                    ),
                    if (item.time == 'Yesterday' ||
                        item.time.contains('days') ||
                        item.time == '2 hrs ago')
                      Text(
                        item.time,
                        style: const TextStyle(fontSize: 10, color: textMuted),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 11.5,
                    height: 1.4,
                    color: Color(0xFF654F56),
                  ),
                ),
                if (item.tag != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: item.tag == 'Completed'
                          ? const Color(0xFFE9F8F0)
                          : item.tag == 'Match Found'
                          ? const Color(0xFFEDE0FF)
                          : const Color(0xFFF0E7F8),
                      borderRadius: BorderRadius.circular(20),
                      border: item.tag == 'Completed'
                          ? Border.all(color: const Color(0xFFAFE5CB))
                          : null,
                    ),
                    child: Text(
                      item.tag!,
                      style: TextStyle(
                        fontSize: 10,
                        color: item.tag == 'Completed'
                            ? const Color(0xFF008A55)
                            : item.tag == 'Match Found'
                            ? purple
                            : const Color(0xFF654F56),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
                if (item.time.contains('ago') && item.time != '2 hrs ago') ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      if (item.isNew) ...[
                        const CircleAvatar(
                          radius: 3,
                          backgroundColor: darkPink,
                        ),
                        const SizedBox(width: 5),
                      ],
                      Expanded(
                        child: Text(
                          item.time,
                          style: TextStyle(
                            fontSize: 10,
                            color: item.isNew ? darkPink : textMuted,
                            fontWeight: item.isNew
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                      if (item.action != null)
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              Get.snackbar(
                                item.title,
                                item.action!,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 11,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: const Color(0xFFF8D7E6),
                                ),
                              ),
                              child: Text(
                                item.action!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: darkPink,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
                if (item.time == '2 hrs ago' && item.action != null) ...[
                  const SizedBox(height: 7),
                  GestureDetector(
                    onTap: () {
                      Get.snackbar('Chat', 'Opening chat...');
                    },
                    child: const Text(
                      'Reply in Chat →',
                      style: TextStyle(fontSize: 11, color: purple),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _bottomItem(IconData icon, String title) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Get.snackbar(title, '$title selected');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 21, color: const Color(0xFF654F56)),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF654F56),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationData {
  final int type;
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String? action;
  final String? tag;
  final bool isNew;

  const _NotificationData({
    required this.type,
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    this.action,
    this.tag,
    this.isNew = false,
  });
}
