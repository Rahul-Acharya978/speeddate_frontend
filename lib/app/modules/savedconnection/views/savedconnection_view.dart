import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/savedconnection_controller.dart';

class SavedconnectionView extends GetView<SavedconnectionController> {
  const SavedconnectionView({super.key});

  static const Color primaryPink = Color(0xFFE81759);
  static const Color purple = Color(0xFF9C27D5);
  static const Color background = Color(0xFFFAF8FC);
  static const Color textColor = Color(0xFF182238);
  static const Color secondaryText = Color(0xFF71809B);
  static const Color lightBg = Color(0xFFF0F4F8);

  @override
  Widget build(BuildContext context) {
    Get.put(SavedconnectionController());
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _header(),
            _tabs(),
            Expanded(
              child: Obx(() {
                final index = controller.selectedTab.value;

                return CustomScrollView(
                  key: PageStorageKey('saved-tab-$index'),
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    if (index == 1) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'People you liked',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Your connections are waiting to like you back.',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: secondaryText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ] else
                      const SliverToBoxAdapter(child: SizedBox(height: 12)),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((
                          context,
                          itemIndex,
                        ) {
                          final person = controller.currentList[itemIndex];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _personCard(person, tabIndex: index),
                          );
                        }, childCount: controller.currentList.length),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Header
  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
      child: Row(
        children: [
          IconButton(
            onPressed: Get.back,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 23,
              color: textColor,
            ),
          ),
          const Expanded(
            child: Text(
              'Saved Connections',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
                color: textColor,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Get.snackbar('Filters', 'Connect your filter screen here');
            },
            icon: const Icon(Icons.tune_rounded, color: textColor, size: 22),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [primaryPink, purple]),
              boxShadow: [
                BoxShadow(
                  color: Color(0x33E81759),
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 21),
          ),
        ],
      ),
    );
  }

  // Three tabs
  Widget _tabs() {
    return Obx(() {
      final selected = controller.selectedTab.value;

      return SizedBox(
        height: 43,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          scrollDirection: Axis.horizontal,
          children: [
            _tabItem(
              title: 'They Liked You',
              count: 5,
              index: 0,
              selected: selected,
              icon: Icons.auto_awesome,
            ),
            const SizedBox(width: 9),
            _tabItem(
              title: 'You Liked',
              count: 8,
              index: 1,
              selected: selected,
            ),
            const SizedBox(width: 9),
            _tabItem(
              title: 'Mutual',
              count: 3,
              index: 2,
              selected: selected,
              icon: Icons.circle,
            ),
          ],
        ),
      );
    });
  }

  Widget _tabItem({
    required String title,
    required int count,
    required int index,
    required int selected,
    IconData? icon,
  }) {
    final active = selected == index;

    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 50),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            gradient: active
                ? const LinearGradient(colors: [primaryPink, purple])
                : null,
            color: active ? null : const Color(0xFFF0F3F8),
            borderRadius: BorderRadius.circular(28),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: primaryPink.withValues(alpha: 0.16),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 13, color: active ? Colors.white : purple),
                const SizedBox(width: 5),
              ],
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                  color: active ? Colors.white : const Color(0xFF40506A),
                ),
              ),
              const SizedBox(width: 7),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: active
                      ? Colors.white.withValues(alpha: 0.24)
                      : const Color(0xFFE1E8F0),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: active ? Colors.white : const Color(0xFF40506A),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Profile card
  Widget _personCard(Map<String, dynamic> person, {required int tabIndex}) {
    final isTheyLiked = tabIndex == 0;
    final isYouLiked = tabIndex == 1;
    final isMutual = tabIndex == 2;

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: const Color(0xFFF0EFF5)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x080E1B35),
              blurRadius: 13,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _profileImage(person, isYouLiked),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${person['name']}, ${person['age']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: secondaryText,
                          ),
                          const SizedBox(width: 3),
                          Flexible(
                            child: Text(
                              person['city'].toString(),
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: secondaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            isMutual
                                ? Icons.check_circle
                                : isYouLiked
                                ? Icons.access_time_rounded
                                : Icons.auto_awesome,
                            size: 13,
                            color: isMutual
                                ? const Color(0xFF6250F5)
                                : isYouLiked
                                ? secondaryText
                                : purple,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              person['message'].toString(),
                              maxLines: isMutual ? 2 : 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11.5,
                                height: 1.35,
                                color: isMutual
                                    ? const Color(0xFF5540E8)
                                    : isYouLiked
                                    ? const Color(0xFF50617D)
                                    : purple,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                _statusBadge(
                  isTheyLiked
                      ? '♥ Liked You'
                      : isYouLiked
                      ? '♧ Waiting for Response'
                      : '♥ Mutual Match',
                  type: tabIndex,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _eventDetails(person, tabIndex),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _actionButton(
                    text: 'View Profile',
                    onTap: () => controller.viewProfile(person),
                    primary: false,
                    mutual: isMutual,
                  ),
                ),
                if (!isYouLiked) ...[
                  const SizedBox(width: 10),
                  Expanded(
                    child: _actionButton(
                      text: isMutual ? 'Start Chat' : '♥  Like Back',
                      onTap: () => isMutual
                          ? controller.startChat(person)
                          : controller.likeBack(person),
                      primary: true,
                      mutual: isMutual,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileImage(Map<String, dynamic> person, bool waiting) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 57,
          height: 57,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFF0C7E4), width: 1.4),
          ),
          child: ClipOval(
            child: Image.network(
              person['image'].toString(),
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFFF4E6F4),
                child: const Icon(Icons.person, color: purple, size: 30),
              ),
            ),
          ),
        ),
        if (waiting)
          Positioned(
            bottom: 0,
            right: -2,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.hourglass_bottom_rounded,
                color: secondaryText,
                size: 15,
              ),
            ),
          ),
      ],
    );
  }

  Widget _statusBadge(String text, {required int type}) {
    final bg = type == 1 ? const Color(0xFFFFF1F2) : const Color(0xFFF3E8FF);

    final fg = type == 1 ? const Color(0xFFE11D48) : const Color(0xFF7E22CE);

    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: type == 1 ? Border.all(color: const Color(0xFFFFD4DA)) : null,
        ),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: fg,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _eventDetails(Map<String, dynamic> person, int tabIndex) {
    final isMutual = tabIndex == 2;
    final isYouLiked = tabIndex == 1;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isMutual || isYouLiked
            ? const Color(0xFFF6F9FC)
            : const Color(0xFFFAF7FD),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFF2F7), width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                person['eventIcon'] == 'coffee'
                    ? Icons.coffee_outlined
                    : person['eventIcon'] == 'sun'
                    ? Icons.wb_twilight_rounded
                    : Icons.bolt_rounded,
                size: 16,
                color: person['eventIcon'] == 'coffee'
                    ? const Color(0xFFF59E0B)
                    : primaryPink,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  person['event'].toString(),
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: isTheyLikedText(tabIndex) ? primaryPink : textColor,
                  ),
                ),
              ),
              if (isMutual || tabIndex == 0) ...[
                const SizedBox(width: 4),
                _durationBadge(person['duration'].toString()),
              ],
            ],
          ),
          if (isYouLiked) ...[
            const SizedBox(height: 8),
            _durationBadge(person['duration'].toString()),
          ],
          const SizedBox(height: 10),
          Wrap(
            spacing: 9,
            runSpacing: 7,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _detailItem(
                Icons.calendar_today_outlined,
                person['date'].toString(),
              ),
              _dot(),
              _detailItem(Icons.access_time_rounded, person['time'].toString()),
              _dot(),
              _detailItem(Icons.videocam_outlined, 'Video date', color: purple),
            ],
          ),
        ],
      ),
    );
  }

  bool isTheyLikedText(int tabIndex) => tabIndex == 0;

  Widget _durationBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EEF5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.timer_outlined, size: 12, color: Color(0xFF53647E)),
          const SizedBox(width: 3),
          Text(
            text,
            style: const TextStyle(fontSize: 10, color: Color(0xFF53647E)),
          ),
        ],
      ),
    );
  }

  Widget _detailItem(
    IconData icon,
    String text, {
    Color color = secondaryText,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 10.5, color: color)),
      ],
    );
  }

  Widget _dot() {
    return Container(
      width: 3,
      height: 3,
      decoration: const BoxDecoration(
        color: Color(0xFFD0D8E4),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _actionButton({
    required String text,
    required VoidCallback onTap,
    required bool primary,
    required bool mutual,
  }) {
    return SizedBox(
      height: 42,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: primary
              ? const LinearGradient(colors: [primaryPink, purple])
              : null,
          color: primary
              ? null
              : mutual
              ? const Color(0xFFF0EBFC)
              : lightBg,
          borderRadius: BorderRadius.circular(30),
          boxShadow: primary
              ? const [
                  BoxShadow(
                    color: Color(0x22E81759),
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onTap,
            child: Center(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: primary ? Colors.white : const Color(0xFF344258),
                ),
              ),
            ),
          ),
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
