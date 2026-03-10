import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

  Future<T?>? navigateTo<T>(Widget screen, {Object? arguments}) {
    return shellNavigatorKey.currentState?.push<T>(
      MaterialPageRoute(
        builder: (context) => screen,
        settings: RouteSettings(arguments: arguments),
      ),
    );
  }

  Future<T?>? navigateReplaceTo<T>(Widget screen, {Object? arguments}) {
    return shellNavigatorKey.currentState?.pushReplacement<T, void>(
      MaterialPageRoute(
        builder: (context) => screen,
        settings: RouteSettings(arguments: arguments),
      ),
    );
  }

  Future<T?>? navigateToFullScreen<T>(Widget screen, {Object? arguments}) {
    return navigatorKey.currentState?.push<T>(
      MaterialPageRoute(
        builder: (context) => screen,
        settings: RouteSettings(arguments: arguments),
      ),
    );
  }

  Future<T?>? navigateReplaceToFullScreen<T>(Widget screen, {Object? arguments}) {
    return navigatorKey.currentState?.pushReplacement<T, void>(
      MaterialPageRoute(
        builder: (context) => screen,
        settings: RouteSettings(arguments: arguments),
      ),
    );
  }

  void goBack<T>({T? result}) {
    if (shellNavigatorKey.currentState?.canPop() ?? false) {
      shellNavigatorKey.currentState?.pop(result);
    } else if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop(result);
    }
  }

  void popUntil(bool Function(Route<dynamic>) predicate) {
    if (shellNavigatorKey.currentState != null) {
      shellNavigatorKey.currentState?.popUntil(predicate);
    } else {
      navigatorKey.currentState?.popUntil(predicate);
    }
  }

  Future<T?>? navigateAndRemoveUntil<T>(Widget screen, {Object? arguments}) {
    return shellNavigatorKey.currentState?.pushAndRemoveUntil<T>(
      MaterialPageRoute(
        builder: (context) => screen,
        settings: RouteSettings(arguments: arguments),
      ),
      (route) => false,
    );
  }

  bool canPop() {
    return (shellNavigatorKey.currentState?.canPop() ?? false) || (navigatorKey.currentState?.canPop() ?? false);
  }
}
