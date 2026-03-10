import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:task_management_system/application/auth/screens/login_mobile_screen.dart';
import 'package:task_management_system/application/tasks/screens/tasks_mobile_screen.dart';
import 'package:task_management_system/core/utils/extensions/widget_extensions.dart';
import 'package:task_management_system/core/values/values.dart';
import 'package:task_management_system/core/widgets/change_language_widget.dart';
import 'package:task_management_system/main.dart';
import '../../../app_theme.dart';
import '../../../core/values/values.dart' as values;
import '../../../configure_di.dart';
import '../../../core/app_store/app_store.dart';
import '../../../core/widgets/change_theme_widget.dart';
import '../../dashboard/screens/dashboard_mobile_screen.dart';
import '../../dashboard/screens/dashboard_screen.dart';
import '../../tasks/screens/tasks_screen.dart';

class HomeMobileScreen extends StatefulWidget {
  const HomeMobileScreen({super.key});

  @override
  State<HomeMobileScreen> createState() => _HomeMobileScreenState();
}

class _HomeMobileScreenState extends State<HomeMobileScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const TasksMobileScreen(),
    const DashboardMobileScreen(),
  ];
  final List<String> titles = [language.tasks, language.dashboardTitle];

  @override
  Widget build(BuildContext context) {
    final isDark = getIt<AppStore>().isDarkMode;
    return Scaffold(
      backgroundColor: colors(context).backgroundColor,
      appBar: AppBar(
        title: Text(titles[currentIndex], style: TextStyle(fontSize: 18)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: values.AppColors.kDarkGreenColor,
        leading: Stack(
          children: [
            IconButton(
              icon: Icon(Icons.notifications, size: 26, color: Colors.black54),
              onPressed: () {},
            ),

            Positioned(
              right: 13,
              top: 5,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: BoxConstraints(minWidth: 12, minHeight: 12),
                child: Text(
                  '3',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _showMenuSheet(context);
            },
          ),
        ],
      ),
      body: pages[currentIndex],

      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: values.AppColors.kDarkGreenColor,
        activeColor: Colors.white,
        color: Colors.white70,

        items: [
          TabItem(icon: Icons.task_alt, title: language.tasks),
          TabItem(icon: Icons.dashboard, title: language.dashboardTitle),
        ],

        initialActiveIndex: 0,
        onTap: (int i) {
          setState(() {
            currentIndex = i;
          });
        },
      ),
    );
  }
}

void _showMenuSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              color: colors(context).cardColor,
            ),

            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: values.AppColors.kDarkGreenColor,
                          ),
                          child: const Icon(
                            Icons.person_outline,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("raghad hamsho"),
                          SizedBox(height: 4),
                          Text(
                            "raghadhamsho028@gmail.com",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getIt<AppStore>().isDarkMode
                            ? language.darkMode
                            : language.lightMode,
                        style: TextStyle(
                          color: colors(context).textColor,
                          fontSize: 14,
                        ),
                      ),
                      ChangeThemeWidget(),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        language.language,
                        style: TextStyle(
                          color: colors(context).textColor,
                          fontSize: 14,
                        ),
                      ),
                      ChangeLanguageWidget(),
                    ],
                  ),

                  const SizedBox(height: 10),

                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: Text(
                      language.logout,
                      style: TextStyle(
                        color: colors(context).textColor,
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      LoginMobileScreen().launch(context, isNewTask: true);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
