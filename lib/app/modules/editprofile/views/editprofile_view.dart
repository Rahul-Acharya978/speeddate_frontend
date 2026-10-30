import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/editprofile_controller.dart';

class EditprofileView extends GetView<EditprofileController> {
  const EditprofileView({super.key});

  static const Color pink = Color(0xFFFF4F7B);
  static const Color darkPink = Color(0xFFB9134B);
  static const Color purple = Color(0xFF6B38D4);
  static const Color lightPurple = Color(0xFFF7F0FC);
  static const Color textColor = Color(0xFF28232E);
  static const Color muted = Color(0xFF947779);

  @override
  Widget build(BuildContext context) {
    Get.put(EditprofileController());
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFFF8FF),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back, color: textColor),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: darkPink,
              child: const Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _photoCard(),
                    const SizedBox(height: 24),
                    _profileStrength(),
                    const SizedBox(height: 24),
                    _sectionTitle('About You', trailing: _publicBadge()),
                    const SizedBox(height: 14),
                    _nameField(),
                    const SizedBox(height: 16),
                    _dateField(context),
                    const SizedBox(height: 16),
                    _genderCard(),
                    const SizedBox(height: 16),
                    _cityField(),
                    const SizedBox(height: 26),
                    _sectionTitle(
                      'Looking For',
                      trailing: const Text(
                        'Multiple choice',
                        style: TextStyle(
                          fontSize: 11,
                          color: muted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _lookingForOptions(),
                    const SizedBox(height: 28),
                    _interestsCard(),
                    const SizedBox(height: 10),
                    _bottomActions(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _photoCard() {
    return Card(
      child: Container(
        width: double.infinity,
        height: 195,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.center,
            colors: [Color(0xFFF5DCEB), Colors.white, Colors.white],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Obx(
              () => Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [purple, pink, darkPink]),
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: lightPurple,
                  backgroundImage: controller.profileImage.value != null
                      ? FileImage(controller.profileImage.value!)
                      : null,
                  child: controller.profileImage.value == null
                      ? const Icon(Icons.person, size: 52, color: muted)
                      : null,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(29, -29),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.pink, Color(0xFFB9134B)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 17,
                      color: Colors.white,
                    ),
                    onPressed: controller.pickProfileImage,
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -21),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: controller.pickProfileImage,
                    icon: const Icon(
                      Icons.add_a_photo_outlined,
                      size: 15,
                      color: darkPink,
                    ),
                    label: const Text('Change Photo'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: textColor,
                      backgroundColor: lightPurple,
                      side: BorderSide.none,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 7,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: controller.removeProfileImage,
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFF7F5F5),
                      foregroundColor: muted,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Remove',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileStrength() {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: lightPurple,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.local_fire_department,
                  size: 17,
                  color: darkPink,
                ),
                const SizedBox(width: 5),
                const Expanded(
                  child: Text(
                    'Profile Strength',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    '${controller.profileCompletion.value}% Completed',
                    style: const TextStyle(
                      fontSize: 14,
                      color: darkPink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 6,
                width: double.infinity,
                child: Stack(
                  children: [
                    // Remaining progress: White
                    Container(color: Colors.white),
      
                    // Filled progress: Three-color gradient
                    Obx(
                      () => FractionallySizedBox(
                        widthFactor: (controller.profileCompletion.value / 100)
                            .clamp(0.0, 1.0),
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFB9134B),
                                Color(0xFFFF4F7B),
                                Color(0xFF6B38D4),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Add your bio and complete interests to unlock '
              'premium speed-dating pods.',
              style: TextStyle(
                fontSize: 12,
                height: 1.4,
                color: Color(0xFF6F555D),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, {Widget? trailing}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _publicBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF0E5FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(Icons.verified_user, size: 12, color: purple),
          SizedBox(width: 4),
          Text(
            'Public Info',
            style: TextStyle(
              color: purple,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: muted,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _nameField() {
    return Card(
      child: _fieldCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _fieldLabel('Full Name'),
            Container(
              height: 48,
              color: lightPurple,
              child: TextField(
                controller: controller.nameController,
                onChanged: (_) => controller.updateCompletion(),
                style: const TextStyle(fontSize: 15, color: textColor),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: controller.clearName,
                    icon: const Icon(
                      Icons.cancel_outlined,
                      size: 17,
                      color: muted,
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

  Widget _dateField(BuildContext context) {
    return Card(
      child: _fieldCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _fieldLabel('Date of Birth'),
            Obx(
              () => InkWell(
                onTap: () => controller.selectDateOfBirth(context),
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  color: lightPurple,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller.dateOfBirth.value,
                          style: const TextStyle(color: textColor, fontSize: 15),
                        ),
                      ),
                      const Icon(
                        Icons.calendar_month_outlined,
                        size: 20,
                        color: muted,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _genderCard() {
    return Card(
      child: _fieldCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _fieldLabel('Gender'),
            Obx(
              () => Row(
                children: [
                  _genderButton('Man', '♂', darkPink),
                  const SizedBox(width: 7),
                  _genderButton('Woman', '♀', purple),
                  const SizedBox(width: 7),
                  _genderButton('Other', '⚧', purple),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _genderButton(String value, String symbol, Color selectedColor) {
    final selected = controller.gender.value == value;

    return Expanded(
      child: InkWell(
        onTap: () {
          controller.gender.value = value;
          controller.updateCompletion();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 37,
          decoration: BoxDecoration(
            color: selected ? selectedColor : lightPurple,
            gradient: selected
                ? const LinearGradient(colors: [pink, darkPink])
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                symbol,
                style: TextStyle(
                  color: selected ? Colors.white : const Color(0xFF755B65),
                  fontSize: 17,
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: selected ? Colors.white : const Color(0xFF634A52),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cityField() {
    return Card(
      child: _fieldCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _fieldLabel('Current City'),
            Container(
              height: 49,
              padding: const EdgeInsets.symmetric(horizontal: 13),
              color: lightPurple,
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: darkPink,
                    size: 20,
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: TextField(
                      controller: controller.cityController,
                      onChanged: (_) => controller.updateCompletion(),
                      style: const TextStyle(fontSize: 15, color: textColor),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your city',
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lookingForOptions() {
    final options = [
      ('Dating', Icons.favorite, 'Casual & Fun'),
      ('Networking', Icons.hub_outlined, 'Social Circle'),
      ('Marriage', Icons.diamond_outlined, 'Serious Only'),
    ];

    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: options.map((item) {
          final selected = controller.lookingFor.contains(item.$1);

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 7),
              child: InkWell(
                onTap: () => controller.toggleLookingFor(item.$1),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 82,
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: selected ? pink : Colors.white,
                    gradient: selected
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [pink, darkPink],
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item.$2,
                        color: selected ? Colors.white : muted,
                        size: 22,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item.$1,
                        style: TextStyle(
                          color: selected ? Colors.white : textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item.$3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selected ? Colors.white : muted,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Widget _interestsCard() {
  //   final interests = [
  //     'Software & Tech',
  //     'Startups & VC',
  //     'Product / SaaS',
  //     'Marketing & Growth',
  //     'Design & Creative',
  //     'Finance & Investing',
  //     'AI & Data Science',
  //   ];
  //
  //   return Container(
  //     width: double.infinity,
  //     padding: const EdgeInsets.fromLTRB(16, 18, 16, 17),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       border: Border.all(color: const Color(0xFFF2E4EC)),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             const Icon(Icons.hub_outlined, color: purple, size: 22),
  //             const SizedBox(width: 8),
  //             const Expanded(
  //               child: Text(
  //                 'Professional Interests & Focus',
  //                 style: TextStyle(
  //                   color: textColor,
  //                   fontWeight: FontWeight.w600,
  //                   fontSize: 15,
  //                 ),
  //               ),
  //             ),
  //             Obx(
  //               () => Text(
  //                 '${controller.selectedInterests.length} Selected',
  //                 style: const TextStyle(
  //                   color: purple,
  //                   fontSize: 11,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 35),
  //         const Text(
  //           'Select your fields to connect with like-minded '
  //           'professionals in speed networking.',
  //           style: TextStyle(
  //             color: Color(0xFF6F555D),
  //             height: 1.4,
  //             fontSize: 12,
  //           ),
  //         ),
  //         const SizedBox(height: 16),
  //         Obx(
  //           () => Wrap(
  //             spacing: 10,
  //             runSpacing: 9,
  //             children: interests.map((interest) {
  //               final selected = controller.selectedInterests.contains(
  //                 interest,
  //               );
  //
  //               return InkWell(
  //                 borderRadius: BorderRadius.circular(20),
  //                 onTap: () => controller.toggleInterest(interest),
  //                 child: AnimatedContainer(
  //                   duration: const Duration(milliseconds: 150),
  //                   padding: const EdgeInsets.symmetric(
  //                     horizontal: 13,
  //                     vertical: 7,
  //                   ),
  //                   decoration: BoxDecoration(
  //                     color: selected
  //                         ? const Color(0xFFEBDDFF)
  //                         : const Color(0xFFFAF1FA),
  //                     border: Border.all(
  //                       color: selected
  //                           ? const Color(0xFFEBDDFF)
  //                           : const Color(0xFFF1DDEE),
  //                     ),
  //                     borderRadius: BorderRadius.circular(20),
  //                   ),
  //                   child: Row(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Text(
  //                         interest,
  //                         style: TextStyle(
  //                           fontSize: 11,
  //                           color: selected
  //                               ? const Color(0xFF6021D0)
  //                               : const Color(0xFF674F58),
  //                         ),
  //                       ),
  //                       const SizedBox(width: 4),
  //                       Icon(
  //                         selected ? Icons.check : Icons.add,
  //                         size: 13,
  //                         color: selected ? purple : muted,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _interestsCard() {
    final interests = [
      'Software & Tech',
      'Startups & VC',
      'Product / SaaS',
      'Marketing & Growth',
      'Design & Creative',
      'Finance & Investing',
      'AI & Data Science',
    ];

    return Container(
      width: double.infinity,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 17),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFF2E4EC),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.hub_outlined,
                color: purple,
                size: 22,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Professional Interests & Focus',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
              Obx(
                    () => Text(
                  '${controller.selectedInterests.length} Selected',
                  style: const TextStyle(
                    color: purple,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Select your fields to connect with like-minded '
                'professionals in speed networking.',
            style: TextStyle(
              color: Color(0xFF6F555D),
              height: 1.4,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          Obx(
                () => Wrap(
              spacing: 10,
              runSpacing: 9,
              children: interests.map((interest) {
                final selected = controller.selectedInterests
                    .contains(interest);

                return InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () =>
                      controller.toggleInterest(interest),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFFEBDDFF)
                          : const Color(0xFFFAF1FA),
                      border: Border.all(
                        color: selected
                            ? const Color(0xFFEBDDFF)
                            : const Color(0xFFF1DDEE),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          interest,
                          style: TextStyle(
                            fontSize: 11,
                            color: selected
                                ? const Color(0xFF6021D0)
                                : const Color(0xFF674F58),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          selected ? Icons.check : Icons.add,
                          size: 13,
                          color: selected ? purple : muted,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomActions() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8FF),
        boxShadow: [
          BoxShadow(
            color: purple.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 52,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFB9134B), Color(0xFFFF4F7B), purple],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: pink.withValues(alpha: 0.22),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: controller.saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: Get.back,
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: muted,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
