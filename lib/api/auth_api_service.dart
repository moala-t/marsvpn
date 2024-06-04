import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthApiService {
  final String baseUrl = 'http://172.20.10.3:8000';
  final int maxRetries = 1; // Maximum number of retry attempts

  AuthApiService();

  // Method to fetch user details (auth)
  Future<dynamic> fetchUser({int retryCount = 0}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/me/'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        if (response.statusCode == 401 && retryCount < maxRetries) {
          await refreshToken();
          return fetchUser(retryCount: retryCount + 1);
        }
        print(
            'Failed to load user details. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Failed to load user details. Error: $e');
      return null;
    }
  }

  Future<dynamic> fetchPremiumServers({int retryCount = 0}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/premium-servers/'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        if (response.statusCode == 401 && retryCount < maxRetries) {
          await refreshToken();
          return fetchPremiumServers(retryCount: retryCount + 1);
        }
        print(
            'Failed to load premium servers. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Failed to load premium servers. Error: $e');
      return null;
    }
  }

  // Method to refresh the access token (public)
  Future<void> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh_token');
    final response = await http.post(
      Uri.parse('$baseUrl/login/refresh/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await prefs.setString('access_token', data['access']);
    } else {
      print('Failed to refresh token. Status code: ${response.statusCode}');
      // Handle refresh token expiration (e.g., logout user)
    }
  }

  // Helper method to get headers with the access token
  Future<Map<String, String>> _getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final deviceId = prefs.getString('deviceId');
    final uuid = prefs.getString('uuid');
    final accessToken = prefs.getString('access_token');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Device-ID': deviceId ?? '',
      'UUID': uuid ?? '',
    };
  }

  // Method to log out user
  Future<bool> logout({int retryCount = 0}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/logout/'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        print('Logged out successfully.');
        return true;
      } else {
        if (response.statusCode == 401 && retryCount < maxRetries) {
          await refreshToken();
          return await logout(retryCount: retryCount + 1);
        }
        print('Failed to log out. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Failed to log out. Error: $e');
      return false;
    }
  }
}
