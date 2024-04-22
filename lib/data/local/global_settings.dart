import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:task/data/models/category.dart';
import 'package:task/data/models/product.dart';
import '../models/slider.dart';
import '../models/user.dart';
import 'app_settings.dart';
class GlobalSettings {
  static User? user;
  static String? password;
  // static String? token;
  static int? notificationsNumber;
  static AppLocalizations lang = AppLocalizationsEn();
  static bool isEn = true;
  static AppSettings appSettings = AppSettings();
  static List<Sliders> sliders = [];
  static List<Categories> categories = [];
  static List<Product> products = [];
  static List<Product> selectedProducts = [];
  static List<Product> newProducts = [];
}