import 'package:get/get.dart';

class EventsController extends GetxController {
  //TODO: Implement EventsController

  final count = 0.obs;
  final selectedTab = 0.obs; // 0 = Live, 1 = Upcoming

  final activeCities = <String>{'Indore'}.obs;
  final selectedDate = 'Today'.obs;
  final favorites = <int>{}.obs;

  final cities = ['Indore', 'Bhopal', 'Ahmedabad', 'Mumbai', 'Bengaluru'];

  final dates = [
    'Today',
    'Tomorrow',
    'Next Week',
    'This Month',
    'Next Month',
    'Custom Date',
  ];

  final liveEvents = [
    {
      'title': 'Friday Night Speed Dating',
      'city': 'Indore',
      'venue': 'High Street Social, AB Road',
      'price': '₹249',
      'joined': 24,
      'spots': 6,
      'status': 'LIVE NOW',
      'time': 'Started 15m ago • Round 2 of 5',
      'image':
          'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=900',
    },
    {
      'title': 'Creatives & Introverts Mixer',
      'city': 'Bhopal',
      'venue': 'Artisan Alley Lounge',
      'price': '₹199',
      'joined': 18,
      'spots': 4,
      'status': 'LIVE NOW',
      'time': 'Started 10m ago • 3-min micro dates',
      'image':
          'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=900',
    },
    {
      'title': 'Coffee & Conversations',
      'city': 'Indore',
      'venue': 'Sky Lounge, AB Road',
      'price': '₹299',
      'joined': 16,
      'spots': 8,
      'status': 'LIVE NOW',
      'time': 'Started 20m ago • Meet new people',
      'image':
          'https://images.unsplash.com/photo-1521737711867-e3b97375f902?w=900',
    },
  ];

  final upcomingEvents = [
    {
      'title': 'Friday Night Speed Dating',
      'city': 'Indore',
      'venue': 'Downtown Cafe, Old Palasia',
      'date': 'Fri, 27 Sep • 7:30 PM IST',
      'price': '₹249',
      'joined': 24,
      'capacity': 30,
      'tag': 'Selling Fast • 90% Booked',
      'image':
          'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=900',
    },
    {
      'title': 'Coffee & Connections',
      'city': 'Bhopal',
      'venue': 'Roast & Toast, MP Nagar',
      'date': 'Sat, 28 Sep • 11:30 AM IST',
      'price': 'Free Entry',
      'joined': 18,
      'capacity': 25,
      'tag': 'Popular',
      'image':
          'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=900',
    },
    {
      'title': 'Weekend Sunset Rooftop Meetup',
      'city': 'Indore',
      'venue': 'Sky Lounge, AB Road',
      'date': 'Sun, 29 Sep • 6:30 PM IST',
      'price': '₹299',
      'joined': 20,
      'capacity': 35,
      'tag': 'Curated Singles',
      'image':
          'https://images.unsplash.com/photo-1511988617509-a57c8a288659?w=900',
    },
  ];

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void toggleCity(String city) {
    if (activeCities.contains(city)) {
      activeCities.remove(city);
    } else {
      activeCities.add(city);
    }
  }

  void toggleFavorite(int index) {
    if (favorites.contains(index)) {
      favorites.remove(index);
    } else {
      favorites.add(index);
    }
  }

  void selectDate(String date) {
    selectedDate.value = date;
  }

  void clearFilters() {
    activeCities.clear();
    selectedDate.value = '';
  }

  void applyFilters() {
    Get.back();
  }

  List<Map<String, dynamic>> get filteredLiveEvents {
    return liveEvents.where((event) {
      return activeCities.isEmpty ||
          activeCities.contains(event['city']);
    }).toList();
  }

  List<Map<String, dynamic>> get filteredUpcomingEvents {
    return upcomingEvents.where((event) {
      return activeCities.isEmpty ||
          activeCities.contains(event['city']);
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
