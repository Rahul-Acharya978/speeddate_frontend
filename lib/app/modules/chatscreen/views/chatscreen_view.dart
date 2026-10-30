import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sundaymixer/app/modules/chat/views/chat_view.dart';

import '../controllers/chatscreen_controller.dart';

class ChatscreenView extends GetView<ChatscreenController> {
  const ChatscreenView({super.key});

  static const Color pink = Color(0xFFEB4078);
  static const Color darkPink = Color(0xFFB9134B);
  static const Color purple = Color(0xFF7932E6);
  static const Color background = Color(0xFFFFF7FC);
  static const Color textColor = Color(0xFF27222F);
  static const Color muted = Color(0xFF775E69);
  static const Color border = Color(0xFFF4E8F1);

  static const List<Map<String, dynamic>> matches = [
    {
      'name': 'Riya',
      'age': 24,
      'image': 'photo-1494790108377-be9c29b29330',
      'badge': 'NEW',
      'online': true,
    },
    {
      'name': 'Ananya',
      'age': 26,
      'image': 'photo-1534528741775-53994a69daeb',
      'badge': '',
      'online': true,
    },
    {
      'name': 'Tanvi',
      'age': 25,
      'image': 'photo-1524504388940-b1c1722653e1',
      'badge': 'Date #2',
      'online': false,
    },
    {
      'name': 'Sneha',
      'age': 27,
      'image': 'photo-1517841905240-472988babdf9',
      'badge': '',
      'online': true,
    },
    {
      'name': 'Spar',
      'age': '',
      'image': 'photo-1531123897727-8f129e1688ce',
      'badge': '',
      'online': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(ChatscreenController());
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 20,

        title: const Text(
          'Chat',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Get.snackbar('Profile', 'Profile tapped');
              },
              child: const CircleAvatar(
                radius: 17,
                backgroundColor: darkPink,
                child: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // _header(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _searchBar(),
                  _matchesSection(),
                  _recentChatsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  // Search
  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 22),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: border),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: muted, size: 21),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller.searchController,
                onChanged: controller.updateSearch,
                decoration: const InputDecoration(
                  hintText: 'Search messages or matches...',
                  hintStyle: TextStyle(fontSize: 13, color: muted),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
            GestureDetector(
              onTap: _showSortOptions,
              child: const CircleAvatar(
                radius: 17,
                backgroundColor: Color(0xFFF2EAF8),
                child: Icon(Icons.tune, size: 18, color: muted),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Mutual matches
  Widget _matchesSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Text(
                'Mutual Matches',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              const SizedBox(width: 8),
              const CircleAvatar(
                radius: 10,
                backgroundColor: pink,
                child: Text(
                  '4',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.snackbar('Matches', 'View all matches');
                },
                child: const Text(
                  'VIEW ALL',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: darkPink,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 112,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            scrollDirection: Axis.horizontal,
            itemCount: matches.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final item = matches[index];

              return SizedBox(
                width: 70,
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: index.isEven ? pink : purple,
                              width: 2,
                            ),
                          ),
                          child: _avatar(item['image'] as String, size: 62),
                        ),
                        if (item['online'] == true)
                          Positioned(
                            right: -1,
                            bottom: 1,
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: background,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        if ((item['badge'] as String).isNotEmpty)
                          Positioned(
                            top: -5,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: item['badge'] == 'NEW' ? pink : purple,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                item['badge'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${item['name']}, ${item['age']}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Recent chats
  Widget _recentChatsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 25, 12, 20),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Recent Chats',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
              Obx(
                () => PopupMenuButton<String>(
                  initialValue: controller.sortBy.value,
                  onSelected: controller.changeSort,
                  padding: EdgeInsets.zero,
                  child: Row(
                    children: [
                      Text(
                        controller.sortBy.value,
                        style: const TextStyle(
                          fontSize: 11,
                          color: muted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 17,
                        color: muted,
                      ),
                    ],
                  ),
                  itemBuilder: (_) => const [
                    PopupMenuItem(
                      value: 'Active First',
                      child: Text('Active First'),
                    ),
                    PopupMenuItem(
                      value: 'Newest First',
                      child: Text('Newest First'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Obx(() {
            final items = controller.filteredChats;

            if (items.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(30),
                child: Text('No chats found', style: TextStyle(color: muted)),
              );
            }

            return Column(children: items.map(_chatCard).toList());
          }),
        ],
      ),
    );
  }

  Widget _chatCard(ChatItem chat) {
    return GestureDetector(
      onTap: () {
        Get.to(ChatView());
        // Get.snackbar('Chat', 'Opening ${chat.name} conversation');
      },
      child: Card(
        margin: EdgeInsets.all(5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: Container(
          // margin: const EdgeInsets.only(bottom: 0),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: border),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  _avatar(chat.image, size: 56),
                  if (chat.isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 13),
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
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                        ),
                        if (chat.isVerified) ...[
                          const SizedBox(width: 4),
                          const Icon(Icons.verified, size: 15, color: purple),
                        ],
                      ],
                    ),
                    if (chat.badge.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      _badge(chat.badge),
                    ],
                    const SizedBox(height: 7),
                    Text(
                      chat.message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: muted),
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
                      fontSize: 11,
                      color: chat.unreadCount > 0 ? darkPink : muted,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (chat.unreadCount > 0)
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: pink,
                      child: Text(
                        '${chat.unreadCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    )
                  else
                    Icon(
                      chat.isRead ? Icons.done_all : Icons.done,
                      size: 16,
                      color: chat.isRead ? purple : muted,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _badge(String text) {
    final isSpeedDate = text.contains('Speed');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isSpeedDate ? const Color(0xFFFFE1E9) : const Color(0xFFEDE0FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: isSpeedDate ? darkPink : purple,
        ),
      ),
    );
  }

  Widget _avatar(String imageId, {required double size}) {
    return ClipOval(
      child: Image.network(
        'https://images.unsplash.com/$imageId?w=160&h=160&fit=crop&crop=faces',
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return Container(
            width: size,
            height: size,
            color: const Color(0xFFF0E5F4),
            child: const Icon(Icons.person, color: purple),
          );
        },
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
              const Text(
                'Sort conversations',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
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
