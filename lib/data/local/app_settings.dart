import 'package:flutter/foundation.dart';

class AppSettings {
  String languageCode = 'en';

  AppSettings();

  AppSettings.fromJson(Map<String, dynamic> json) {
    try {
      languageCode = json['languageCode'];
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'languageCode': languageCode,
    };
  }

  void copyFrom(AppSettings appSettings) {
    try {
      languageCode = appSettings.languageCode;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}