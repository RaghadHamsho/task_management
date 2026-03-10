
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_management_system/application/auth/logic/change_card_cubit.dart';
import 'app_theme.dart';
import 'application/auth/screens/login_screen.dart';
import 'configure_di.dart';
import 'core/app_store/app_store.dart';
import 'core/local/app_localization.dart';
import 'core/local/language_data_model.dart';
import 'core/local/languages.dart';
import 'core/local/languages/language_en.dart';
import 'core/logic/global_bloc.dart';

BaseLanguage language = LanguageEn();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// enum Role { departmentSupervisor, specialist, employee }

// Role role = Role.specialist;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  await getIt<AppStore>().initial();
  runApp( const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GlobalBloc()),
        BlocProvider(create: (context) => ChangeCardCubit()),
      ],
      child: BlocBuilder<GlobalBloc, GlobalState>(
        builder: (context, state) {
          return MaterialApp(
              navigatorKey: navigatorKey,
              builder: (context, child) {
                child = EasyLoading.init(
                  builder: (context, innerChild) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        alwaysUse24HourFormat: false,
                        textScaler: const TextScaler.linear(1.0),
                      ),
                      child: innerChild!,
                    );
                  },
                )(context, child);
                return child;
              },
              debugShowCheckedModeBanner: false,
              theme: getAppTheme(context,
                  state.isDarkTheme),
              localizationsDelegates: const [
                AppLocalizations(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: LanguageDataModel.languageLocales(),
              localeResolutionCallback: (locale, supportedLocales) => locale,
              locale: Locale(getIt<AppStore>().selectedLanguageCode),
              home: const LoginScreen());
        },
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2500)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor = Colors.white
    ..indicatorColor = getIt<AppStore>().isDarkMode ? Colors.black : const Color(0xFF701B15)
    ..progressColor = getIt<AppStore>().isDarkMode ? Colors.black : Colors.white
    ..textColor = getIt<AppStore>().isDarkMode ? Colors.black : Colors.white
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = false;
}
