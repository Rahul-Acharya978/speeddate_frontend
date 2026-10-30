import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/subscriptionsuccessful_controller.dart';

class SubscriptionsuccessfulView
    extends GetView<SubscriptionsuccessfulController> {
  const SubscriptionsuccessfulView({super.key});

  static const Color pink = Color(0xFFFF4F7B);
  static const Color darkPink = Color(0xFFC6094B);
  static const Color purple = Color(0xFF7932D6);
  static const Color dark = Color(0xFF211D29);
  static const Color muted = Color(0xFF705761);
  static const Color background = Color(0xFFFFF7FF);

  @override
  Widget build(BuildContext context) {
    Get.put(SubscriptionsuccessfulController());
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 64,
        titleSpacing: 0,
        title: const Text(
          'Subscription Success',
          style: TextStyle(
            color: Color(0xFF211D29),
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: controller.onClose,
          icon: Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFFF8F0FC),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, color: Color(0xFF211D29), size: 22),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              width: 33,
              height: 33,
              decoration: const BoxDecoration(
                color: Color(0xFFC6094B),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 21,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
                child: Column(
                  children: [
                    _buildSuccessIcon(),
                    const SizedBox(height: 17),
                    const Text(
                      "You're all set!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        color: dark,
                        letterSpacing: -0.7,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Your Chat Pass is active.',
                      style: TextStyle(fontSize: 14, color: muted),
                    ),
                    const SizedBox(height: 28),
                    _buildPlanCard(),
                    const SizedBox(height: 16),
                    _buildMatchCard(),
                    const SizedBox(height: 23),
                    _buildStartChattingButton(),
                    const SizedBox(height: 9),
                    _buildViewMatchesButton(),
                    const SizedBox(height: 20),
                    _buildReceiptText(),
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
  Widget _buildAppBar() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.65),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFECE1EE).withValues(alpha: 0.5),
          ),
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: controller.onClose,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFFF8F0FC),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: dark, size: 22),
            ),
          ),
          const Expanded(
            child: Text(
              'Subscription Success',
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

  // Success icon
  Widget _buildSuccessIcon() {
    return Container(
      width: 104,
      height: 104,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C367F).withValues(alpha: 0.20),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFF9B38BE), Color(0xFFCE3FA5), Color(0xFFFF4F7B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Icon(Icons.check, color: Colors.white, size: 42),
      ),
    );
  }

  // Current plan card
  Widget _buildPlanCard() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(24),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4C304D).withValues(alpha: 0.10),
              blurRadius: 7,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'CURRENT PLAN',
                    style: TextStyle(
                      color: muted,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F0FC),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle, size: 9, color: Color(0xFF10B981)),
                      SizedBox(width: 5),
                      Text(
                        'Active',
                        style: TextStyle(
                          color: dark,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            const Text(
              'Monthly Chat Pass',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: dark,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 11),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  '₹99',
                  style: TextStyle(
                    fontSize: 29,
                    height: 1,
                    fontWeight: FontWeight.w800,
                    color: dark,
                  ),
                ),
                const SizedBox(width: 5),
                const Padding(
                  padding: EdgeInsets.only(bottom: 3),
                  child: Text(
                    '/ month',
                    style: TextStyle(fontSize: 12, color: muted),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Renews monthly • Cancel anytime in Settings',
              style: TextStyle(fontSize: 12, color: muted),
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(9, 9, 9, 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFBF7FF),
                borderRadius: BorderRadius.circular(17),
              ),
              child: const Column(
                children: [
                  _PlanBenefit(
                    text: 'Unlimited messaging with mutual\nmatches',
                  ),
                  SizedBox(height: 6),
                  _PlanBenefit(text: 'Send voice notes & photos'),
                  SizedBox(height: 6),
                  _PlanBenefit(text: 'Never miss a spark after speed dating'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Match profile card
  Widget _buildMatchCard() {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF7EEFC),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 55,
                  height: 55,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFC13EAB),
                      width: 2,
                    ),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Color(0xFFFFDFD4),
                    child: Text('👩🏻', style: TextStyle(fontSize: 29)),
                  ),
                ),
                Positioned(
                  right: -1,
                  bottom: 0,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Riya Sharma, 24',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.verified, size: 14, color: darkPink),
                    ],
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Riya is waiting for your message! Say hello to your speed date match.',
                    style: TextStyle(color: muted, fontSize: 11.5, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Primary button
  Widget _buildStartChattingButton() {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(35),
      child: InkWell(
        onTap: controller.onStartChatting,
        borderRadius: BorderRadius.circular(35),
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [pink, darkPink, purple],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: pink.withValues(alpha: 0.20),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Start Chatting',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Secondary button
  Widget _buildViewMatchesButton() {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(35),
      child: InkWell(
        onTap: controller.onViewMatches,
        borderRadius: BorderRadius.circular(35),
        child: Container(
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(35),
            border: Border.all(color: const Color(0xFFF5ECF7)),
          ),
          child: const Text(
            'View My Matches',
            style: TextStyle(
              color: dark,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // Receipt message
  Widget _buildReceiptText() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.lock_outline, size: 13, color: muted),
        SizedBox(width: 5),
        Flexible(
          child: Text(
            'Receipt sent to your registered email • Safe & Secure',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: muted),
          ),
        ),
      ],
    );
  }
}

class _PlanBenefit extends StatelessWidget {
  final String text;

  const _PlanBenefit({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          margin: const EdgeInsets.only(top: 1),
          decoration: const BoxDecoration(
            color: Color(0xFFFFD9E0),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, size: 14, color: Color(0xFFC6094B)),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF302936),
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
