import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../chatscreen/views/chatscreen_view.dart';
import '../controllers/bottom_controller.dart';
import '../../home/views/home_view.dart';
import '../../events/views/events_view.dart';
import '../../live/views/live_view.dart';
import '../../chat/views/chat_view.dart';
import '../../userprofile/views/userprofile_view.dart';

class BottomView extends GetView<BottomController> {
  const BottomView({super.key});

  static const Color darkPink = Color(0xFFEB4078);
  static const Color selectedPink = Color(0xFFB9134B);
  static const Color purple = Color(0xFF7932E6);
  static const Color unselectedColor = Color(0xFF654F56);

  @override
  Widget build(BuildContext context) {
    Get.put(BottomController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: const [
            HomeView(),
            EventsView(),
            LiveView(),
            ChatscreenView(),
            UserprofileView(),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigation(),
    );
  }

  Widget _bottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: purple.withValues(alpha: 0.12),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 70,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _navItem(Icons.favorite_border, 'Home', 0),
              _navItem(Icons.calendar_today_outlined, 'Events', 1),
              _navItem(Icons.bolt, 'Live', 2),
              _navItem(Icons.chat_bubble_outline, 'Chat', 3),
              _navItem(Icons.account_circle_outlined, 'Profile', 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String title, int index) {
    return Expanded(
      child: Obx(() {
        final bool isSelected = controller.selectedIndex.value == index;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => controller.changeTab(index),
          child: SizedBox(
            height: 70,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Icon and text remain at fixed positions.
                Positioned(
                  top: 15,
                  child: Icon(
                    icon,
                    size: 21,
                    color: isSelected ? selectedPink : unselectedColor,
                  ),
                ),

                Positioned(
                  top: 43,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 11,
                      height: 1,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: isSelected ? selectedPink : unselectedColor,
                    ),
                  ),
                ),

                // Selected circle floats above the navigation bar.
                if (isSelected)
                  Positioned(
                    top: -20,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.4, end: 1.0),
                      duration: const Duration(milliseconds: 650),
                      curve: Curves.easeOutBack,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value.clamp(0.0, 1.0),
                          child: Transform.scale(scale: value, child: child),
                        );
                      },
                      child: Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFB9134B), Color(0xFF9A19A8)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: darkPink.withValues(alpha: 0.30),
                              blurRadius: 16,
                              spreadRadius: 2,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Icon(icon, size: 23, color: Colors.white),
                      ),
                    ),
                  ),

                // Positioned(
                //   top: -20,
                //   child: Container(
                //     height: 56,
                //     width: 56,
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       gradient: const LinearGradient(
                //         begin: Alignment.topLeft,
                //         end: Alignment.bottomRight,
                //         colors: [Color(0xFFB9134B), Color(0xFF9A19A8)],
                //       ),
                //       boxShadow: [
                //         BoxShadow(
                //           color: darkPink.withValues(alpha: 0.30),
                //           blurRadius: 16,
                //           spreadRadius: 2,
                //           offset: const Offset(0, 6),
                //         ),
                //       ],
                //     ),
                //     child: Icon(icon, size: 23, color: Colors.white),
                //   ),
                // ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
