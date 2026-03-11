import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_system/application/tasks/screens/tasks_screen.dart';
import 'package:task_management_system/core/utils/extensions/widget_extensions.dart';
import 'package:task_management_system/core/utils/functions.dart';
import 'package:task_management_system/core/values/values.dart';
import 'package:task_management_system/main.dart';
import '../../../app_theme.dart';
import '../../../configure_di.dart';
import '../../../core/app_store/app_store.dart';
import '../../../core/widgets/button_widget.dart';
import '../logic/change_card_cubit.dart';
import '../widgets/text_field_widget.dart';
import '../../../core/values/values.dart' as values;
import 'package:task_management_system/core/values/values.dart';

class LoginWebScreen extends StatelessWidget {
  LoginWebScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = getIt<AppStore>().isDarkMode;

    return Stack(
      children: [
        /// BACKGROUND IMAGE
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                getIt<AppStore>().selectedLanguageCode == 'en'
                    ? ImagePath.loginBackgroundEnglish
                    : ImagePath.loginBackgroundArabic,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),

        /// GLASS + CONTENT
        Align(
          alignment: getIt<AppStore>().selectedLanguageCode == 'en'
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  width: 475,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.10),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(.3)),
                  ),

                  /// YOUR EXISTING COLUMN
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 30),

                      /// ICON
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              values.AppColors.kDarkGreenColor,
                              values.AppColors.kLightGreenColor,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.library_add_check_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// TITLE
                      Text(
                        language.appName,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// YOUR LOGIN CARD CONTENT
                      BlocBuilder<ChangeCardCubit, bool>(
                        builder: (context, isSignUp) {
                          return Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isSignUp
                                      ? language.createAccount
                                      : language.login,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: colors(context).textColor,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                if (isSignUp) ...[
                                  Text(
                                    language.userName,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  CustomTextField(
                                    controller: usernameController,
                                    hint: language.enterUserName,
                                    icon: Icons.person_outline,
                                    isAuth: true,
                                    validator: Functions.usernameValidator,
                                  ),
                                  const SizedBox(height: 10),
                                ],

                                /// EMAIL
                                Text(
                                  language.email,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                CustomTextField(
                                  controller: emailController,
                                  hint: language.enterEmail,
                                  icon: Icons.email_outlined,
                                  isAuth: true,
                                  validator: Functions.emailValidator,
                                ),
                                const SizedBox(height: 10),

                                /// PASSWORD
                                Text(
                                  language.password,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                CustomTextField(
                                  controller: passwordController,
                                  hint: language.enterPassword,
                                  icon: Icons.lock,
                                  isPassword: true,
                                  isAuth: true,
                                  validator: Functions.passwordValidator,
                                ),

                                if (!isSignUp) ...[
                                  const SizedBox(height: 4),
                                  Align(
                                    alignment:getIt<AppStore>().selectedLanguageCode == "en"? Alignment.topRight:AlignmentGeometry.topLeft,
                                    child: Text(
                                      language.forgotPassword,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],

                                SizedBox(height: isSignUp ? 20 : 50),

                                /// BUTTON
                                CustomButton(
                                  gradient: LinearGradient(
                                    colors: [
                                      values.AppColors.kDarkGreenColor,
                                      values.AppColors.kLightGreenColor,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  text: isSignUp
                                      ? language.createAccount
                                      : language.login,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // Navigate only if valid
                                      TasksScreen().launch(context);
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 35),

                      /// TOGGLE SIGN IN / SIGN UP
                      GestureDetector(
                        onTap: () {
                          context.read<ChangeCardCubit>().toggleAuth();
                        },
                        child: BlocBuilder<ChangeCardCubit, bool>(
                          builder: (context, isSignUp) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isSignUp
                                      ? language.alreadyHaveAccount
                                      : language.dontHaveAccount,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                                SizedBox(width: 4,),
                                Text(
                                  isSignUp
                                      ? language.login
                                      : language.createAccount,

                                  style: TextStyle(
                                 decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );

    /// RIGHT LOGIN/SIGNUP FORM
    // Expanded(
    //   flex: 3,
    //   child:
  }
}
