import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  //TODO: Implement ChatController

  final count = 0.obs;
  final messageController = TextEditingController();
  final RxList<ChatMessage> messages = <ChatMessage>[
    ChatMessage(
      text: 'Hey! 😊 It was really nice talking to you.',
      time: '10:24 PM',
      isMe: false,
      avatar: 'photo-1494790108377-be9c29b29330',
    ),
    ChatMessage(
      text: 'Hey Riya! I enjoyed our conversation too 😊',
      time: '10:25 PM',
      isMe: true,
    ),
    ChatMessage(
      text: "I didn't expect the 3 minutes to go so quickly!",
      time: '10:26 PM',
      isMe: false,
      avatar: 'photo-1534528741775-53994a69daeb',
    ),
    ChatMessage(
      text:
      'Same here 😁 We should definitely continue the conversation.',
      time: '10:27 PM',
      isMe: true,
    ),
    ChatMessage(
      text: 'Absolutely! What kind of music do you like? 🎸',
      time: '10:28 PM',
      isMe: false,
      avatar: 'photo-1524504388940-b1c1722653e1',
    ),
  ].obs;

  final RxBool isTyping = true.obs;

  void sendMessage() {
    final text = messageController.text.trim();

    if (text.isEmpty) return;

    messages.add(
      ChatMessage(
        text: text,
        time: TimeOfDay.now().format(
          Get.context!,
        ),
        isMe: true,
      ),
    );

    messageController.clear();
  }

  void showAttachmentOptions() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _AttachmentOption(
              icon: Icons.photo_outlined,
              label: 'Gallery',
            ),
            _AttachmentOption(
              icon: Icons.camera_alt_outlined,
              label: 'Camera',
            ),
            _AttachmentOption(
              icon: Icons.insert_drive_file_outlined,
              label: 'Document',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
class ChatMessage {
  final String text;
  final String time;
  final bool isMe;
  final String? avatar;

  ChatMessage({
    required this.text,
    required this.time,
    required this.isMe,
    this.avatar,
  });
}

class _AttachmentOption extends StatelessWidget {
  final IconData icon;
  final String label;

  const _AttachmentOption({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 30, color: Color(0xFF7932E6)),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}