import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:task_management_system/application/dashboard/screens/dashboard_screen.dart';
import 'package:task_management_system/application/tasks/screens/tasks_screen.dart';
import 'package:task_management_system/configure_di.dart';
import 'package:task_management_system/core/app_store/app_store.dart';
import 'package:task_management_system/core/utils/extensions/widget_extensions.dart';
import 'package:task_management_system/main.dart';

import '../../../app_theme.dart';
import '../../../core/values/values.dart'as values;
import '../widgets/app_bar_widget.dart';

class SideMenuPage extends StatefulWidget {
  final int selectedPage;
  final Widget child;
  final String pageTitle;

  const SideMenuPage({
    super.key,
    required this.selectedPage,
    required this.child,
    required this.pageTitle,
  });

  @override
  State<SideMenuPage> createState() => _SideMenuPageState();
}

class _SideMenuPageState extends State<SideMenuPage>
    with WidgetsBindingObserver {
  SideMenuController? _sideMenuController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initController();
  }

  Future<void> _initController() async {
    _sideMenuController = SideMenuController(initialPage: widget.selectedPage);
    setState(() {});
  }

  @override
  void dispose() {
    _sideMenuController?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  void _navigateToPage(int index) {
    _sideMenuController?.changePage(index);

    switch (index) {
      case 0:
        TasksScreen().launch(context);
        break;
      case 1:
        DashboardScreen().launch(context);
        break;
    }
  }
  /// MENU ITEMS
  List<SideMenuItem> _buildMenuItems(BuildContext context) {
    return [
      SideMenuItem(
        title:language.tasks,
        icon: const Icon( Icons.task_alt,),
        onTap: (index, _) => _navigateToPage(index),
      ),
      SideMenuItem(
        title: language.dashboardTitle,
        icon: const Icon(Icons.bar_chart),
        onTap: (index, _) => _navigateToPage(index),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (_sideMenuController == null) {
      return Row(
        children: [
          const SizedBox(
            width: 250,
            child: Center(child: CircularProgressIndicator()),
          ),
          Expanded(child: widget.child),
        ],
      );
    }

    final menuItems = _buildMenuItems(context);
    final isDark = getIt<AppStore>().isDarkMode;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          SideMenu(
            controller: _sideMenuController!,
            items: menuItems,
            collapseWidth: 900,
            style: SideMenuStyle(
              openSideMenuWidth: 255,
                compactSideMenuWidth: 80,
              showTooltip: true, // show title tooltip when compact

              backgroundColor: colors(context).backgroundColor,
              itemBorderRadius: BorderRadius.circular(12),
              hoverColor:isDark?const Color(0xFF3F5755): const Color(0xFFE8F5E9),
              selectedTitleTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              unselectedTitleTextStyle:  TextStyle(color: colors(context).textColor),

              selectedColor: values.AppColors.kDarkGreenColor,
              itemOuterPadding: EdgeInsetsGeometry.only(
                top: 15,
                left: 8,
                right: 8
              ),
              selectedIconColor: Colors.white,
              unselectedIconColor: Colors.grey,
            ),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
              child: Center(
                child: Row(
                  children: [

                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                          values.  AppColors.kDarkGreenColor,
                          values.  AppColors.kLightGreenColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.library_add_check_outlined,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    SizedBox(width: 4,),
                    if(MediaQuery.of(context).size.width >900)
                    Column(children: [
                       Text(
                        language.appName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colors(context).textColor,
                        ),
                      ),

                      const SizedBox(height: 4),

                       Text(
                        language.title,
                        style: TextStyle(color: isDark?Colors.grey:Colors.black54, fontSize: 12),
                      ),
                    ],)
                  ],
                ),
              ),
            ),
            footer: Padding(
              padding: const EdgeInsets.only(bottom:20.0),
              child: Text("2026 Task Flow ",style: TextStyle(fontSize: 12, color: Colors.grey),),
            ),
          ),

          /// RIGHT CONTENT
          Expanded(
            child: Container(
              decoration:  BoxDecoration( gradient: LinearGradient(
                colors:getIt<AppStore>().isDarkMode? [Colors.black,Colors.black]: [Color(0xFFEAFAF7), Color(0xFFE4F5EA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),),
              child: Column(
                children: [
                  Expanded(child: SideMenuAppBar(title: widget.pageTitle)),
                  const Divider(),
                  Expanded(flex: 12, child: widget.child),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
