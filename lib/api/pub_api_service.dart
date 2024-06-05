import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PubApiService {
  final String baseUrl = 'http://mars.x0x1.lol/';

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  PubApiService();

  // Method to fetch servers (public)
  Future<dynamic> fetchFreeServers() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/free-servers/'), headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to load servers. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Failed to load servers. Error: $e');
      return null;
    }
  }

  Future<dynamic> updateConfigIsConnected(id, isConnected) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/configs/$id/is_connected/'),
        headers: headers,
        body: jsonEncode({'is_connected': isConnected}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to update config: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Failed to update config. Error: $e');
      return null;
    }
  }

  // Method to fetch pricing plans (public)
  Future<dynamic> fetchPricingPlans() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/pricing-plans/'),
          headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print(
            'Failed to load pricing plans. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Failed to load pricing plans. Error: $e');
      return null;
    }
  }

  Future<dynamic> login(String code) async {
    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('deviceId');
    String? deviceModel = prefs.getString('deviceModel');
    String? uuid = prefs.getString('uuid');
    final response = await http.post(
      Uri.parse('$baseUrl/login/code/'),
      headers: {
        'Content-Type': 'application/json',
        'Device-ID': deviceId ?? '',
        'Device-Model': deviceModel ?? '',
        'UUID': uuid ?? '',
      },
      body: jsonEncode({'code': code}),
    );

    print(response.body);
    // print(response.headers);

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return {
        'access': data['access'],
        'refresh': data['refresh'],
      };
    } else {
      if (data['detail']
          .toString()
          .toLowerCase()
          .contains('too many failed attempts.')) {
        var duration = extractRetryDuration(data['detail']);
        print(duration);
        return duration;
      }
      return null;
    }
  }

  Future<dynamic> pingPong() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/ping/'), headers: headers);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
