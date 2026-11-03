import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_config.dart';

class EventBookingApi {
  static Future<String?> book(String eventId) async {
    if (eventId.trim().isEmpty) return 'Event not found.';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('tokenData') ?? prefs.getString('token') ?? '';
    if (token.isEmpty) return 'Please login again.';

    final response = await http.post(
      Uri.parse(ApiConfig.url('/booking')),
      headers: {
        'Authorization': token.startsWith('Bearer ') ? token : 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'eventId': eventId}),
    );

    Map<String, dynamic> body = {};
    if (response.body.isNotEmpty) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) body = decoded;
    }

    if (response.statusCode == 200 && body['success'] == true) return null;
    return body['message']?.toString() ?? 'Could not book the event.';
  }

  static Future<Map<String, String>?> liveEvent() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('tokenData') ?? prefs.getString('token') ?? '';
    if (token.isEmpty) return null;

    final response = await http.get(
      Uri.parse(ApiConfig.url('/booking/live')),
      headers: {
        'Authorization': token.startsWith('Bearer ') ? token : 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode != 200 || response.body.isEmpty) return null;
    final decoded = jsonDecode(response.body);
    if (decoded is! Map || decoded['success'] != true || decoded['data'] is! Map) return null;
    final data = decoded['data'] as Map;
    final eventId = data['eventId']?.toString() ?? '';
    if (eventId.isEmpty) return null;
    return {
      'eventId': eventId,
      'eventName': data['eventName']?.toString() ?? 'Live event',
    };
  }

  static Future<void> requestRefund(String eventId) async {
    if (eventId.trim().isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('tokenData') ?? prefs.getString('token') ?? '';
    if (token.isEmpty) return;
    await http.post(
      Uri.parse(ApiConfig.url('/booking/refund')),
      headers: {
        'Authorization': token.startsWith('Bearer ') ? token : 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'eventId': eventId}),
    );
  }
}
