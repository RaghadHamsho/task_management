import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_management_system/core/utils/extensions/int_extensions.dart';
import 'package:task_management_system/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../data/local_data/shared_pref.dart';
import '../local/app_localization.dart';
import '../local/language_data_model.dart';
import '../local/languages/language_ar.dart';
import '../local/languages/language_en.dart';
import '../utils/functions.dart';
import '../values/constant.dart';

late SharedPreferences sharedPreferences;

LanguageDataModel? selectedLanguageDataModel;

List<LanguageDataModel> localeLanguageList = [
  LanguageDataModel(
      id: 1, name: 'English', languageCode: 'en', fullLanguageCode: 'en-US', flag: 'assets/images/ic_us.png'),
  LanguageDataModel(
      id: 2, name: 'Arabic', languageCode: 'ar', fullLanguageCode: 'ar-AR', flag: 'assets/images/ic_ar.png'),
];

Color defaultToastBackgroundColor = Colors.grey.shade200;
Color defaultToastTextColor = Colors.black;
ToastGravity defaultToastGravityGlobal = ToastGravity.CENTER;

Duration pageRouteTransitionDurationGlobal = 400.milliseconds;

PlatformDispatcher platformDispatcher = WidgetsBinding.instance.platformDispatcher;

class AppStore {
  bool isDarkMode = true;

  String selectedLanguageCode = platformDispatcher.locale.languageCode;

  double defaultWidth = 393;
  double defaultHeight = 852;

  final double defaultWidthTablet = 1194;
  final double defaultHeightTablet = 834;

  double width = 0;
  double height = 0;

  initial() async {
    sharedPreferences = await SharedPreferences.getInstance();

    Size screenSize = MediaQueryData.fromView(platformDispatcher.implicitView!).size;
    Orientation orientation = MediaQueryData.fromView(platformDispatcher.implicitView!).orientation;

    if (orientation == Orientation.portrait) {
      width = screenSize.width;
      height = screenSize.height;
    } else {
      width = screenSize.height;
      height = screenSize.width;
    }

    if (((orientation == Orientation.portrait) && (width > 320.0 && width < 480.0)) ||
        ((orientation == Orientation.landscape) && (height > 320.0 && height < 480.0))) {
      defaultWidth = 393;
      defaultHeight = 852;
    }
    if (((orientation == Orientation.portrait) && (width > 481.0)) ||
        ((orientation == Orientation.landscape) && (height > 481.0))) {
      defaultWidth = 1194;
      defaultHeight = 834;
    }
    Functions.printDone("=> Done adding device size if tablet or mobile.");
    Functions.printDone("=> Done adding device size .");

    if (defaultWidth == 1194) {
      if (orientation == Orientation.portrait) {
        AppFonts.smallFontSize = 24;
        AppFonts.mediumFontSize = 26;
        AppFonts.largeFontSize = 28;
        AppFonts.maxFontSize = 30;
      } else {
        AppFonts.smallFontSize = 18;
        AppFonts.mediumFontSize = 20;
        AppFonts.largeFontSize = 22;
        AppFonts.maxFontSize = 24;
      }
    }

    selectedLanguageCode = getStringAsync(SELECTED_LANGUAGE_CODE, defaultValue: platformDispatcher.locale.languageCode);
    selectedLanguageCode == "en" ? language = LanguageEn() : language = LanguageAr();
    Functions.printDone("=> Done adding device language .");

    int themeIndex = getIntAsync(THEME_MODE_INDEX, defaultValue: 0);
    isDarkMode = themeIndex == 1
        ? false
        : themeIndex == 2
        ? true
        : false; // default light

    Functions.printDone("=> Done adding device theme .");
  }

  Future<void> setDarkMode(int themeIndex) async {
    isDarkMode = themeIndex == 1
        ? false
        : themeIndex == 2
            ? true
            : platformDispatcher.platformBrightness.name == "dark";
  }

  Future<void> setLanguage(String val) async {
    selectedLanguageCode = val;
    language = await const AppLocalizations().load(Locale(selectedLanguageCode));
  }
}
