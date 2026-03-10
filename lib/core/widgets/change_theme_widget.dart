import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_theme.dart';
import '../../configure_di.dart';
import '../app_store/app_store.dart';
import '../logic/global_bloc.dart';

class ChangeThemeWidget extends StatelessWidget {
  const ChangeThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = getIt<AppStore>().isDarkMode;
    return  SizedBox(
      width: 50,
      height: 60,
      child: InkWell(
        onTap: () =>
            BlocProvider.of<GlobalBloc>(context).add(ThemeChanged(!isDark)),
        child: Icon(
          !isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
          color: !isDark ? colors(context).kAppColor : Colors.orangeAccent,
          size: 24,
        ),
      ),
    );
  }
}
