import 'package:flutter/cupertino.dart';
import 'package:task_management_system/main.dart';

import '../../../app_theme.dart';
import '../../home/screens/home_web_screen.dart';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../tasks/model/task_model.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int completedCount = taskList.where((t) => t.status == language.completed).length;

    int pendingCount = taskList.where((t) => t.status == language.pending).length;

    int totalCount = taskList.length;
    Map<int, int> completedPerMonth = {};
    double completionRate = totalCount == 0
        ? 0
        : (completedCount / totalCount) * 100;

    /// monthly data

    Map<int, int> pendingPerMonth = {};

    for (var task in taskList) {
      int month = task.createDate.month;

      if (task.status == language.completed) {
        completedPerMonth[month] = (completedPerMonth[month] ?? 0) + 1;
      } else {
        pendingPerMonth[month] = (pendingPerMonth[month] ?? 0) + 1;
      }
    }
    return SideMenuPage(
      selectedPage: 1,
      pageTitle: "",
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TITLE
               Text(
                language.dashboardTitle,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),

               Text(
                language.overviewTasks,
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 20),

              /// STATUS CARDS - responsive
              /// STATUS CARDS - all in one row
              Row(
                children: [
                  Expanded(
                    child: _statusCard(
                      language.allTasks,
                      totalCount.toString(),
                      Icons.task_alt,
                      Colors.blue,
                      context,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: _statusCard(
                      language.completed,
                      completedCount.toString(),
                      Icons.check_circle_outline,
                      Colors.green,
                      context,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: _statusCard(
                      language.pending,
                      pendingCount.toString(),
                      Icons.timelapse,
                      Colors.orange,
                      context,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: _statusCard(
                    language.completionRate,
                      "${completionRate.toStringAsFixed(0)}%",
                      Icons.percent,
                      Colors.purple,
                      context,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// CHARTS ROW
              Row(
                children: [
                  /// PIE CHART
                  Expanded(
                    child: _pieChart(completedCount, pendingCount, context),
                  ),

                  const SizedBox(width: 20),

                  /// BAR CHART
                  Expanded(
                    child: _barChart(
                      completedPerMonth,
                      pendingPerMonth,
                      context,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
        Icon(icon, color: color, size: 32),

        const SizedBox(width: 12),

        /// Use Expanded here to allow text to wrap
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
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
         language.taskStatus,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      radius: 110,
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
                      radius: 110,
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
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _legendItem(Colors.green, language.completed),

            const SizedBox(width: 20),

            _legendItem(Colors.orange, language.pending),
          ],
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        Expanded(
          child: BarChart(
            BarChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
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

Widget _legendItem(Color color, String label) {
  return Row(
    children: [
      Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),

      const SizedBox(width: 6),

      Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
    ],
  );
}
