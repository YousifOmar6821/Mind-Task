import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/constants/routes.dart';
import '../data/local/global_settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../l10n/l10n.dart';

class LanguageManager {
  static Future<void> switchLanguage(context,String screen) async {
    GlobalSettings.appSettings.languageCode = L10n.switchLanguage();
    await Get.updateLocale(Locale(GlobalSettings.appSettings.languageCode)).then((value) async {
      GlobalSettings.lang = AppLocalizations.of(context)!;
      GlobalSettings.isEn = Get.locale!.languageCode == 'en';
    });
    // await LocalStorageHelper.saveAppSettings();

    screen=='home'
    ?Get.offAllNamed(homeScreen)
    :Get.offAllNamed(loginScreen);
    // Restart.restartApp();
  }
}