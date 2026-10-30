import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../controllers/complete_your_profile_controller.dart';

class CompleteYourProfileView extends GetView<CompleteYourProfileController> {
  const CompleteYourProfileView({super.key});

  static const Color pink = Color(0xFFFF4778);
  static const Color darkPink = Color(0xFFC20B50);
  static const Color purple = Color(0xFF853DF1);
  static const Color bg = Color(0xFFFFF9FF);
  static const Color textColor = Color(0xFF25202D);
  static const Color subText = Color(0xFF766A7B);

  @override
  Widget build(BuildContext context) {
    Get.put(CompleteYourProfileController());
    return Scaffold(
      backgroundColor: bg,

      appBar: AppBar(
        backgroundColor: bg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textColor),
          onPressed: Get.back,
        ),
        title: const Text(
          'Complete Your Profile',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 18),
        //     child: CircleAvatar(
        //       radius: 17,
        //       backgroundColor: darkPink,
        //       child: const Icon(
        //         Icons.person_outline,
        //         size: 21,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 25, 22, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tell us about yourself',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.7,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Choose what you're looking for to personalize your "
                'speed matching sessions.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.55,
                  color: Color(0xFF66505F),
                ),
              ),
              const SizedBox(height: 16),

              // Profile completion card
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(19),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(19),
                    boxShadow: [
                      BoxShadow(
                        color: purple.withValues(alpha: 0.045),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Profile completion',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                          Obx(
                            () => Text(
                              '${controller.completion.value}%',
                              style: const TextStyle(
                                color: darkPink,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 6,
                            color: const Color(0xFFF0E8F7),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FractionallySizedBox(
                                widthFactor: (controller.completion.value / 100)
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
                      ),
                      const SizedBox(height: 11),
                      const Text(
                        'Almost there! Complete your preferences for higher '
                        'quality matches.',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.65,
                          color: Color(0xFF705967),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // Interested City
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Interested City',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  Text(
                    'Location detected',
                    style: TextStyle(fontSize: 11, color: subText),
                  ),
                ],
              ),
              const SizedBox(height: 7),

              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(17),
                ),
                child: Container(
                  height: 59,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(color: purple, width: 1.1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5EDFF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.location_on_outlined,
                          size: 21,
                          color: purple,
                        ),
                      ),
                      const SizedBox(width: 11),

                      Expanded(
                        child: Obx(
                          () => InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Get.dialog(
                                AlertDialog(
                                  title: const Text('Select Interested Cities'),
                                  content: SizedBox(
                                    width: double.maxFinite,
                                    child: Obx(
                                      () => ListView(
                                        shrinkWrap: true,
                                        children: controller.cities.map((city) {
                                          final selected = controller
                                              .selectedCities
                                              .contains(city);

                                          return CheckboxListTile(
                                            value: selected,
                                            title: Text(
                                              city,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: textColor,
                                              ),
                                            ),
                                            activeColor: purple,
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            onChanged: (_) {
                                              controller.selectCity(city);
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: Get.back,
                                      child: const Text('Done'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.selectedCities.join(', '),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xFF766A7B),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 9),

              // Quick city selection chips
              Obx(
                () => Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: controller.cities.map((city) {
                    final selected = controller.selectedCities.contains(city);

                    return GestureDetector(
                      onTap: () => controller.selectCity(city),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFF853DF1)
                              : const Color(0xFFEFEAF3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (selected) ...[
                              const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 13,
                              ),
                              const SizedBox(width: 4),
                            ],
                            Text(
                              city,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: selected
                                    ? Colors.white
                                    : const Color(0xFF25202D),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 33),

              // Interests heading
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    child: Text(
                      'What are you interested in?',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Multi-select',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: subText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Dating and Networking cards
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => _interestCard(
                        title: 'Dating',
                        subtitle: 'Romance',
                        icon: Icons.favorite,
                        color: darkPink,
                        selected: controller.selectedInterests.contains(
                          'Dating',
                        ),
                        onTap: () => controller.toggleInterest('Dating'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Obx(
                      () => _interestCard(
                        title: 'Networking',
                        subtitle: 'Founders & pros',
                        icon: Icons.work,
                        color: purple,
                        selected: controller.selectedInterests.contains(
                          'Networking',
                        ),
                        onTap: () => controller.toggleInterest('Networking'),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 7),

              // Marriage card
              Obx(
                () => _marriageCard(
                  selected: controller.selectedInterests.contains('Marriage'),
                  onTap: () => controller.toggleInterest('Marriage'),
                ),
              ),

              const SizedBox(height: 15),

              // Networking focus section
              // Networking focus section
              // Networking focus section
              Obx(() {
                final showNetworking =
                controller.selectedInterests.contains('Networking');

                return AnimatedSize(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOutCubic,
                  alignment: Alignment.topCenter,
                  child: showNetworking
                      ? Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      opacity: 1,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFE9DDF8),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF853DF1)
                                  .withValues(alpha: 0.08),
                              blurRadius: 20,
                              spreadRadius: 1,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: _networkingSection(),
                      ),
                    ),
                  )
                      : const SizedBox(
                    width: double.infinity,
                    height: 0,
                  ),
                );
              }),

              const SizedBox(height: 30),

              // Save button
              SizedBox(
                width: double.infinity,
                height: 46,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [pink, Color(0xFF8B4BEF)],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: pink.withValues(alpha: 0.20),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: controller.saveAndContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Save & Continue',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 7),
                        Icon(Icons.arrow_forward, size: 19),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom navigation bar
    );
  }

  Widget _interestCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 69,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? color : const Color(0xFFB7B4B8),
            width: selected ? 2 : 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 37,
              width: 37,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: subText),
                  ),
                ],
              ),
            ),
            if (selected)
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: const Icon(Icons.check, color: Colors.white, size: 14),
              ),
          ],
        ),
      ),
    );
  }

  Widget _marriageCard({required bool selected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: selected ? const Color(0xFFB7B4B8) : const Color(0xFFB7B4B8),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: const BoxDecoration(
                color: Color(0xFFF044B5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border,
                color: Colors.white,
                size: 25,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Marriage',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE5F0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'NEW',
                          style: TextStyle(
                            color: darkPink,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Looking for marriage & lifelong commitment',
                    style: TextStyle(
                      color: subText,
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 7),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFFE344E9)
                    : const Color(0xFFEDE6F1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                selected ? Icons.check : Icons.add,
                size: 15,
                color: selected ? Colors.white : subText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _networkingSection() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(19),
      ),
      child: Container(
        // width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(19),
          // boxShadow: [
          //   BoxShadow(
          //     color: purple.withValues(alpha: 0.00),
          //     blurRadius: 19,
          //     offset: const Offset(0, 0),
          //   ),
          // ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Networking Focus',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                Text(
                  'Select your fields',
                  style: TextStyle(fontSize: 11, color: subText),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // API response data[].name is shown here.
            SizedBox(
              height: 220,
              child: PagingListener<int, Map<String, dynamic>>(
                controller: controller.professionPagingController,
                builder: (context, state, fetchNextPage) {
                  return PagedListView<int, Map<String, dynamic>>(
                    state: state,
                    fetchNextPage: fetchNextPage,
                    padding: EdgeInsets.zero,
                    builderDelegate:
                        PagedChildBuilderDelegate<Map<String, dynamic>>(
                          itemBuilder: (context, category, index) {
                            final String field =
                                category['name']?.toString() ?? '';

                            if (field.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            return Obx(() {
                              final bool selected = controller.selectedFocus
                                  .contains(field);

                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: GestureDetector(
                                    onTap: () => controller.toggleFocus(field),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 160,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 11,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: selected
                                            ? purple
                                            : const Color(0xFFF2EAFB),
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.work_outline,
                                            size: 13,
                                            color: selected
                                                ? Colors.white
                                                : const Color(0xFF69546F),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            field,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: selected
                                                  ? Colors.white
                                                  : textColor,
                                            ),
                                          ),
                                          if (selected) ...[
                                            const SizedBox(width: 5),
                                            const Icon(
                                              Icons.check,
                                              size: 13,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                          firstPageProgressIndicatorBuilder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                          newPageProgressIndicatorBuilder: (context) =>
                              const Padding(
                                padding: EdgeInsets.all(12),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                          noItemsFoundIndicatorBuilder: (context) =>
                              const Center(
                                child: Text(
                                  'No networking categories available.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: subText,
                                  ),
                                ),
                              ),
                          firstPageErrorIndicatorBuilder: (context) => Center(
                            child: TextButton(
                              onPressed: () => controller
                                  .professionPagingController
                                  .refresh(),
                              child: const Text('Retry loading categories'),
                            ),
                          ),
                          newPageErrorIndicatorBuilder: (context) => Center(
                            child: TextButton(
                              onPressed: () => controller
                                  .professionPagingController
                                  .fetchNextPage(),
                              child: const Text('Retry loading more'),
                            ),
                          ),
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Widget _networkingSection() {
  //   final fields = [
  //     'Software & Tech',
  //     'Marketing & Growth',
  //     'Finance & VC',
  //     'Design & Creative',
  //     'Product / SaaS',
  //   ];
  //
  //   final icons = [
  //     Icons.code,
  //     Icons.trending_up,
  //     Icons.payments_outlined,
  //     Icons.palette_outlined,
  //     Icons.rocket_launch_outlined,
  //   ];
  //
  //   return Container(
  //     width: double.infinity,
  //     padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(19),
  //       boxShadow: [
  //         BoxShadow(
  //           color: purple.withValues(alpha: 0.04),
  //           blurRadius: 12,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             const Text(
  //               'Networking Focus',
  //               style: TextStyle(
  //                 fontSize: 15,
  //                 fontWeight: FontWeight.w700,
  //                 color: textColor,
  //               ),
  //             ),
  //             Text(
  //               'Select your fields',
  //               style: TextStyle(fontSize: 11, color: subText),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 12),
  //         Wrap(
  //           spacing: 8,
  //           runSpacing: 8,
  //           children: List.generate(fields.length, (index) {
  //             final field = fields[index];
  //
  //             return Obx(() {
  //               final selected = controller.selectedFocus.contains(field);
  //
  //               return GestureDetector(
  //                 onTap: () => controller.toggleFocus(field),
  //                 child: AnimatedContainer(
  //                   duration: const Duration(milliseconds: 160),
  //                   padding: const EdgeInsets.symmetric(
  //                     horizontal: 11,
  //                     vertical: 7,
  //                   ),
  //                   decoration: BoxDecoration(
  //                     color: selected ? purple : const Color(0xFFF2EAFB),
  //                     borderRadius: BorderRadius.circular(22),
  //                   ),
  //                   child: Row(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Icon(
  //                         icons[index],
  //                         size: 13,
  //                         color: selected
  //                             ? Colors.white
  //                             : const Color(0xFF69546F),
  //                       ),
  //                       const SizedBox(width: 5),
  //                       Text(
  //                         field,
  //                         style: TextStyle(
  //                           fontSize: 11,
  //                           fontWeight: FontWeight.w600,
  //                           color: selected ? Colors.white : textColor,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             });
  //           }),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _bottomNavigation() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: purple.withValues(alpha: 0.07),
  //           blurRadius: 15,
  //           offset: const Offset(0, -4),
  //         ),
  //       ],
  //     ),
  //     child: SafeArea(
  //       top: false,
  //       child: SizedBox(
  //         height: 65,
  //         child: Row(
  //           children: [
  //             _navItem(Icons.favorite_border, 'Home', 0),
  //             _navItem(Icons.calendar_today_outlined, 'Events', 1),
  //             _navItem(Icons.bolt, 'Live', 2),
  //             _navItem(Icons.chat_bubble_outline, 'Chat', 3),
  //             Expanded(
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Container(
  //                     height: 39,
  //                     width: 39,
  //                     decoration: const BoxDecoration(
  //                       gradient: LinearGradient(
  //                         colors: [darkPink, Color(0xFF9A19A8)],
  //                       ),
  //                       shape: BoxShape.circle,
  //                     ),
  //                     child: const Icon(
  //                       Icons.account_circle_outlined,
  //                       color: Colors.white,
  //                       size: 23,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 2),
  //                   const Text(
  //                     'Profile',
  //                     style: TextStyle(
  //                       fontSize: 11,
  //                       fontWeight: FontWeight.w600,
  //                       color: darkPink,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _navItem(IconData icon, String title, int index) {
    return Expanded(
      child: InkWell(
        onTap: () => controller.onNavigationTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: const Color(0xFF715A67)),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF715A67),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
