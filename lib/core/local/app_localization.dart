import 'package:flutter/material.dart';

import 'language_data_model.dart';
import 'languages.dart';
import 'languages/language_ar.dart';
import 'languages/language_en.dart';

class AppLocalizations extends LocalizationsDelegate<BaseLanguage> {
  const AppLocalizations();

  @override
  Future<BaseLanguage> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'ar':
        return LanguageAr();
      default:
        return LanguageEn();
    }
  }

  @override
  bool isSupported(Locale locale) =>
      LanguageDataModel.languages().contains(locale.languageCode);

  @override
  bool shouldReload(LocalizationsDelegate<BaseLanguage> old) => false;
}

