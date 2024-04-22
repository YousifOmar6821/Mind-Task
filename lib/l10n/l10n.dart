import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../data/local/global_settings.dart';

class L10n {
  static final supportedLocales = [
    const Locale('en'),
    const Locale('ar'),
  ];

  static const localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate
  ];

  static String switchLanguage() {
    int index = supportedLocales.indexOf(supportedLocales.firstWhere((element) => element.languageCode == GlobalSettings.appSettings.languageCode));
    return supportedLocales[(index + 1) % supportedLocales.length].languageCode;
  }
}