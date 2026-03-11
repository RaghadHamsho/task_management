import 'package:flutter/cupertino.dart';
import 'package:task_management_system/main.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../app_theme.dart' hide AppColors;
import '../../../core/values/values.dart';
import '../../tasks/model/task_model.dart';

class DashboardMobileScreen extends StatelessWidget {
  const DashboardMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int completedCount = taskList.where((t) => t.status == TaskStatus.completed).length;

    int pendingCount = taskList.where((t) => t.status ==TaskStatus.pending).length;

    int totalCount = taskList.length;
    Map<int, int> completedPerMonth = {};
    double completionRate = totalCount == 0
        ? 0
        : (completedCount / totalCount) * 100;

    /// monthly data

    Map<int, int> pendingPerMonth = {};

    for (var task in taskList) {
      int month = task.createDate.month;

      if (task.status == TaskStatus.completed) {
        completedPerMonth[month] = (completedPerMonth[month] ?? 0) + 1;
      } else {
        pendingPerMonth[month] = (pendingPerMonth[month] ?? 0) + 1;
      }
    }
    return Padding(
      padding: const EdgeInsets.all(20),

      child: Column(
        children: [
          /// STATUS CARDS GRID
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.4,
            physics: const NeverScrollableScrollPhysics(),

            children: [
              _statusCard(
                language.allTasks,
                totalCount.toString(),
                Icons.task_alt,
                Colors.blue,
                context,
              ),

              _statusCard(
                language.completed,
                completedCount.toString(),
                Icons.check_circle_outline,
                Colors.green,
                context,
              ),

              _statusCard(
                language.pending,
                pendingCount.toString(),
                Icons.timelapse,
                Colors.orange,
                context,
              ),

              _statusCard(
                language.completionRate,
                "${completionRate.toStringAsFixed(0)}%",
                Icons.percent,
                Colors.purple,
                context,
              ),
            ],
          ),

          const SizedBox(height: 20),

          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  /// TAB BAR
                  Container(
                    decoration: BoxDecoration(
                      color: colors(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TabBar(
                      indicatorColor: AppColors.kDarkGreenColor,
                      labelColor: AppColors.kDarkGreenColor,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                          icon: Icon(Icons.pie_chart_outline),
                          text: language.pieChart,
                        ),
                        Tab(
                          icon: Icon(Icons.bar_chart),
                          text: language.barChart,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// TAB CONTENT
                  Expanded(
                    child: TabBarView(
                      children: [
                        /// PIE CHART
                        _pieChart(completedCount, pendingCount, context),

                        /// BAR CHART
                        _barChart(completedPerMonth, pendingPerMonth, context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _statusCard(
  String title,
  String value,
  IconData icon,
  Color color,
  BuildContext context,
) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: colors(context).cardColor,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 28),

        const SizedBox(width: 8),

        /// Use Expanded here to allow text to wrap
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                title,
                style: const TextStyle(fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _pieChart(int completed, int pending, BuildContext context) {
  return Container(
    height: 200,
    padding: const EdgeInsets.all(20),

    decoration: BoxDecoration(
      color: colors(context).cardColor,
      borderRadius: BorderRadius.circular(14),

      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),

    child: Column(
      children: [
        Text(
          language.taskStatus,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 0.9),
            duration: const Duration(seconds: 2),

            builder: (context, value, child) {
              return PieChart(
                PieChartData(
                  sectionsSpace: 3,
                  centerSpaceRadius: 0,

                  sections: [
                    PieChartSectionData(
                      value: completed * value,
                      color: Colors.green,
                      radius: 90,
                      title: "${language.completed}\n$completed",
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      titlePositionPercentageOffset: 0.6,
                    ),

                    PieChartSectionData(
                      value: pending * value,
                      color: Colors.orange,
                      radius: 90,
                      title: "${language.pending}\n$pending",
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      titlePositionPercentageOffset: 0.6,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget _barChart(
  Map<int, int> completed,
  Map<int, int> pending,
  BuildContext context,
) {
  return Container(
    height: 330,
    padding: const EdgeInsets.all(20),

    decoration: BoxDecoration(
      color: colors(context).cardColor,
      borderRadius: BorderRadius.circular(14),

      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),

    child: Column(
      children: [
        Text(
          language.tasksPerMonthChartTitle,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        Expanded(
          child: BarChart(
            BarChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                horizontalInterval: 1,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey.withOpacity(0.3),
                    strokeWidth: 1,
                  );
                },
              ),

              borderData: FlBorderData(
                show: true,
                border: const Border(left: BorderSide(), bottom: BorderSide()),
              ),

              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),

                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),

                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,

                    getTitlesWidget: (value, meta) {
                      if (value % 1 != 0) {
                        return Container();
                      }
                      return Text(value.toInt().toString());
                    },
                  ),
                ),
              ),

              barGroups: List.generate(12, (index) {
                int month = index + 1;

                return BarChartGroupData(
                  x: month,
                  barsSpace: 4,
                  barRods: [
                    BarChartRodData(
                      toY: (completed[month] ?? 0).toDouble(),
                      width: 12,
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),

                    BarChartRodData(
                      toY: (pending[month] ?? 0).toDouble(),
                      width: 12,
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    ),
  );
}
