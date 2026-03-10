part of 'global_bloc.dart';

class GlobalState {
  String languageCode;
  bool isDarkTheme;

  GlobalState({required this.languageCode, required this.isDarkTheme});

  factory GlobalState.initial({required String languageCode, required bool isDarkTheme}) =>
      GlobalState(languageCode: languageCode, isDarkTheme: isDarkTheme);

  GlobalState copyWith({
    String? languageCode,
    bool? isDarkTheme,
  }) {
    return GlobalState(
      languageCode: languageCode ?? this.languageCode,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
    );
  }
}

