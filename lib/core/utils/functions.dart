import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;


class Functions {
  static void printWarning(String text) {
    if (kDebugMode) {
      print('[33m$text[0m');
    }
  }

  static void printError(String text) {
    if (kDebugMode) {
      print('[31m$text[0m');
    }
  }

  static void printNormal(String text) {
    if (kDebugMode) {
      print('[36m$text[0m');
    }
  }

  static void printDone(String text) {
    if (kDebugMode) {
      print('[32m$text[0m');
    }
  }

  static Size textSize({
    required String text,
    required TextStyle? style,
    int maxLines = 1,
    double maxWidth = double.infinity,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )
      ..layout(minWidth: 0, maxWidth: maxWidth);
    return textPainter.size;
  }

  static showLoaderDialog(BuildContext context) {
    showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: const Dialog(
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              child: Center(
                  child: CircularProgressIndicator(color: Colors.red)),
            ),
          );
        });
  }

  static String getFormatDate(DateTime date) =>
      intl.DateFormat('MM dd yyyy').format(date);


  static void showSnackBar(
      {required BuildContext context, required SnackBar snackBar}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

 static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return "Email cannot be empty";
    final emailRegex =
    RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$");
    if (!emailRegex.hasMatch(value)) return "Enter a valid email";
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return "Password cannot be empty";
    if (value.length < 6) return "Password must be at least 6 characters";
    return null;
  }
 static  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) return "Username cannot be empty";
    return null;
  }
}
