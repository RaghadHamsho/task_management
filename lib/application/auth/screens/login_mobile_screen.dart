import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:task_management_system/core/utils/extensions/widget_extensions.dart';
import 'package:task_management_system/main.dart';

import '../../../app_theme.dart';
import '../../../core/values/values.dart' as values;
import '../../../configure_di.dart';
import '../../../core/app_store/app_store.dart';
import '../../../core/utils/functions.dart';
import '../../../core/widgets/button_widget.dart';
import '../../home/screens/home_mobile_screen.dart';
import '../../tasks/screens/tasks_screen.dart';
import '../logic/change_card_cubit.dart';
import '../widgets/text_field_widget.dart';

class LoginMobileScreen extends StatelessWidget {
  LoginMobileScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final isDark = getIt<AppStore>().isDarkMode;

    return Container(
      padding: EdgeInsets.all(12),
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [Color(0xFF121212), Color(0xFF1E1E1E)]
              : [Color(0xFFD5F6F2), Color(0xFFD0F6E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child:KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) {

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment:
                isKeyboardVisible ? MainAxisAlignment.start : MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  if(!isKeyboardVisible)...[
                    /// ICON
                    Container(
                      padding: const EdgeInsets.all(14),

                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            values.AppColors.kDarkGreenColor,
                            values.AppColors.kLightGreenColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
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
                        color: colors(context).textColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      language.title,
                      style: TextStyle(
                        color: isDark ? Colors.grey : Colors.black54,
                        fontSize: 13,
                      ),
                    ),],

                  const SizedBox(height: 30),

                  /// CARD
                  Container(
                    width: 400,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: colors(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Colors.black.withOpacity(.08),
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: BlocBuilder<ChangeCardCubit, bool>(
                      builder: (context, isSignUp) {
                        return Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isSignUp ? language.createAccount: language.login,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: colors(context).textColor,
                                ),
                              ),
                              const SizedBox(height: 20),

                              /// USERNAME (Sign Up only)
                              if (isSignUp) ...[
                                Text(
                                  language.userName,
                                  style: TextStyle(
                                    color: colors(context).textColor,
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
                                  color: colors(context).textColor,
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
                                  color: colors(context).textColor,
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
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    language.forgotPassword,
                                    style: TextStyle(
                                      color: colors(context).textColor,
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
                                text: isSignUp ? language.createAccount : language.login,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Navigate only if valid
                                    HomeMobileScreen().launch(context);
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
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
                                color: colors(context).textColor,
                              ),
                            ),
                            Text(
                              isSignUp ?language.login: language.createAccount,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: colors(context).textColor,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

