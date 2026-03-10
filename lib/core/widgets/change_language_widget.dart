import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:task_management_system/app_theme.dart';

import '../../configure_di.dart';
import '../app_store/app_store.dart';
import '../data/local_data/shared_pref.dart';
import '../logic/global_bloc.dart';
import '../values/constant.dart';

class ChangeLanguageWidget extends StatelessWidget {
  const ChangeLanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
      return SizedBox(
        width: 100,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            dropdownColor: colors(context).cardColor,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            icon: Icon(Icons.keyboard_arrow_down_rounded, color: colors(context).textColor, size: 20),
            value: getIt<AppStore>().selectedLanguageCode == 'ar' ? 'العربية' : 'English',
            items: ['English', 'العربية']
                .map((lang) => DropdownMenuItem(
              value: lang,
              child: Text(
                lang,
                style: TextStyle(
                  fontSize: 12,
                  color: colors(context).textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ))
                .toList(),
            onChanged: (value) {
              final code = value == 'English' ? 'en' : 'ar';
              BlocProvider.of<GlobalBloc>(context).add(LanguageChanged(code));
              setValue(SELECTED_LANGUAGE_CODE, code);
              getIt<AppStore>().setLanguage(code);
            },
          ),
        ),
      );
  }
}
