import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:task_management_system/application/auth/screens/login_web_screen.dart';

import 'login_mobile_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: kIsWeb ? LoginWebScreen() : LoginMobileScreen());
  }
}
