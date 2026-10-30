import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_subscription_controller.dart';

class ChatSubscriptionView extends GetView<ChatSubscriptionController> {
  const ChatSubscriptionView({super.key});

  static const Color pink = Color(0xFFC6094B);
  static const Color brightPink = Color(0xFFFF4F7B);
  static const Color purple = Color(0xFF7932D6);
  static const Color dark = Color(0xFF211D29);
  static const Color muted = Color(0xFF705761);

  @override
  Widget build(BuildContext context) {
    Get.put(ChatSubscriptionController());
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FF),
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Column(
                  children: [
                    _specialBadge(),
                    const SizedBox(height: 34),
                    const Text(
                      'Keep the conversation going',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: dark,
                        letterSpacing: -0.7,
                      ),
                    ),
                    const SizedBox(height: 17),
                    const Text(
                      'Chat with your mutual speed matches anytime.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: muted),
                    ),
                    const SizedBox(height: 21),
                    _matchCard(),
                    const SizedBox(height: 17),
                    _subscriptionCard(),
                    const SizedBox(height: 10),
                    _bottomSection(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFFFFF7FF),
        border: Border(
          bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.08)),
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: Get.back,
            borderRadius: BorderRadius.circular(25),
            child: const SizedBox(
              width: 32,
              height: 42,
              child: Icon(Icons.close, size: 23, color: dark),
            ),
          ),
          const Expanded(
            child: Text(
              'Spark Pass',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: dark,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: 33,
            height: 33,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: pink,
              boxShadow: [
                BoxShadow(
                  color: Color(0x30C6094B),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
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

  Widget _specialBadge() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(30),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF5E8FA),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFFF0E2F4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 52,
              height: 25,
              child: Stack(
                children: [
                  Positioned(left: 0, child: _miniAvatar('👩🏻')),
                  Positioned(left: 16, child: _miniAvatar('👩🏽')),
                  Positioned(left: 32, child: _miniAvatar('👩🏼')),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.favorite, color: pink, size: 14),
            const SizedBox(width: 4),
            const Text(
              'MUTUAL MATCH SPECIAL',
              style: TextStyle(
                color: dark,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniAvatar(String emoji) {
    return Container(
      width: 25,
      height: 25,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFFFD9CC),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Text(emoji, style: const TextStyle(fontSize: 15)),
    );
  }

  Widget _matchCard() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(0),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(15, 17, 15, 13),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFF8EEF5)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6D335A).withValues(alpha: 0.035),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFE4D8),
                      ),
                      child: const Text('👩🏻', style: TextStyle(fontSize: 28)),
                    ),
                    Positioned(
                      bottom: -1,
                      right: -1,
                      child: Container(
                        width: 13,
                        height: 13,
                        decoration: BoxDecoration(
                          color: const Color(0xFF12B886),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Riya, 24',
                            style: TextStyle(
                              fontSize: 17,
                              color: dark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(Icons.verified, size: 16, color: pink),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Matched 12 mins ago • Mutual\nSave',
                        style: TextStyle(
                          fontSize: 12,
                          color: muted,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Icon(Icons.lock_outline, size: 14, color: pink),
                const SizedBox(width: 4),
                const Expanded(
                  child: Text(
                    'Unlocked via Mutual Speed Date',
                    style: TextStyle(fontSize: 12, color: muted),
                  ),
                ),
                GestureDetector(
                  onTap: controller.onSubscribe,
                  child: const Text(
                    '1 Click Connect',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: pink,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _subscriptionCard() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(0),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 17, 16, 19),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF39203B).withValues(alpha: 0.10),
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Monthly Chat Pass',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: dark,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  '₹99',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    height: 1,
                    color: dark,
                  ),
                ),
                const SizedBox(width: 7),
                const Padding(
                  padding: EdgeInsets.only(top: 9),
                  child: Text(
                    '/ month',
                    style: TextStyle(fontSize: 14, color: muted),
                  ),
                ),
                const SizedBox(width: 9),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFE0FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Special Match Rate',
                    style: TextStyle(color: Color(0xFF57318D), fontSize: 10),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Cancel anytime with 1 tap • Auto-renews monthly',
              style: TextStyle(fontSize: 12, color: muted),
            ),
            const SizedBox(height: 9),
            const Divider(height: 1, color: Color(0xFFF0E5F2)),
            const SizedBox(height: 10),
            _benefit('Unlimited direct chat with all mutual speed\nmatches'),
            _benefit('Continue conversations without expiry\ntimers'),
            _benefit('Message all saved connections anytime'),
            _benefit('Zero per-message coins or hidden fees'),
          ],
        ),
      ),
    );
  }

  Widget _benefit(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.only(top: 1),
            decoration: const BoxDecoration(
              color: Color(0xFFFFD8DF),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 16, color: pink),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: dark, fontSize: 14, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: const BoxDecoration(color: Color(0xFFFFF7FF)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: controller.onSubscribe,
            child: Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [pink, brightPink, purple],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: brightPink.withValues(alpha: 0.27),
                    blurRadius: 17,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Subscribe for ₹99',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(width: 7),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 21),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: controller.onMaybeLater,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'Maybe Later',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF62414F),
                ),
              ),
            ),
          ),
          const SizedBox(height: 17),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shield_outlined, size: 12, color: muted),
              SizedBox(width: 4),
              Flexible(
                child: Text(
                  '100% Safe & Confidential • Billed securely via Google Play / UPI',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: muted),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
