import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sundaymixer/app/modules/chat/views/chat_view.dart';
import 'package:sundaymixer/app/modules/userprofile/views/userprofile_view.dart';

import '../controllers/chatscreen_controller.dart';

class ChatscreenView extends GetView<ChatscreenController> {
  const ChatscreenView({super.key});

  static const Color pink = Color(0xFFE11D5A);
  static const Color purple = Color(0xFF7B3FE4);
  static const Color background = Color(0xFFFBF7FC);
  static const Color textColor = Color(0xFF1C1824);
  static const Color muted = Color(0xFF8D8796);
  static const Color soft = Color(0xFFF3EEF6);

  @override
  Widget build(BuildContext context) {
    Get.put(ChatscreenController());
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _header(),
            _searchBar(),
            _recentLabel(),
            Expanded(
              child: Obx(() {
                final items = controller.filteredChats;
                if (items.isEmpty) {
                  return const Center(
                    child: Text('No chats found', style: TextStyle(color: muted)),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, index) => _chatCard(items[index]),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 16, 4),
      child: Row(
        children: [
          const Text(
            'Chat',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: textColor, letterSpacing: -0.4),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Get.to(() => const UserprofileView()),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(color: pink, shape: BoxShape.circle),
              child: const Icon(Icons.person, color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: SizedBox(
        height: 48,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(color: Color(0x0A1A1030), blurRadius: 12, offset: Offset(0, 4)),
                ],
              ),
              child: TextField(
                controller: controller.searchController,
                onChanged: controller.updateSearch,
                style: const TextStyle(fontSize: 14, color: textColor),
                decoration: const InputDecoration(
                  hintText: 'Search messages or matches...',
                  hintStyle: TextStyle(fontSize: 14, color: Color(0xFFB7B0BE)),
                  prefixIcon: Icon(Icons.search, color: Color(0xFFB7B0BE), size: 22),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(0, 14, 52, 14),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: GestureDetector(
                onTap: _showSortOptions,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(color: soft, shape: BoxShape.circle),
                  child: const Icon(Icons.tune_rounded, size: 18, color: Color(0xFF8A8494)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recentLabel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 16, 10),
      child: Row(
        children: [
          const Text(
            'Recent Chats',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF3A3542)),
          ),
          const Spacer(),
          Obx(
            () => PopupMenuButton<String>(
              initialValue: controller.sortBy.value,
              onSelected: controller.changeSort,
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  Text(
                    controller.sortBy.value,
                    style: const TextStyle(fontSize: 13, color: muted, fontWeight: FontWeight.w600),
                  ),
                  const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: muted),
                ],
              ),
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'Active First', child: Text('Active First')),
                PopupMenuItem(value: 'Newest First', child: Text('Newest First')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chatCard(ChatItem chat) {
    final unread = chat.unreadCount > 0;
    return GestureDetector(
      onTap: () => Get.to(() => ChatView(person: {
            'name': chat.name,
            'image': 'https://images.unsplash.com/${chat.image}?w=200&h=200&fit=crop&crop=faces',
          })),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 14, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Color(0x0C1A1030), blurRadius: 16, offset: Offset(0, 6)),
          ],
        ),
        child: Row(
          children: [
            _avatar(chat),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          chat.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: textColor),
                        ),
                      ),
                      if (chat.isVerified) ...[
                        const SizedBox(width: 5),
                        Container(
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(color: purple, shape: BoxShape.circle),
                          child: const Icon(Icons.check, size: 11, color: Colors.white),
                        ),
                      ],
                    ],
                  ),
                  if (chat.badge.isNotEmpty) ...[
                    const SizedBox(height: 5),
                    _badge(chat.badge),
                  ],
                  const SizedBox(height: 5),
                  Text(
                    chat.message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, color: Color(0xFF8A8494)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat.time,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: unread ? FontWeight.w700 : FontWeight.w500,
                    color: unread ? pink : muted,
                  ),
                ),
                const SizedBox(height: 10),
                if (unread)
                  Container(
                    width: 22,
                    height: 22,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: pink, shape: BoxShape.circle),
                    child: Text(
                      '${chat.unreadCount}',
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  )
                else
                  Icon(
                    chat.isRead ? Icons.done_all_rounded : Icons.done_rounded,
                    size: 18,
                    color: chat.isRead ? purple : const Color(0xFFC5BEC8),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _badge(String text) {
    final speed = text.toLowerCase().contains('speed');
    final label = speed ? 'Speed Date Match' : text.replaceAll('⚡', '').trim();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: speed ? const Color(0xFFFFE4EC) : const Color(0xFFEDE7FE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (speed) ...[
            const Icon(Icons.bolt, size: 12, color: pink),
            const SizedBox(width: 2),
          ],
          Text(
            label,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: speed ? pink : purple),
          ),
        ],
      ),
    );
  }

  Widget _avatar(ChatItem chat) {
    return SizedBox(
      width: 54,
      height: 54,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipOval(
            child: Image.network(
              'https://images.unsplash.com/${chat.image}?w=160&h=160&fit=crop&crop=faces',
              width: 52,
              height: 52,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 52,
                height: 52,
                color: soft,
                child: const Icon(Icons.person, color: purple),
              ),
            ),
          ),
          if (chat.isOnline)
            Positioned(
              right: 0,
              bottom: 2,
              child: Container(
                width: 13,
                height: 13,
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showSortOptions() {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Sort conversations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              ListTile(
                title: const Text('Active First'),
                onTap: () {
                  controller.changeSort('Active First');
                  Get.back();
                },
              ),
              ListTile(
                title: const Text('Newest First'),
                onTap: () {
                  controller.changeSort('Newest First');
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
