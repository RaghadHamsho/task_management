part of 'global_bloc.dart';

abstract class GlobalEvent {}

class LanguageChanged extends GlobalEvent {
  String language;

  LanguageChanged(this.language);
}

class ThemeChanged extends GlobalEvent {
  bool isDark;

  ThemeChanged(this.isDark);
}
