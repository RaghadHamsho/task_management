import 'package:task_management_system/core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

import '../app_store/app_store.dart';
import '../data/local_data/shared_pref.dart';
import '../values/constant.dart';

class LanguageDataModel {
  int? id;
  String? name;
  String? languageCode;
  String? fullLanguageCode;
  String? flag;
  String? subTitle;

  LanguageDataModel({
    this.id,
    this.name,
    this.languageCode,
    this.flag,
    this.fullLanguageCode,
    this.subTitle,
  });

  static List<String> languages() {
    List<String> list = [];

    for (var element in localeLanguageList) {
      list.add(element.languageCode.validate());
    }

    return list;
  }

  static List<Locale> languageLocales() {
    List<Locale> list = [];

    for (var element in localeLanguageList) {
      list.add(Locale(element.languageCode.validate(), element.fullLanguageCode.validate()));
    }

    return list;
  }
}

LanguageDataModel? getSelectedLanguageModel({String? defaultLanguage}) {
  LanguageDataModel? data;

  for (var element in localeLanguageList) {
    if (element.languageCode == getStringAsync(SELECTED_LANGUAGE_CODE, defaultValue: defaultLanguage ?? 'en')) {
      data = element;
    }
  }

  return data;
}
