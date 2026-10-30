import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../freeeventbooking/views/freeeventbooking_view.dart';
import '../controllers/events_controller.dart';

const _bg = Color(0xFFFFF8FF),
    _pink = Color(0xFFFF4778),
    _purple = Color(0xFF7837D5),
    _ink = Color(0xFF211D2B),
    _muted = Color(0xFF786B78);

class EventsView extends GetView<EventsController> {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EventsController());
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,

        title: const Row(
          children: [
            Icon(Icons.favorite, color: _pink, size: 22),
            SizedBox(width: 9),
            Text(
              'Events',
              style: TextStyle(
                color: _ink,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: _ink),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: _ink),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 14),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xFFFFD8E5),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xFF82634D),
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Obx(() {
          final upcoming = controller.selectedTab.value == 1;
          final events = upcoming
              ? controller.filteredUpcomingEvents
              : controller.filteredLiveEvents;
          return Column(
            children: [
              _tabs(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            upcoming ? 'Upcoming Event' : 'Live Event',
                            style: const TextStyle(
                              color: _ink,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        _badge(
                          upcoming ? '8 Scheduled' : '3 Active Now',
                          upcoming,
                        ),
                        const SizedBox(width: 8),
                        Material(
                          color: const Color(0xFFF3EAFB),
                          shape: const CircleBorder(),
                          child: IconButton(
                            onPressed: _openFilters,
                            icon: const Icon(Icons.tune, color: _ink),
                          ),
                        ),
                      ],
                    ),
                    if (controller.activeCities.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _chip(
                          '${controller.activeCities.join(', ')}${upcoming && controller.selectedDate.value.isNotEmpty ? ' · ${controller.selectedDate.value}' : ''}',
                          () => controller.activeCities.clear(),
                        ),
                      ),
                    ],
                    const SizedBox(height: 14),
                    if (events.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(35),
                        child: Center(
                          child: Text('No events found. Try changing filters.'),
                        ),
                      )
                    else
                      ...events.asMap().entries.map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: upcoming
                              ? _upcomingCard(entry.value, entry.key)
                              : _liveCard(entry.value, entry.key),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
      // Remove this bottomNavigationBar if your parent BottomView already provides it.
    );
  }

  Widget _tabs() => Container(
    margin: const EdgeInsets.fromLTRB(18, 4, 18, 0),
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: const Color(0xFFF1E8F8),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Obx(
      () => Row(children: [_tab('Live Events', 0), _tab('Upcoming Events', 1)]),
    ),
  );

  Widget _tab(String title, int index) {
    final active = controller.selectedTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          decoration: BoxDecoration(
            gradient: active
                ? const LinearGradient(colors: [_pink, _purple])
                : null,
            borderRadius: BorderRadius.circular(28),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: _pink.withOpacity(.18),
                      blurRadius: 9,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: active ? Colors.white : const Color(0xFF554453),
                fontSize: 13,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _badge(String text, bool upcoming) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    decoration: BoxDecoration(
      color: upcoming ? const Color(0xFFE9DDFF) : const Color(0xFFFFDCE8),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: upcoming ? _purple : _pink,
        fontWeight: FontWeight.w700,
        fontSize: 10,
      ),
    ),
  );

  Widget _liveCard(Map<String, dynamic> e, int i) => Card(
    child: Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _purple.withOpacity(.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _image(e, i, true),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e['title'],
                  style: const TextStyle(
                    fontSize: 17,
                    color: _ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                _detail(
                  Icons.location_on_outlined,
                  '${e['city']} (${e['venue']})',
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _avatars(),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '+${e['joined']} joined',
                        style: const TextStyle(color: _muted, fontSize: 12),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD9D6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${e['spots']} spots left',
                        style: const TextStyle(
                          color: Color(0xFF9F1F2E),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _button2('View Event →', () {}),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _upcomingCard(Map<String, dynamic> e, int i) => Card(
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _purple.withOpacity(.05),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _image(e, i, false),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 10, 4, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e['title'],
                  style: const TextStyle(
                    fontSize: 17,
                    color: _ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 7),
                _detail(Icons.calendar_today_outlined, e['date']),
                const SizedBox(height: 5),
                _detail(
                  Icons.location_on_outlined,
                  '${e['city']} • ${e['venue']}',
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _avatars(),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${e['joined']} / ${e['capacity']} Booked',
                        style: const TextStyle(
                          color: _muted,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    _button('View Event →', () {
                      Get.to(FreeeventbookingView());
                    }, compact: true),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _image(Map<String, dynamic> e, int i, bool live) => LayoutBuilder(
    builder: (context, c) {
      final h = (c.maxWidth * .48).clamp(155.0, 245.0);
      return SizedBox(
        height: h,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              e['image'],
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFFE8D9E8),
                child: const Icon(Icons.event, size: 55, color: _purple),
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x44000000),
                    Colors.transparent,
                    Color(0x99000000),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: live ? _pink : const Color(0xFFD52D61),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  live ? '● LIVE NOW' : e['tag'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Obx(() {
                final fav = controller.favorites.contains(i);
                return Material(
                  color: Colors.white.withOpacity(.92),
                  shape: const CircleBorder(),
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () => controller.toggleFavorite(i),
                    icon: Icon(
                      fav ? Icons.favorite : Icons.favorite_border,
                      color: _pink,
                      size: 21,
                    ),
                  ),
                );
              }),
            ),
            if (live)
              Positioned(
                left: 12,
                bottom: 10,
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      e['time'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            Positioned(
              right: 10,
              bottom: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: live ? _pink : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  e['price'],
                  style: TextStyle(
                    color: live ? Colors.white : _pink,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  Widget _detail(IconData icon, String text) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, size: 15, color: _purple),
      const SizedBox(width: 5),
      Expanded(
        child: Text(
          text,
          style: const TextStyle(color: _muted, fontSize: 12, height: 1.35),
        ),
      ),
    ],
  );

  Widget _avatars() => SizedBox(
    width: 75,
    height: 30,
    child: Stack(
      children: [
        const Positioned(
          left: 0,
          child: CircleAvatar(
            radius: 14,
            backgroundColor: Color(0xFFD6C1AC),
            child: Icon(Icons.person, size: 17, color: Colors.white),
          ),
        ),
        const Positioned(
          left: 22,
          child: CircleAvatar(
            radius: 14,
            backgroundColor: Color(0xFF8A5AE5),
            child: Text(
              'AK',
              style: TextStyle(color: Colors.white, fontSize: 9),
            ),
          ),
        ),
        const Positioned(
          left: 43,
          child: CircleAvatar(
            radius: 14,
            backgroundColor: Color(0xFFFFD6E0),
            child: Icon(Icons.person, size: 16, color: _pink),
          ),
        ),
      ],
    ),
  );
  Widget _button2(String text, VoidCallback onTap, {bool compact = false}) =>
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [_pink, _purple]),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: _pink.withOpacity(.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(28),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: compact ? 16 : 18,
                vertical: compact ? 11 : 13,
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: compact ? 11 : 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      );

  Widget _button(String text, VoidCallback onTap, {bool compact = false}) =>
      Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [_pink, _purple]),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: _pink.withOpacity(.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(28),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: compact ? 16 : 18,
                vertical: compact ? 11 : 13,
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: compact ? 11 : 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      );

  Widget _chip(String text, VoidCallback onRemove) {
    return Container(
      constraints: const BoxConstraints(maxWidth: double.infinity),
      padding: const EdgeInsets.fromLTRB(10, 6, 5, 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFDCE8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.tune, color: Color(0xFFFF4778), size: 13),
          const SizedBox(width: 5),

          Flexible(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFFFF4778),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(width: 3),

          InkWell(
            onTap: onRemove,
            child: const Icon(Icons.close, size: 15, color: Color(0xFFFF4778)),
          ),
        ],
      ),
    );
  }

  void _openFilters() => Get.bottomSheet(
    _EventsFilterSheet(controller: controller),
    isScrollControlled: true,
    backgroundColor: _bg,
    barrierColor: Colors.black54,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
  );

  Widget _nav(IconData icon, String title, bool selected) => SizedBox(
    width: 62,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: selected ? 43 : 30,
          height: selected ? 43 : 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: selected
                ? const LinearGradient(colors: [_pink, _purple])
                : null,
          ),
          child: Icon(
            icon,
            color: selected ? Colors.white : const Color(0xFF634C5B),
            size: 22,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: selected ? _pink : const Color(0xFF634C5B),
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

class _EventsFilterSheet extends StatelessWidget {
  const _EventsFilterSheet({required this.controller});
  final EventsController controller;

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: FractionallySizedBox(
      heightFactor: controller.selectedTab.value == 1 ? .72 : .56,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xFFE8DDED),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 14, 14),
            child: Row(
              children: [
                const Icon(Icons.tune, color: _pink, size: 20),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Filter Events',
                    style: TextStyle(
                      color: _ink,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: Get.back,
                  icon: const Icon(Icons.close, color: _muted),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEFE4F1)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'CITY',
                        style: TextStyle(
                          color: _muted,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Multi-select',
                        style: TextStyle(color: _muted, fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    final selectedCities = controller.activeCities.toSet();

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.cities.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 43,
                          ),
                      itemBuilder: (context, index) {
                        final city = controller.cities[index];
                        final checked = selectedCities.contains(city);

                        return InkWell(
                          onTap: () => controller.toggleCity(city),
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: checked
                                    ? const Color(0xFFFFC2D5)
                                    : const Color(0xFFEDE1F1),
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: checked
                                        ? const Color(0xFFFF4778)
                                        : Colors.white,
                                    border: Border.all(
                                      color: checked
                                          ? const Color(0xFFFF4778)
                                          : const Color(0xFF8B858B),
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: checked
                                      ? const Icon(
                                          Icons.check,
                                          size: 15,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 9),
                                Expanded(
                                  child: Text(
                                    city,
                                    style: const TextStyle(
                                      color: Color(0xFF211D2B),
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                  Obx(() {
                    if (controller.selectedTab.value != 1)
                      return const SizedBox.shrink();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        const Row(
                          children: [
                            Text(
                              'DATE',
                              style: TextStyle(
                                color: _muted,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Single-select',
                              style: TextStyle(color: _muted, fontSize: 11),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 9,
                          children: controller.dates.map((date) {
                            final active =
                                controller.selectedDate.value == date;
                            return InkWell(
                              onTap: () => controller.selectDate(date),
                              borderRadius: BorderRadius.circular(24),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: active
                                      ? _pink
                                      : const Color(0xFFF1E8F8),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Text(
                                  date == 'Custom Date'
                                      ? '▦  Custom Date'
                                      : date,
                                  style: TextStyle(
                                    color: active ? Colors.white : _ink,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEFE4F1)),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: OutlinedButton(
                    onPressed: controller.clearFilters,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFF1E8F8),
                      foregroundColor: _ink,
                      side: BorderSide.none,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text('Clear All'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 7,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [_pink, _purple]),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      onPressed: controller.applyFilters,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: const StadiumBorder(),
                      ),
                      child: const Text('Apply Filters'),
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
