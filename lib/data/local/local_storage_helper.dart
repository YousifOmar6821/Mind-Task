import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '/data/local/app_settings.dart';
import 'global_settings.dart';

class LocalStorageHelper {

  // Write DATA
  // static Future<bool> saveAppSettings() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   await sharedPreferences.setString('appSettings', jsonEncode(GlobalSettings.appSettings.toJson()));
  //   return await sharedPreferences.setInt('nextNotificationId', GlobalSettings.appSettings.nextNotificationId);
  // }
  //
  // // Read Data
  // static Future<AppSettings> loadAppSettings() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   var nextNotificationId = sharedPreferences.getInt('nextNotificationId');
  //   var appSettingsJson = sharedPreferences.getString('appSettings');
  //   if (appSettingsJson == null) {
  //     await saveAppSettings();
  //     return GlobalSettings.appSettings;
  //   } else {
  //     var val = (jsonDecode(appSettingsJson) as Map<String, dynamic>)..addAll({'nextNotificationId': nextNotificationId ?? 0});
  //     return AppSettings.fromJson(val);
  //   }
  // }
  //
  // // Write DATA
  // static Future<bool> saveNextNotificationId() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   return await sharedPreferences.setInt('nextNotificationId', GlobalSettings.appSettings.nextNotificationId);
  // }

  // Read Data
  static Future<int> loadNextNotificationId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt('nextNotificationId') ?? 0;
  }

  // Write DATA
  static Future<bool> saveUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString('credentials', jsonEncode({
      'email': GlobalSettings.user!.email,
      'password': GlobalSettings.password,
    }));
  }

  // Write DATA
  static Future<bool> removeUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.remove('credentials');
  }

  // Read Data
  static Future<Map?> loadUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var user = sharedPreferences.getString('credentials');
    if (user == null) {
      return null;
    } else {
      return jsonDecode(user);
    }
  }
}

