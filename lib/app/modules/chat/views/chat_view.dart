import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  static const Color pink = Color(0xFFEB4078);
  static const Color darkPink = Color(0xFFB9134B);
  static const Color purple = Color(0xFF7932E6);
  static const Color background = Color(0xFFFFF7FC);
  static const Color textColor = Color(0xFF29232F);
  static const Color muted = Color(0xFF765E69);

  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(child: _messageList()),
            _messageInput(),
          ],
        ),
      ),
    );
  }

  // Chat header
  Widget _header() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: const BoxDecoration(
        color: background,
        boxShadow: [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: Get.back,
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: textColor,
              size: 23,
            ),
          ),
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: darkPink,
            ),
            child: const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 23,
            ),
          ),
          const SizedBox(width: 9),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Riya Sharma',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.circle, color: Color(0xFF10B981), size: 8),
                    SizedBox(width: 4),
                    Text(
                      'Online',
                      style: TextStyle(fontSize: 11, color: muted),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Get.snackbar('Video call', 'Video call tapped');
            },
            icon: const Icon(
              Icons.videocam_outlined,
              color: textColor,
              size: 25,
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: textColor),
            onSelected: (value) {
              Get.snackbar('Chat', value);
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'View profile', child: Text('View profile')),
              PopupMenuItem(
                value: 'Mute notifications',
                child: Text('Mute notifications'),
              ),
              PopupMenuItem(value: 'Report user', child: Text('Report user')),
            ],
          ),
        ],
      ),
    );
  }

  // Messages and date separator
  Widget _messageList() {
    return Obx(
      () => ListView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 18),
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFF0E6F5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Friday, Sep 23 • 10:24 PM',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: muted,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ...controller.messages.map(_messageBubble),
          if (controller.isTyping.value) _typingIndicator(),
        ],
      ),
    );
  }

  // Message bubble
  Widget _messageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: message.isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: message.isMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!message.isMe) ...[
                _avatar(message.avatar, size: 32),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 310),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    color: message.isMe ? null : Colors.white,
                    gradient: message.isMe
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [darkPink, pink, purple],
                            stops: [0.0, 0.40, 1.0],
                          )
                        : null,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(message.isMe ? 17 : 3),
                      topRight: Radius.circular(message.isMe ? 3 : 17),
                      bottomLeft: Radius.circular(message.isMe ? 17 : 17),
                      bottomRight: Radius.circular(message.isMe ? 17 : 17),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x10000000),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: message.isMe ? Colors.white : textColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 4,
              left: message.isMe ? 0 : 40,
              right: message.isMe ? 2 : 0,
            ),
            child: Row(
              mainAxisAlignment: message.isMe
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.time,
                  style: const TextStyle(
                    fontSize: 11,
                    color: muted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (message.isMe) ...[
                  const SizedBox(width: 4),
                  const Icon(Icons.done_all, size: 14, color: darkPink),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Typing indicator
  Widget _typingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(left: 40, top: 2),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
          decoration: BoxDecoration(
            color: const Color(0xFFF0E6F5),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _TypingDot(),
              SizedBox(width: 4),
              _TypingDot(),
              SizedBox(width: 4),
              _TypingDot(),
              SizedBox(width: 9),
              Text(
                'Riya is typing...',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: muted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Bottom message composer
  Widget _messageInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 12,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: controller.showAttachmentOptions,
            child: const CircleAvatar(
              radius: 22,
              backgroundColor: Color(0xFFEDE0FF),
              child: Icon(Icons.add, color: purple, size: 25),
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F0FC),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: const Color(0xFFF0E5F5)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.messageController,
                      textCapitalization: TextCapitalization.sentences,
                      onSubmitted: (_) => controller.sendMessage(),
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(fontSize: 13, color: muted),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.snackbar('Emoji', 'Emoji picker tapped');
                    },
                    child: const Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      size: 21,
                      color: muted,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 9),
          GestureDetector(
            onTap: controller.sendMessage,
            child: Container(
              height: 44,
              width: 44,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [darkPink, purple]),
              ),
              child: const Icon(Icons.mic_none, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  // Avatar
  Widget _avatar(String? imageId, {required double size}) {
    if (imageId == null) {
      return const SizedBox.shrink();
    }

    return ClipOval(
      child: Image.network(
        'https://images.unsplash.com/$imageId?w=100&h=100&fit=crop&crop=faces',
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: size,
          height: size,
          color: const Color(0xFFF0E5F5),
          child: const Icon(Icons.person, color: purple),
        ),
      ),
    );
  }
}

class _TypingDot extends StatelessWidget {
  const _TypingDot();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(radius: 3.5, backgroundColor: ChatView.purple);
  }
}
