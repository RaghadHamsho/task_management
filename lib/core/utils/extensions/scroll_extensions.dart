
import 'package:flutter/material.dart';

extension ScrollExtension on ScrollController {
  Future<void> animToTop({milliseconds = 300}) async {
    animateTo(
      0,
      duration: Duration(milliseconds: milliseconds),
      curve: Curves.decelerate,
    );
  }

  Future<void> animToBottom({milliseconds = 300}) async {
    animateTo(
      position.maxScrollExtent,
      duration: Duration(milliseconds: milliseconds),
      curve: Curves.linear,
    );
  }

  Future<void> animateToPosition(double position, {milliseconds = 300}) async {
    animateTo(
      position,
      duration: Duration(milliseconds: milliseconds),
      curve: Curves.linear,
    );
  }

  void jumpToTop() => jumpTo(0);

  void jumpToBottom() => jumpTo(position.maxScrollExtent);
}

