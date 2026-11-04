import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_config.dart';

class SpeedDateStatus {
  SpeedDateStatus({
    required this.phase,
    required this.eventName,
    required this.waitSeconds,
    required this.averageWaitSeconds,
    required this.waitingSingles,
    required this.matchCount,
    required this.matchTarget,
    required this.refundEligible,
    required this.refundMessage,
    required this.roundSeconds,
    required this.elapsedSeconds,
    required this.room,
    required this.url,
    required this.token,
    this.partnerName = '',
    this.partnerId = '',
    this.partnerPhoto = '',
    this.partnerAge = 0,
    this.partnerCity = '',
    this.introSeconds = 33,
  });

  final String phase;
  final String eventName;
  final int? waitSeconds;
  final int? averageWaitSeconds;
  final int waitingSingles;
  final int matchCount;
  final int matchTarget;
  final bool refundEligible;
  final String refundMessage;
  final int roundSeconds;
  final int elapsedSeconds;
  final String room;
  final String url;
  final String token;
  final String partnerName;
  final String partnerId;
  final String partnerPhoto;
  final int partnerAge;
  final String partnerCity;
  final int introSeconds;

  factory SpeedDateStatus.fromJson(Map<String, dynamic> json) {
    return SpeedDateStatus(
      phase: json['phase']?.toString() ?? 'not_joined',
      eventName: json['eventName']?.toString() ?? '',
      waitSeconds: _nullableInt(json['waitSeconds']),
      averageWaitSeconds: _nullableInt(json['averageWaitSeconds']),
      waitingSingles: _int(json['waitingSingles']),
      matchCount: _int(json['matchCount']),
      matchTarget: _int(json['matchTarget'], fallback: 3),
      refundEligible: json['refundEligible'] == true,
      refundMessage: json['refundMessage']?.toString() ?? '',
      roundSeconds: _int(json['roundSeconds'], fallback: 213),
      elapsedSeconds: _int(json['elapsedSeconds']),
      room: json['room']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
      token: json['token']?.toString() ?? '',
      partnerName: json['partnerName']?.toString() ?? '',
      partnerId: json['partnerId']?.toString() ?? '',
      partnerPhoto: json['partnerPhoto']?.toString() ?? '',
      partnerAge: _int(json['partnerAge']),
      partnerCity: json['partnerCity']?.toString() ?? '',
      introSeconds: _int(json['introSeconds'], fallback: 33),
    );
  }

  static int _int(dynamic value, {int fallback = 0}) {
    if (value is num) return value.round();
    return int.tryParse(value?.toString() ?? '') ?? fallback;
  }

  static int? _nullableInt(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.round();
    return int.tryParse(value.toString());
  }
}

class SpeedDateApi {
  static const String _root = '${ApiConfig.baseUrl}/speeddate';

  static Future<SpeedDateStatus> join(String eventId) {
    return _send('POST', '/join', {'eventId': eventId});
  }

  static Future<SpeedDateStatus> status(String eventId) {
    return _send('GET', '/status?eventId=$eventId', null);
  }

  static Future<SpeedDateStatus> leave(String eventId) {
    return _send('POST', '/leave', {'eventId': eventId});
  }

  static Future<SpeedDateStatus> rotate(String eventId) {
    return _send('POST', '/rotate', {'eventId': eventId});
  }

  static Future<void> saveProfile({
    required String eventId,
    required String partnerId,
    required bool save,
    required int durationSeconds,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('tokenData') ?? prefs.getString('token') ?? '';
    final response = await http.post(
      Uri.parse('$_root/save'),
      headers: {
        'Authorization': saved.startsWith('Bearer ') ? saved : 'Bearer $saved',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'eventId': eventId,
        'partnerId': partnerId,
        'save': save,
        'durationSeconds': durationSeconds,
      }),
    );
    final decoded = response.body.isEmpty ? {} : jsonDecode(response.body);
    final payload = decoded is Map ? decoded : {};
    if (response.statusCode != 200 || payload['success'] != true) {
      throw Exception(payload['message']?.toString() ?? 'Could not save this profile');
    }
  }

  static Future<Map<String, dynamic>> saves() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('tokenData') ?? prefs.getString('token') ?? '';
    final response = await http.get(
      Uri.parse('$_root/saves'),
      headers: {
        'Authorization': saved.startsWith('Bearer ') ? saved : 'Bearer $saved',
        'Accept': 'application/json',
      },
    );
    final decoded = response.body.isEmpty ? {} : jsonDecode(response.body);
    final payload = decoded is Map ? decoded : {};
    if (response.statusCode != 200 || payload['success'] != true) {
      throw Exception(payload['message']?.toString() ?? 'Could not load saved profiles');
    }
    final data = payload['data'];
    return data is Map ? Map<String, dynamic>.from(data) : {};
  }

  static Future<SpeedDateStatus> _send(
    String method,
    String path,
    Map<String, dynamic>? body,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('tokenData') ?? prefs.getString('token') ?? '';
    if (saved.isEmpty) {
      throw Exception('Login required');
    }

    final headers = {
      'Authorization': saved.startsWith('Bearer ') ? saved : 'Bearer $saved',
      'Accept': 'application/json',
      if (body != null) 'Content-Type': 'application/json',
    };
    final uri = Uri.parse('$_root$path');
    final response = method == 'GET'
        ? await http.get(uri, headers: headers)
        : await http.post(uri, headers: headers, body: jsonEncode(body));

    final decoded = response.body.isEmpty ? {} : jsonDecode(response.body);
    final payload = decoded is Map ? decoded : {};
    if (response.statusCode != 200 || payload['success'] != true) {
      throw Exception(payload['message']?.toString() ?? 'Could not update the queue');
    }
    final data = payload['data'];
    if (data is! Map) {
      throw Exception('Live queue response was incomplete');
    }
    return SpeedDateStatus.fromJson(Map<String, dynamic>.from(data));
  }
}
