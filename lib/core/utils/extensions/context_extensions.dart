import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  Brightness platformBrightness() => MediaQuery.of(this).platformBrightness;
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get navigationBarHeight => MediaQuery.of(this).padding.bottom;
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;

  void pop<T extends Object>([T? result]) => Navigator.pop(this, result);

  void openDrawer() => Scaffold.of(this).openDrawer();

  void openEndDrawer() => Scaffold.of(this).openEndDrawer();
}

void finish(BuildContext context, [Object? result]) {
  if (Navigator.canPop(context)) Navigator.pop(context, result);
}
