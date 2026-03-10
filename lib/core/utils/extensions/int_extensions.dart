
import 'package:flutter/material.dart';

extension IntExtensions on int? {
  int validate({int value = 0}) {
    if (this == null) {
      return value;
    } else {
      return this!;
    }
  }

  bool isSuccessful() => this! >= 200 && this! <= 206;

  Widget get height => SizedBox(height: this!.toDouble());
  Widget get width => SizedBox(width: this!.toDouble());

  Duration get microseconds => Duration(microseconds: validate());
  Duration get milliseconds => Duration(milliseconds: validate());
  Duration get seconds => Duration(seconds: validate());
  Duration get minutes => Duration(minutes: validate());
  Duration get hours => Duration(hours: validate());
  Duration get days => Duration(days: validate());

  // double get h => ((this! * getIt<AppStore>().height) / getIt<AppStore>().defaultHeight);

  // double get w => ((this! * getIt<AppStore>().width) / getIt<AppStore>().defaultWidth);

  // double get sp =>
  //     ((getIt<AppStore>().width * getIt<AppStore>().height) * this!) /
  //         (getIt<AppStore>().defaultHeight * getIt<AppStore>().defaultWidth);
}

extension PercentSized on int {
  // double get h => ((this *
  //         WidgetsBinding
  //             .instance.platformDispatcher.views.first.physicalSize.height) /
  //     852 /
  //     1.624);
  // double get w => ((this *
  //         WidgetsBinding
  //             .instance.platformDispatcher.views.first.physicalSize.width) /
  //     393);
  // double get sp => ((WidgetsBinding
  //             .instance.platformDispatcher.views.first.physicalSize.height *
  //         WidgetsBinding
  //             .instance.platformDispatcher.views.first.physicalSize.width *
  //         this) /
  //     (925 * 430) /
  //     2.501);
  // double get sp => ((WidgetsBinding
  //             .instance.platformDispatcher.views.first.physicalSize.height *
  //         WidgetsBinding
  //             .instance.platformDispatcher.views.first.physicalSize.width *
  //         this) *
  //     0.0000009);
}
