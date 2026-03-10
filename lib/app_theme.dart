// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

AppColors colors(context) => Theme.of(context).extension<AppColors>()!;

ThemeData getAppTheme(BuildContext context, bool isDarkTheme) {
  // isDarkTheme = getIt<AppStore>().isDarkMode;
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff2B3C4E)),
    textTheme: TextTheme(
      displayMedium: TextStyle(color: isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      displaySmall: TextStyle(color: isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      displayLarge: TextStyle(color: isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      bodySmall: TextStyle(color: isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      bodyMedium: TextStyle(color: isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      bodyLarge: TextStyle(color: isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      titleMedium: TextStyle(color: isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      titleLarge: TextStyle(color: isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      headlineSmall: TextStyle(color: isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      headlineLarge: TextStyle(color: isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      headlineMedium: TextStyle(color: isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      labelLarge: TextStyle(color: isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      labelMedium: TextStyle(color: isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      labelSmall: TextStyle(color: isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
      titleSmall: TextStyle(color: isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000000)),
    ),
    extensions: <ThemeExtension<AppColors>>[
      AppColors(
        kAppColor: isDarkTheme ? const Color.fromARGB(255, 36, 47, 81) : const Color(0xff2C3654),
        backgroundColor: isDarkTheme ? const Color.fromARGB(255, 4, 4, 35) : const Color(0xffF9FAFB),
        secondColor: isDarkTheme ? const Color.fromARGB(255, 141, 110, 77) : const Color(0xffD4A574),
        cardColor: isDarkTheme ? const Color(0xff1a1d2f) : Colors.white,
        loginCard: isDarkTheme ? Colors.black : const Color(0xFFFAF9F9),
        textColor: isDarkTheme ? const Color.fromARGB(255, 255, 255, 255) : const Color(0xFF000000),
        secondTextColor: isDarkTheme ? const Color(0xFFFFFFFF) : const Color(0xff2C3654),
        borderColor: isDarkTheme ? const Color(0xFF9EBBD5).withAlpha(50) : const Color(0xFF9A9A9A).withAlpha(50),
        noDataColor: isDarkTheme ? const Color(0xFF9EBBD5).withAlpha(150) : const Color(0xFF9A9A9A).withAlpha(150),
      ),
    ],
  );
}

class AppColors extends ThemeExtension<AppColors> {
  final Color? kAppColor;
  final Color? backgroundColor;
  final Color? secondColor;
  final Color? cardColor;
  final Color? loginCard;
  final Color? textColor;
  final Color? secondTextColor;
  final Color? borderColor;
  final Color? noDataColor;

  const AppColors({
    required this.kAppColor,
    required this.backgroundColor,
    required this.secondColor,
    required this.cardColor,
    required this.loginCard,
    required this.textColor,
    required this.secondTextColor,
    required this.borderColor,
    required this.noDataColor,
  });

  @override
  AppColors copyWith({
    Color? kAppColor,
    Color? backgroundColor,
    Color? secondColor,
    Color? cardColor,
    Color? loginCard,
    Color? textColor,
    Color? secondTextColor,
    Color? borderColor,
    Color? noDataColor,
  }) {
    return AppColors(
      kAppColor: kAppColor ?? this.kAppColor,
      backgroundColor: backgroundColor ?? backgroundColor,
      cardColor: cardColor ?? cardColor,
      loginCard: loginCard ?? loginCard,
      textColor: textColor ?? textColor,
      secondTextColor: secondTextColor ?? secondTextColor,
      borderColor: borderColor ?? borderColor,
      noDataColor: noDataColor ?? noDataColor,
      secondColor: secondColor ?? secondColor,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      kAppColor: Color.lerp(kAppColor, other.kAppColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      cardColor: Color.lerp(cardColor, other.cardColor, t),
      loginCard: Color.lerp(loginCard, other.loginCard, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      secondTextColor: Color.lerp(secondTextColor, other.secondTextColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      noDataColor: Color.lerp(noDataColor, other.noDataColor, t),
      secondColor: Color.lerp(secondColor, other.secondColor, t),
    );
  }

  colors(BuildContext context) {}
}
