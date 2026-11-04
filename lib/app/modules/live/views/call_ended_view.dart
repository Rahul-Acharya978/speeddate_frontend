import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/api_config.dart';
import '../../../data/speed_date_api.dart';
import '../../waitingroom/views/waitingroom_view.dart';

class CallEndedView extends StatefulWidget {
  const CallEndedView({
    super.key,
    required this.eventId,
    required this.partnerId,
    required this.name,
    required this.photo,
    required this.age,
    required this.seconds,
    required this.roundSeconds,
  });

  final String eventId;
  final String partnerId;
  final String name;
  final String photo;
  final int age;
  final int seconds;
  final int roundSeconds;

  @override
  State<CallEndedView> createState() => _CallEndedState();
}

class _CallEndedState extends State<CallEndedView> {
  bool _busy = false;

  String get _photoUrl {
    final photo = widget.photo.trim();
    if (photo.isEmpty) return '';
    if (photo.startsWith('http')) return photo;
    return ApiConfig.url(photo);
  }

  String _clock(int value) {
    final total = value < 0 ? 0 : value;
    final minutes = (total ~/ 60).toString().padLeft(2, '0');
    final seconds = (total % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<void> _choose(bool save) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await SpeedDateApi.saveProfile(
        eventId: widget.eventId,
        partnerId: widget.partnerId,
        save: save,
        durationSeconds: widget.seconds,
      );
    } catch (_) {}
    if (!mounted) return;
    Get.off(() => WaitingroomView(eventId: widget.eventId));
  }

  @override
  Widget build(BuildContext context) {
    final photo = _photoUrl;
    final first = widget.name.trim().split(' ').first;
    final spoken = first.isEmpty ? 'them' : first;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (photo.isNotEmpty)
            Image.network(photo, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const _ThemeWash())
          else
            const _ThemeWash(),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
            child: Container(
              color: photo.isEmpty ? const Color(0x66FFFFFF) : const Color(0x33000000),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${_clock(widget.seconds)} / ${_clock(widget.roundSeconds)}',
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: _busy ? null : () => Get.off(() => WaitingroomView(eventId: widget.eventId)),
                        icon: const Icon(Icons.close, color: Colors.white),
                        style: IconButton.styleFrom(backgroundColor: Colors.white24),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.fromLTRB(22, 0, 22, 28),
                  padding: const EdgeInsets.fromLTRB(22, 22, 22, 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [Color(0xFFFF4D7A), Color(0xFF7B3FE4)]),
                        ),
                        child: const Icon(Icons.call, color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      const Text('Call Ended', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      const Text('That was a good one!', style: TextStyle(color: Color(0xFF7A8499))),
                      const SizedBox(height: 16),
                      CircleAvatar(
                        radius: 34,
                        backgroundColor: const Color(0xFFF3E8FF),
                        backgroundImage: photo.isEmpty ? null : NetworkImage(photo),
                        child: photo.isEmpty ? const Icon(Icons.person, color: Color(0xFF7B3FE4)) : null,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.age > 0 ? '${widget.name}, ${widget.age}' : widget.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF1F6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${_clock(widget.seconds)} min conversation',
                          style: const TextStyle(color: Color(0xFFE23B73), fontWeight: FontWeight.w700, fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('Would you like to save $spoken?', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                      const SizedBox(height: 4),
                      const Text(
                        'Save this profile to keep the connection going.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF7A8499)),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [Color(0xFFFF4D7A), Color(0xFF7B3FE4)]),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: TextButton.icon(
                            onPressed: _busy ? null : () => _choose(true),
                            icon: const Icon(Icons.favorite, color: Colors.white, size: 18),
                            label: const Text('Save Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: TextButton(
                          onPressed: _busy ? null : () => _choose(false),
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFF4F0F6),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                          ),
                          child: const Text('Not for Me', style: TextStyle(color: Color(0xFF3A4256), fontWeight: FontWeight.w700)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Only a mutual save becomes a match.',
                        style: TextStyle(color: Color(0xFF98A2B3), fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeWash extends StatelessWidget {
  const _ThemeWash();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF4D7A), Color(0xFF7B3FE4)],
        ),
      ),
    );
  }
}
