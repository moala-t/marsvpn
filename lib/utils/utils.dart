import '../data/countries.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';

Future<String> downloadAndReadFile(String url) async {
  try {
    // Make the HTTP GET request
    final response = await http.get(Uri.parse(url));
    
    // Check if the request was successful
    if (response.statusCode == 200) {
      // Convert the response body to a string
      String fileContent = utf8.decode(response.bodyBytes);
      return fileContent;
    } else {
      throw Exception('Failed to load file');
    }
  } catch (e) {
    throw Exception('Failed to load file: $e');
  }
}

Future<void> saveInteger(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt(key, value);
}

Future<int?> loadInteger(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt(key);
}


Future<void> saveDateTime(String key, DateTime dateTime) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String dateTimeString = dateTime.toIso8601String();
  await prefs.setString(key, dateTimeString);
}

Future<DateTime?> loadDateTime(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? dateTimeString = prefs.getString(key);
  if (dateTimeString != null) {
    return DateTime.parse(dateTimeString);
  }
  return null; // Return null if no DateTime is stored
}


class DeviceInfoService {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future<Map<String, String>> getDeviceDetails() async {
    String deviceId = '';
    String deviceModel = '';

    try {
      if (Platform.isAndroid) {
        var androidInfo = await deviceInfoPlugin.androidInfo;
        deviceId = androidInfo.id;
        deviceModel = androidInfo.model;
      } else if (Platform.isIOS) {
        var iosInfo = await deviceInfoPlugin.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? 'Unknown';
        deviceModel = iosInfo.model ;
      }
    } catch (e) {
      print('Failed to get device info: $e');
    }

    return {
      'deviceId': deviceId,
      'deviceModel': deviceModel,
    };
  }

  Future<void> saveDeviceDetails(Map<String, String> details) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('deviceId', details['deviceId'] ?? 'Unknown');
    await prefs.setString('deviceModel', details['deviceModel'] ?? 'Unknown');
  }

  Future<Map<String, String>?> getStoredDeviceDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('deviceId');
    String? deviceModel = prefs.getString('deviceModel');

    if (deviceId == null || deviceModel == null) {
      return null;
    }

    return {
      'deviceId': deviceId,
      'deviceModel': deviceModel,
    };
  }

  Future<Map<String, String>> getOrStoreDeviceDetails() async {
    // Try to get stored device details
    final storedDetails = await getStoredDeviceDetails();

    if (storedDetails != null) {
      // If details are found in storage, return them
      return storedDetails;
    } else {
      // Otherwise, fetch the device details
      final fetchedDetails = await getDeviceDetails();
      // Save the fetched details to storage
      await saveDeviceDetails(fetchedDetails);
      // Return the fetched details
      return fetchedDetails;
    }
  }
}



class UUIDService {
  final Uuid _uuid = Uuid();

  // Generate and return a new UUID
  Future<String> getUUID() async {
    return _uuid.v1();
  }

  // Save a given UUID to SharedPreferences
  Future<void> storeUUID(String uuid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uuid', uuid);
  }

  // Retrieve the saved UUID from SharedPreferences or return null if it doesn't exist
  Future<String?> getStoredUUID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('uuid');
  }

  // Try to get the stored UUID; if it doesn't exist, generate a new one, save it, and return it
  Future<String> getOrStoreUUID() async {
    final storedUUID = await getStoredUUID();

    if (storedUUID != null) {
      // If UUID is found in storage, return it
      return storedUUID;
    } else {
      // Otherwise, generate a new UUID
      final newUUID = await getUUID();
      // Save the new UUID to storage
      await storeUUID(newUUID);
      // Return the new UUID
      return newUUID;
    }
  }
}



String getCountryName(String isoCode) {
  for (var country in countries) {
    if (country['isoCode'] == isoCode.toUpperCase()) {
      return country['name'].toString();
    }
  }
  return 'Unknown Country';
}

int? extractRetryDuration(String detail) {
  final regex = RegExp(r'Try again (\d+) seconds later');
  final match = regex.firstMatch(detail);
  if (match != null) {
    return int.parse(match.group(1)!);
  }
  return null;
}
