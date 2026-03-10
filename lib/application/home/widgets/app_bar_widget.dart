import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_system/application/auth/screens/login_web_screen.dart';
import 'package:task_management_system/core/utils/extensions/widget_extensions.dart';
import 'package:task_management_system/core/widgets/change_language_widget.dart';
import 'package:task_management_system/main.dart';
import '../../../app_theme.dart';
import '../../../configure_di.dart';
import '../../../core/app_store/app_store.dart';
import '../../../core/logic/global_bloc.dart';
import '../../../core/values/values.dart' as values;
import '../../../core/widgets/change_theme_widget.dart';

class SideMenuAppBar extends StatelessWidget {
  final String title;
  final List<String>? notifications;
  final VoidCallback? onNotificationTap;

  const SideMenuAppBar({
    super.key,
    required this.title,
    this.notifications,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = getIt<AppStore>().isDarkMode;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [Colors.black, Colors.black]
              : [Color(0xFFEAFAF7), Color(0xFFE4F5EA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: colors(context).textColor, fontSize: 18),
          ),
          Spacer(),
          Row(
            children: [
              Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      size: 28,
                      color: isDark ? Color(0xFF4E5F7E) : Colors.black,
                    ),
                    onPressed: () {},
                  ),

                  Positioned(
                    right: 8,
                    top: 5,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(minWidth: 14, minHeight: 14),
                      child: Text(
                        '3',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 16),
ChangeLanguageWidget(),
          SizedBox(width: 16),
          ChangeThemeWidget(),
          SizedBox(width: 16),
          InkWell(
            onTap: () {
              showGeneralDialog(
                context: context,
                barrierDismissible: true,

                barrierLabel: MaterialLocalizations
                    .of(
                  context,
                )
                    .modalBarrierDismissLabel,
                barrierColor: Colors.black54,
                // background dim
                transitionDuration: const Duration(milliseconds: 200),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return SafeArea(
                    child: Align(
                      alignment: getIt <AppStore>().selectedLanguageCode=="en"? Alignment.topRight:AlignmentGeometry.topLeft, //
                      child: Padding(
                        padding: EdgeInsets.only(top: 60, left: 30),
                        child: Material(
                          elevation: 8,
                          shadowColor: Colors.black54,
                          color:  colors(context).cardColor ,
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 4.5,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 3.75,
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        padding: const EdgeInsets.all(
                                            10
                                        ),
                                        margin: const EdgeInsets.all(
                                            10
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                25),
                                            color: isDark
                                                ? Color(0xFF4E5F7E)
                                                : values.AppColors
                                                .kDarkGreenColor
                                        ),
                                        child: Icon(
                                          Icons.person_outline,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "raghad hamsho",
                                            style: TextStyle(
                                              color: colors(context).textColor,
                                              fontSize: 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "raghadhamsho028@gmail.com",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ]),
                                  ],
                                ),



                            SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25.0,
                              ),
                              child: Divider(color: Colors.grey),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 15),
                              child: TextButton(
                                onPressed: () => LoginWebScreen().launch(context,isNewTask: true),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      color: colors(context).textColor,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      language.logout,
                                      style: TextStyle(
                                        color: colors(context).textColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ]),
                        ),
                      ),
                    ),
                  ));
                },
              );
            },
            child: Icon(
              Icons.person,
              size: 24,
              color: isDark ? Color(0xFF4E5F7E) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}


