import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../editprofile/views/editprofile_view.dart';
import '../../likesaveevent/views/likesaveevent_view.dart';
import '../../savedconnection/views/savedconnection_view.dart';
import '../controllers/userprofile_controller.dart';

const Color profileBg = Color(0xFFFFF8FF);
const Color profilePink = Color(0xFFFF4778);
const Color profilePurple = Color(0xFF7837D5);
const Color profileText = Color(0xFF211D2B);
const Color profileMuted = Color(0xFF705D68);

class UserprofileView extends GetView<UserprofileController> {
  const UserprofileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserprofileController());
    return Scaffold(
      backgroundColor: profileBg,
      appBar: AppBar(
        backgroundColor: profileBg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          'Profile',
          style: TextStyle(
            color: profileText,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _editProfile,
            icon: const Icon(Icons.edit, color: profileText),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 14),
            child: CircleAvatar(
              radius: 17,
              backgroundColor: profilePurple,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xFFE8D6CA),
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth < 360 ? 14.0 : 20.0;

            return ListView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                10,
                horizontalPadding,
                24,
              ),
              children: [
                _profileHeader(),
                const SizedBox(height: 20),
                _aboutCard(),
                const SizedBox(height: 20),
                _interestedCard(),
                const SizedBox(height: 20),
                _professionalCard(),
                const SizedBox(height: 20),
                _interestsCard(),
                const SizedBox(height: 16),
                _activityCard(),
                const SizedBox(height: 16),
                _settingsCard(),
                const SizedBox(height: 70),
              ],
            );
          },
        ),
      ),
    );
  }

  // Main profile card
  Widget _profileHeader() {
    return Card(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: profilePurple.withOpacity(0.04),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [profilePink, profilePurple],
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 45,
                    backgroundColor: Color(0xFFF0E3DC),
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300',
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: Color(0xFF10B981),
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Raj Kumar, 27',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: profileText,
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 3),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on_outlined, color: profilePink, size: 16),
                SizedBox(width: 3),
                Text(
                  'Indore, India',
                  style: TextStyle(color: profileMuted, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFF2E9FC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified, color: Color(0xFF10A875), size: 14),
                  SizedBox(width: 5),
                  Text(
                    'Profile Verified',
                    style: TextStyle(
                      color: profileText,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: const Color(0xFFF7F0FF),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Profile Completion',
                          style: TextStyle(
                            color: profileMuted,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '90%',
                        style: TextStyle(
                          color: Color(0xFFD41455),
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          colors: [
                            Color(0xFFB9134B), // Dark Pink
                            Color(0xFFF35C7B), // Light Pink
                            Color(0xFF6B38D4), // Purple
                          ],
                          stops: [0.0, 0.5, 1.0],
                        ).createShader(bounds);
                      },
                      child: const LinearProgressIndicator(
                        value: 0.9,
                        minHeight: 8,
                        backgroundColor: Color(0xFFE6DDEC),
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Complete preferences for higher quality speed matches.',
                    style: TextStyle(
                      color: profileMuted,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 9),
            _softButton(
              icon: Icons.edit,
              label: 'Edit Profile',
              onTap: _editProfile,
            ),
          ],
        ),
      ),
    );
  }

  Widget _aboutCard() {
    return Card(
      child: _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(child: _heading('About')),
                Icon(
                  Icons.format_quote,
                  color: profilePink.withOpacity(0.45),
                  size: 19,
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              'Love meeting new people, exploring new places and having meaningful conversations.',
              style: TextStyle(color: profileMuted, fontSize: 14, height: 1.55),
            ),
          ],
        ),
      ),
    );
  }

  Widget _interestedCard() {
    return Card(
      child: _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _heading('Interested In'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _tag(
                  '♥  Dating',
                  const Color(0xFFFFF0F3),
                  const Color(0xFFC21850),
                ),
                _tag('♧  Networking', const Color(0xFFF5EEFF), profilePurple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _professionalCard() {
    return Card(
      child: _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _heading('Professional Interests'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _tag('IT & Technology', const Color(0xFFF2E9FC), profileText),
                _tag(
                  'Software Development',
                  const Color(0xFFF2E9FC),
                  profileText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _interestsCard() {
    return Card(
      child: _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _heading('Interests'),
            const SizedBox(height: 9),
            Wrap(
              spacing: 7,
              runSpacing: 8,
              children: [
                _tag('✈️ Travel', const Color(0xFFF2E9FC), profileText),
                _tag('♫ Music', const Color(0xFFF2E9FC), profileText),
                _tag('☕ Coffee', const Color(0xFFF2E9FC), profileText),
                _tag('🎬 Movies', const Color(0xFFF2E9FC), profileText),
                _tag('🏃 Fitness', const Color(0xFFF2E9FC), profileText),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _activityCard() {
    return Card(
      child: _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _heading('Event Activity'),
            const SizedBox(height: 12),
            _activityRow(
              icon: Icons.confirmation_num_outlined,
              title: 'Events Joined',
              count: '4',
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1, color: Color(0xFFF0E6F4)),
            ),
            _activityRow(
              icon: Icons.people_outline,
              title: 'Mutual Matches',
              count: '5',
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1, color: Color(0xFFF0E6F4)),
            ),
            InkWell(
              onTap: () {
                Get.to(LikesaveeventView());
              },
              child: _activityRow(
                icon: Icons.favorite,
                title: 'Like and save event',
                count: '5',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _activityRow({
    required IconData icon,
    required String title,
    required String count,
  }) {
    return Row(
      children: [
        Container(
          width: 33,
          height: 33,
          decoration: const BoxDecoration(
            color: Color(0xFFF3E9FF),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18, color: profilePurple),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(color: profileMuted, fontSize: 13),
          ),
        ),
        Text(
          count,
          style: const TextStyle(
            color: profileText,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _settingsCard() {
    return Card(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _settingRow(
              Icons.manage_accounts_outlined,
              'Edit Profile',
              onTap: _editProfile,
            ),
            const Divider(height: 1, color: Color(0xFFF0E6F4)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
              child: Row(
                children: [
                  const Icon(
                    Icons.verified_user_outlined,
                    color: profileMuted,
                    size: 20,
                  ),
                  const SizedBox(width: 11),
                  const Expanded(
                    child: Text(
                      'Verification Status',
                      style: TextStyle(
                        color: profileText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8FBF2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check, color: Color(0xFF009B69), size: 14),
                        SizedBox(width: 3),
                        Text(
                          'Verified',
                          style: TextStyle(
                            color: Color(0xFF009B69),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFF0E6F4)),
            _settingRow(
              Icons.shield_outlined,
              'Privacy & Safety',
              onTap: () {
                Get.snackbar(
                  'Privacy & Safety',
                  'Connect your privacy settings here.',
                );
              },
            ),
            const Divider(height: 1, color: Color(0xFFF0E6F4)),
            _settingRow(
              Icons.save,
              'Saved Connections',
              onTap: () {
                Get.to(SavedconnectionView());
              },
            ),
            const Divider(height: 1, color: Color(0xFFF0E6F4)),
            _settingRow(
              Icons.logout,
              'Logout',
              onTap: () {
                Get.dialog(
                  AlertDialog(
                    backgroundColor: Colors.white,
                    elevation: 8,
                    insetPadding: const EdgeInsets.symmetric(horizontal: 28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(22, 26, 22, 22),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Tween scale + fade animation
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0.5, end: 1.0),
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOutBack,
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value.clamp(0.0, 1.0),
                              child: Transform.scale(
                                scale: value,
                                child: child,
                              ),
                            );
                          },
                          child: Container(
                            height: 62,
                            width: 62,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFF4F7B),
                                  Color(0xFFB9134B),
                                  Color(0xFF8455EF),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: const Icon(
                              Icons.logout_rounded,
                              color: Colors.white,
                              size: 29,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'Confirm Logout',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF25202D),
                          ),
                        ),

                        const SizedBox(height: 9),

                        const Text(
                          'Are you sure you want to logout from your account?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Color(0xFF766A7B),
                          ),
                        ),

                        const SizedBox(height: 24),

                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 46,
                                child: OutlinedButton(
                                  onPressed: () => Get.back(),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFF766A7B),
                                    side: const BorderSide(
                                      color: Color(0xFFE9E1EF),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: SizedBox(
                                height: 46,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFB9134B),
                                        Color(0xFF8455EF),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                      controller.logout();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.white,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Logout',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  barrierDismissible: false,
                  transitionDuration: const Duration(milliseconds: 300),
                  transitionCurve: Curves.easeOutCubic,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingRow(
    IconData icon,
    String title, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: profileMuted, size: 21),
            const SizedBox(width: 11),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: profileText,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFFE9B9C8)),
          ],
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: profilePurple.withOpacity(0.025), blurRadius: 12),
        ],
      ),
      child: child,
    );
  }

  Widget _tag(String text, Color background, Color foreground) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: foreground,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _softButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: const Color(0xFFF2E9FC),
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: profileText),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: profileText,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editProfile() {
    Get.to(EditprofileView());
  }

  Widget _navItem(IconData icon, String label, bool selected) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (!selected) {
            Get.snackbar(
              label,
              'Connect this tab to your navigation routes.',
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: selected ? 43 : 30,
              height: selected ? 43 : 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: selected
                    ? const LinearGradient(colors: [profilePink, profilePurple])
                    : null,
              ),
              child: Icon(
                icon,
                size: 22,
                color: selected ? Colors.white : const Color(0xFF634C5B),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: selected ? profilePink : const Color(0xFF634C5B),
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _heading extends StatelessWidget {
  const _heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: profileText,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
