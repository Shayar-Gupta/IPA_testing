import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as webStorage;

class DataStoreManager {
  static const String _USERNAME_KEY = "username";
  static const String _EMPLOYEE_ID_KEY = "employeeId";

  // Save user details
  static Future<void> saveUserDetails(String username, String employeeId) async {
    if (kIsWeb) {
      // Use localStorage for Web
      webStorage.window.localStorage[_USERNAME_KEY] = username;
      webStorage.window.localStorage[_EMPLOYEE_ID_KEY] = employeeId;
    } else {
      // Use SharedPreferences for Mobile
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_USERNAME_KEY, username);
      await prefs.setString(_EMPLOYEE_ID_KEY, employeeId);
    }
  }

  // Retrieve username
  static Future<String> getUsername() async {
    if (kIsWeb) {
      return webStorage.window.localStorage[_USERNAME_KEY] ?? "Unknown User";
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(_USERNAME_KEY) ?? "Unknown User";
    }
  }

  // Retrieve employee ID
  static Future<String> getEmployeeID() async {
    if (kIsWeb) {
      return webStorage.window.localStorage[_EMPLOYEE_ID_KEY] ?? "0000000";
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(_EMPLOYEE_ID_KEY) ?? "0000000";
    }
  }
}
