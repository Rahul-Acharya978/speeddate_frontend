import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sundaymixer/app/modules/notification/views/notification_view.dart';

import '../../completeYourProfile/views/complete_your_profile_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const Color pink = Color(0xFFE91E63);
  static const Color purple = Color(0xFF8138D4);
  static const Color bgColor = Color(0xFFFFF8FF);
  static const Color dark = Color(0xFF24202C);

  static const LinearGradient appGradient = LinearGradient(
    colors: [Color(0xFFEB4078), Color(0xFF7932E6)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const String speedDatingImage =
      'https://images.unsplash.com/photo-1511795409834-ef04bbd61622'
      '?auto=format&fit=crop&w=1000&q=85';

  static const String coffeeImage =
      'https://images.unsplash.com/photo-1528605248644-14dd04022da1'
      '?auto=format&fit=crop&w=800&q=85';

  static const String partyImage =
      'https://images.unsplash.com/photo-1519671482749-fd09be7ccebf'
      '?auto=format&fit=crop&w=800&q=85';

  static const String dinnerImage =
      'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4'
      '?auto=format&fit=crop&w=800&q=85';

  static const String profileImage =
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e'
      '?auto=format&fit=crop&w=200&q=80';

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final isWide = width >= 700;
    final pagePadding = width < 360 ? 14.0 : 12.0;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              children: [
                _buildAppBar(context, pagePadding),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      bottom: 18,
                      left: pagePadding,
                      right: pagePadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        _buildProfileCard(context),
                        const SizedBox(height: 16),
                        _buildSearchBar(context),
                        const SizedBox(height: 16),
                        _buildLiveEvent(context),
                        const SizedBox(height: 28),
                        _buildSectionHeader(
                          'More Live Events',
                          '4 Active',
                          'View All (4)',
                          () => _showMessage('All live events'),
                        ),
                        const SizedBox(height: 12),
                        _buildLiveEventsList(context),
                        const SizedBox(height: 28),
                        _buildSectionHeader(
                          'Upcoming Events',
                          '2',
                          'View All',
                          () => _showMessage('Upcoming events'),
                        ),
                        const SizedBox(height: 12),
                        _buildUpcomingEvents(context, isWide),
                        const SizedBox(height: 28),
                        _buildSectionHeader(
                          'Your Upcoming Events',
                          '2',
                          'View All',
                          () => _showMessage('Your registered events'),
                        ),
                        const SizedBox(height: 12),
                        _buildUpcomingEvents(context, isWide, registered: true),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  // ---------------- APP BAR ----------------

  Widget _buildAppBar(BuildContext context, double padding) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFAFF),
        border: Border(bottom: BorderSide(color: Color(0xFFF5EAF8))),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              gradient: appGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x30D20B4F),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.local_fire_department_rounded,
              color: Colors.white,
              size: 23,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Home',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: dark,
            ),
          ),
          const Spacer(),
          _roundIcon(Icons.search_rounded, () => _showMessage('Search events')),
          const SizedBox(width: 12),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () { Get.to(NotificationView());},
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  size: 27,
                  color: Color(0xFF65535F),
                ),
              ),
              Positioned(
                right: 7,
                top: 8,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: pink,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () {
              Get.to(CompleteYourProfileView());
            },
            child: ClipOval(
              child: Image.network(
                profileImage,
                width: 34,
                height: 34,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const CircleAvatar(radius: 17, child: Icon(Icons.person)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _roundIcon(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(icon, color: dark, size: 22),
        ),
      ),
    );
  }

  // ---------------- PROFILE CARD ----------------

  Widget _buildProfileCard(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: purple.withValues(alpha: 0.06),
              blurRadius: 18,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    ClipOval(
                      child: Image.network(
                        profileImage,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const CircleAvatar(child: Icon(Icons.person)),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: const Color(0xFF20B486),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          'Hi, ${controller.name.value} ✨',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: HomeView.dark,
                          ),
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Ready to meet\nsomeone new?',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.3,
                          color: Color(0xFF6D5C68),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 150),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _showMessage('Complete your profile'),
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            gradient: appGradient,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  'Complete Profile',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Obx(
                  () => Text(
                    '${controller.age.value} • ${controller.city.value}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: dark,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Flexible(child: _VerifiedBadge()),
                Spacer(),
                Obx(
                  () => Text(
                    '${controller.profileCompletionPercent.value}% Done',
                    style: TextStyle(
                      color: Color(0xFF72515D),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 6,
                color: const Color(0xFFF0E5F8),
                child: Obx(
                      () => Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor:
                      (controller.profileCompletionPercent.value / 100)
                          .clamp(0.0, 1.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFFF4F7B),
                              Color(0xFFB9134B),
                              Color(0xFF8455EF),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ---------------- SEARCH ----------------

  Widget _buildSearchBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: const Color(0xFFF2EAF9),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: Color(0xFF6C5268), size: 21),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Search events, hosts, city...',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Color(0xFF968394), fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Material(
          color: const Color(0xFFF2EAF9),
          borderRadius: BorderRadius.circular(30),
          child: InkWell(
            onTap: () => _showMessage('Filter events'),
            borderRadius: BorderRadius.circular(30),
            child: const SizedBox(
              width: 45,
              height: 45,
              child: Icon(Icons.tune_rounded, color: Color(0xFF665365)),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- LIVE EVENT HERO ----------------

  Widget _buildLiveEvent(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final heroHeight = (width * 0.47).clamp(190.0, 270.0);

    return Card(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: purple.withValues(alpha: 0.10),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: heroHeight,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      speedDatingImage,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(color: const Color(0xFF51343F)),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0x33000000),
                            Color(0x11000000),
                            Color(0xDD000000),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 10,
                      right: 10,
                      child: Row(
                        children: [
                          Flexible(
                            child: _heroPill(
                              Icons.check_circle,
                              'SEAT CONFIRMED',
                              Colors.white,
                              dark,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: _heroPill(
                              Icons.circle,
                              'STARTS IN 02:12',
                              const Color(0xFFC20C50),
                              Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 14,
                      right: 14,
                      bottom: 15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                color: Colors.white,
                                size: 15,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'TONIGHT • 8:00 PM',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Speed Dating Night',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Row(
                            children: [
                              Icon(
                                Icons.settings_suggest_outlined,
                                color: Colors.white70,
                                size: 14,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Hosted by Ananya & Team',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _gradientButton(
              text: 'Join Live Event',
              icon: Icons.arrow_forward_rounded,
              onTap: () => _showMessage('Join live event'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _heroPill(
    IconData icon,
    String text,
    Color background,
    Color foreground,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: foreground),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: foreground,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _gradientButton({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            gradient: appGradient,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: pink.withValues(alpha: 0.20),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 7),
              Icon(icon, color: Colors.white, size: 19),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- SECTION HEADER ----------------

  Widget _buildSectionHeader(
    String title,
    String count,
    String action,
    VoidCallback onTap,
  ) {
    return Row(
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: dark,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFEDE0FF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            count,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: purple,
            ),
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                action,
                style: const TextStyle(
                  color: Color(0xFFD20B4F),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (action.startsWith('View All')) ...[
                const SizedBox(width: 2),
                const Icon(Icons.chevron_right, size: 15, color: pink),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // ---------------- MORE LIVE EVENTS ----------------

  Widget _buildLiveEventsList(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final cardWidth = (width * 0.64).clamp(245.0, 310.0);

    return SizedBox(
      height: 170,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(
            width: cardWidth,
            child: _buildLiveSmallCard(
              image: dinnerImage,
              title: 'Creatives & Introverts',
              host: 'Host: Ananya • Speed Lounge',
              spots: '18 spots left',
              price: '₹199',
              location: 'Indore',
              onTap: () => _showMessage('Register for Creatives & Introverts'),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: cardWidth,
            child: _buildLiveSmallCard(
              image: partyImage,
              title: 'Social Mixer Night',
              host: 'Host: Rahul • Social Club',
              spots: '12 spots left',
              price: '₹249',
              location: 'Indore',
              onTap: () => _showMessage('Register for Social Mixer Night'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveSmallCard({
    required String image,
    required String title,
    required String host,
    required String spots,
    required String price,
    required String location,
    required VoidCallback onTap,
  }) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: purple.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.network(
                      image,
                      width: 88,
                      height: 92,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(width: 88, color: Colors.black12),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 5,
                          runSpacing: 4,
                          children: [
                            _smallTag(Icons.location_on, location),
                            _smallTag(Icons.circle, 'LIVE'),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: dark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          host,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF796775),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                spots,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFFD20B4F),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              price,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: dark,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 30,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(25),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: appGradient,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: Text(
                        'Register & Join Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallTag(IconData icon, String text) {
    final isLive = text == 'LIVE';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: isLive ? const Color(0xFFD2F9E9) : const Color(0xFFFFE8F0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 9, color: isLive ? const Color(0xFF087C5C) : pink),
          const SizedBox(width: 3),
          Text(
            text,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: isLive ? const Color(0xFF087C5C) : dark,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- UPCOMING EVENTS ----------------

  Widget _buildUpcomingEvents(
    BuildContext context,
    bool isWide, {
    bool registered = false,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    final cardWidth = isWide ? 300.0 : (width * 0.64).clamp(245.0, 310.0);

    return SizedBox(
      height: 268,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),

        children: [
          SizedBox(
            width: cardWidth,
            child: _buildEventCard(
              image: partyImage,
              title: 'Friday Night Speed Dating',
              date: '25 Sep',
              time: '7:30 PM',
              joined: registered ? '24 joined' : '24 joined',
              price: '₹249',
              available: true,
              onTap: () => _showMessage('Friday Night Speed Dating'),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: cardWidth,
            child: _buildEventCard(
              image: coffeeImage,
              title: 'Coffee & Connections',
              date: '27 Sep',
              time: '6:00 PM',
              joined: '18 joined',
              price: '₹199',
              available: true,
              onTap: () => _showMessage('Coffee & Connections'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard({
    required String image,
    required String title,
    required String date,
    required String time,
    required String joined,
    required String price,
    required bool available,
    required VoidCallback onTap,
  }) {
    return Card(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: purple.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 145,
              width: double.infinity,
              child: Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: const Color(0xFFE9DCEB)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 12, 10, 0),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: dark,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 6, 9, 0),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: pink,
                    size: 15,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      '$date • $time',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF756778),
                      ),
                    ),
                  ),
                  if (available)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7FFF5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Available',
                        style: TextStyle(color: Color(0xFF07865D), fontSize: 9),
                      ),
                    ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 7, 12, 9),
              child: Column(
                children: [
                  const Divider(height: 1, color: Color(0xFFF3EAF5)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F0FA),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.people_alt_outlined,
                                color: purple,
                                size: 13,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  joined,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color(0xFF62536D),
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFD20B4F),
                        ),
                      ),
                      const Spacer(),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: onTap,
                          customBorder: const CircleBorder(),
                          child: Container(
                            width: 29,
                            height: 29,
                            decoration: const BoxDecoration(
                              gradient: appGradient,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              size: 17,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(String message) {

  }
}

class _VerifiedBadge extends StatelessWidget {
  const _VerifiedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE4FBF1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified, size: 12, color: Color(0xFF07865D)),
          SizedBox(width: 4),
          Flexible(
            child: Text(
              'Profile Verified',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0xFF07865D),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
