import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  static const Color pink = Color(0xFFFF4779);
  static const Color purple = Color(0xFF8528EE);
  static const Color dark = Color(0xFF25212B);
  static const Color bg = Color(0xFFFFF8FF);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back, color: dark),
        ),
        title: const Text(
          'Complete Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: dark,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 17,
              backgroundColor: const Color(0xFFC20D4C),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 20,
                ),
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
                padding: const EdgeInsets.fromLTRB(19, 18, 19, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Let's set up your profile",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.6,
                        color: dark,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Help others get to know you before your first speed date.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: Color(0xFF665966),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Profile photo card
                    GestureDetector(
                      onTap: controller.pickImage,
                      child: Container(
                        height: 156,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17),
                          boxShadow: [
                            BoxShadow(
                              color: purple.withOpacity(0.04),
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 112,
                                height: 112,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8EFFF),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFFF5E9FC),
                                  ),
                                ),
                                child: Obx(
                                  () => controller.imagePath.value.isEmpty
                                      ? const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.camera_alt_outlined,
                                              size: 32,
                                              color: Color(0xFFC20D4C),
                                            ),
                                            SizedBox(height: 3),
                                            Text(
                                              'Add Photo',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFFC20D4C),
                                              ),
                                            ),
                                          ],
                                        )
                                      : ClipOval(
                                          child: Image.file(
                                            controller.selectedImage!,
                                            fit: BoxFit.cover,
                                            width: 112,
                                            height: 112,
                                          ),
                                        ),
                                ),
                              ),
                              Positioned(
                                right: -5,
                                bottom: 4,
                                child: Container(
                                  width: 34,
                                  height: 34,
                                  decoration: const BoxDecoration(
                                    color: pink,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        'ABOUT YOU',
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 0.4,
                          color: Color(0xFF906D7C),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Full name
                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _label('Full Name'),
                          const SizedBox(height: 4),
                          _outlinedField(
                            child: TextField(
                              controller: controller.nameController,
                              textCapitalization: TextCapitalization.words,
                              decoration: _inputDecoration(
                                hint: 'Enter your full name',
                                icon: Icons.person_outline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Date of birth
                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              _label('Date of Birth'),
                              const Spacer(),
                              const Flexible(
                                child: Text(
                                  'Must be 18+ to join',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: purple,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Obx(
                            () => _outlinedField(
                              child: InkWell(
                                onTap: () => controller.selectDate(context),
                                child: InputDecorator(
                                  decoration: _inputDecoration(
                                    hint: 'DD / MM / YYYY',
                                    icon: Icons.card_membership_outlined,
                                    suffix: const Icon(
                                      Icons.calendar_month_outlined,
                                      color: Color(0xFF906D7C),
                                      size: 19,
                                    ),
                                  ),
                                  child: Text(
                                    controller.dob.value.isEmpty
                                        ? 'DD / MM / YYYY'
                                        : controller.dob.value,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: controller.dob.value.isEmpty
                                          ? const Color(0xFF967D88)
                                          : dark,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Gender dropdown
                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _label('Gender'),
                          const SizedBox(height: 4),
                          Obx(
                            () => _outlinedField(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: controller.gender.value.isEmpty
                                      ? null
                                      : controller.gender.value,
                                  isExpanded: true,
                                  hint: const Text(
                                    'Select Gender',
                                    style: TextStyle(
                                      color: Color(0xFF967D88),
                                      fontSize: 14,
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Color(0xFF906D7C),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'Male',
                                      child: Text('Male'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Female',
                                      child: Text('Female'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Other',
                                      child: Text('Other'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.gender.value = value;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // City selection
                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _label('Your City'),
                          const SizedBox(height: 7),
                          Obx(
                            () => _outlinedField(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: controller.city.value.isEmpty
                                      ? null
                                      : controller.city.value,
                                  isExpanded: true,
                                  hint: const Text(
                                    'Select or type your city',
                                    style: TextStyle(
                                      color: Color(0xFF967D88),
                                      fontSize: 14,
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Color(0xFF906D7C),
                                  ),
                                  items: controller.cities
                                      .map(
                                        (city) => DropdownMenuItem(
                                          value: city,
                                          child: Text(city),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.city.value = value;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Popular speed-dating hubs:',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF66515D),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Obx(
                            () => Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: controller.cities.map((city) {
                                final selected = controller.city.value == city;

                                return GestureDetector(
                                  onTap: () => controller.city.value = city,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 13,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: selected
                                          ? const Color(0xFFFFDDEB)
                                          : const Color(0xFFF8F0FC),
                                      borderRadius: BorderRadius.circular(22),
                                      border: selected
                                          ? Border.all(color: pink)
                                          : null,
                                    ),
                                    child: Text(
                                      city,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: dark,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(19, 12, 19, 20),
                      child: Container(
                        width: double.infinity,
                        height: 49,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFC20D4C),
                              pink,
                              Color(0xFF7134D7),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                              color: pink.withOpacity(0.24),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: controller.continueProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: const StadiumBorder(),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Continue',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 20,
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

            // Continue button
          ],
        ),
      ),
    );
  }


  static Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: purple.withOpacity(0.035),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }


  static Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        color: Color(0xFF604650),
        fontWeight: FontWeight.w600,
      ),
    );
  }


  static Widget _outlinedField({required Widget child}) {
    return Container(
      height: 45,
      padding: const EdgeInsets.all(1.2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFFF4779), // Pink
            Color(0xFF8528EE), // Purple
          ],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26.8),
        ),
        child: child,
      ),
    );
  }


  static InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF967D88), fontSize: 14),
      prefixIcon: Icon(icon, size: 18, color: const Color(0xFF906D7C)),
      suffixIcon: suffix,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(vertical: 11),
      isDense: true,
    );
  }

  static Widget _navItem(IconData icon, String label, bool selected) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: 58,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 21,
              color: selected
                  ? const Color(0xFFC20D4C)
                  : const Color(0xFF694C58),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: selected
                    ? const Color(0xFFC20D4C)
                    : const Color(0xFF694C58),
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
