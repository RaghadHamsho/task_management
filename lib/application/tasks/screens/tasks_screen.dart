import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:task_management_system/core/utils/functions.dart';
import 'package:task_management_system/core/widgets/button_widget.dart';
import 'package:task_management_system/main.dart';

import '../../../app_theme.dart' hide AppColors;
import '../../../core/values/values.dart';
import '../../auth/widgets/text_field_widget.dart';
import '../../home/screens/home_web_screen.dart';
import '../model/task_model.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String selectedStatus = language.allStatus;

  List<String> statuses = [
    language.allStatus,
    language.completed,
    language.pending,
  ];

  /// FILTER TASKS
  List<TaskModel> get filteredTasks {
    if (selectedStatus == language.allStatus) {
      return taskList;
    }

    return taskList.where((task) => task.status == selectedStatus).toList();
  }

  /// ADD TASK
  void showAddTaskDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController descController = TextEditingController();

    String status = language.pending;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: colors(context).cardColor,

              title: Text(
                language.addNewTask,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colors(context).textColor,
                ),
              ),

              content: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(language.taskName),
                    const SizedBox(height: 5),

                    CustomTextField(
                      controller: nameController,
                      hint: language.enterTaskName,
                    ),

                    const SizedBox(height: 15),

                    Text(language.taskDescription),
                    const SizedBox(height: 5),

                    CustomTextField(
                      controller: descController,
                      hint: language.enterTaskDescription,
                    ),

                    const SizedBox(height: 15),

                    Text(language.taskStatus),
                    const SizedBox(height: 5),

                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        value: status,

                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            color: colors(context).cardColor,
                          ),
                        ),
                        items: statuses.map((item) {
                          return DropdownMenuItem(

                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 14,
                                color: colors(context).textColor,
                              ),
                            ),
                          );
                        }).toList(),

                        onChanged: (value) {
                          setStateDialog(() {
                            status = value!;
                          });
                        },

                        buttonStyleData: ButtonStyleData(
                          height: 45,
                          width: double.infinity,
                          padding: EdgeInsetsGeometry.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              actions: [
                SizedBox(
                  width: 100,
                  child: CustomButton(
                    text: language.cancel,
                    color: Colors.transparent,
                    textColor: colors(context).textColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: CustomButton(
                    text: language.save,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.kDarkGreenColor,
                        AppColors.kLightGreenColor,
                      ],
                    ),
                    onPressed: () {
                      if (nameController.text.isEmpty) return;

                      setState(() {
                        taskList.add(
                          TaskModel(
                            name: nameController.text,
                            description: descController.text,
                            createDate: DateTime.now(),
                            status: status,
                          ),
                        );
                      });

                      Navigator.pop(context);
                    },
                  ),
                ),


              ],
            );
          },
        );
      },
    );
  }

  /// EDIT TASK
  void showEditTaskDialog(int index) {
    final task = taskList[index];
    TextEditingController nameController = TextEditingController(
      text: task.name,
    );
    TextEditingController descController = TextEditingController(
      text: task.description,
    );
    String status = task.status;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            List<String> statuses = [
              language.allStatus,
              language.completed,
              language.pending,
            ];
            return AlertDialog(
              backgroundColor: colors(context).cardColor,
              title: Padding(
                padding: const EdgeInsets.only(bottom: 9.0),
                child: Text(
                  language.editTask,
                  style: TextStyle(
                    fontSize: 16,
                    color: colors(context).textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              content: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Task Name
                    Text(
                      language.taskName,
                      style: TextStyle(
                        fontSize: 14,
                        color: colors(context).textColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    CustomTextField(
                      controller: nameController,
                      hint: language.enterTaskName,
                    ),
                    const SizedBox(height: 15),

                    // Description
                    Text(
                      language.taskDescription,
                      style: TextStyle(
                        fontSize: 14,
                        color: colors(context).textColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    CustomTextField(
                      controller: descController,
                      hint: language.enterTaskDescription,
                    ),
                    const SizedBox(height: 15),

                    // Status
                    Text(
                      language.taskStatus,
                      style: TextStyle(
                        fontSize: 14,
                        color: colors(context).textColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        value: status,
                        items: statuses
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colors(context).textColor,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setStateDialog(() {
                            status = value!;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 50,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(Icons.keyboard_arrow_down),
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colors(context).backgroundColor,
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(height: 40),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                // Cancel
                SizedBox(
                  width: 100,
                  child: CustomButton(
                    color: Colors.transparent,
                    textColor: colors(context).textColor,
                    text: language.cancel,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                // Save
                SizedBox(
                  width: 100,
                  child: CustomButton(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.kDarkGreenColor,
                        AppColors.kLightGreenColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    text: language.save,
                    onPressed: () {
                      setState(() {
                        taskList[index] = TaskModel(
                          name: nameController.text,
                          description: descController.text,
                          createDate: task.createDate,
                          status: status,
                        );
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// DELETE TASK
  void showDeleteTaskDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: colors(context).cardColor,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              language.deleteTask,
              style: TextStyle(
                fontSize: 16,
                color: colors(context).textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        language.deleteConfirmation,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: colors(context).textColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  language.deleteConfirmationMessage,
                  style: TextStyle(
                    fontSize: 14,
                    color: colors(context).textColor,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            // Cancel
            SizedBox(
              width: 100,
              child: CustomButton(
                color: Colors.transparent,
                text: language.cancel,
                textColor: colors(context).textColor,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            // Delete
            SizedBox(
              width: 100,
              child: CustomButton(
                color: Colors.red,
                text: language.delete,
                onPressed: () {
                  setState(() {
                    taskList.removeAt(index);
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SideMenuPage(
      selectedPage: 0,
      pageTitle: "",
      child: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              language.taskManagement,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            /// CARD
            Card(
              elevation: 5,
              color: colors(context).cardColor,

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [
                    /// FILTER ROW
                    Row(
                      children: [
                        Text(language.filterByStatus),

                        const SizedBox(width: 10),

                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            value: selectedStatus,
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                color: colors(context).cardColor,
                              ),
                            ),
                            items: statuses.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colors(context).textColor,
                                  ),
                                ),
                              );
                            }).toList(),

                            onChanged: (value) {
                              setState(() {
                                selectedStatus = value!;
                              });
                            },

                            buttonStyleData: ButtonStyleData(
                              height: 40,
                              padding: EdgeInsetsGeometry.symmetric(
                                horizontal: 4,
                              ),
                              width: 160,
                              decoration: BoxDecoration(
                                color: colors(context).cardColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),

                        SizedBox(
                          width: 150,
                          child: CustomButton(
                            text: language.addNewTask,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.kDarkGreenColor,
                                AppColors.kLightGreenColor,
                              ],
                            ),
                            onPressed: showAddTaskDialog,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Column(
                      children: [
                        /// HEADER
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.kDarkGreenColor,
                                AppColors.kLightGreenColor,
                              ],
                            ),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(8),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  language.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 3,
                                child: Text(
                                  language.description,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: Text(
                                  language.createDate,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: Text(
                                  language.status,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: Text(
                                  language.actions,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// DATA LIST
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2.1,
                          child: ListView.separated(
                            itemCount: filteredTasks.length,

                            separatorBuilder: (_, __) =>
                                Divider(color: Colors.grey.shade300),

                            itemBuilder: (context, index) {
                              final task = filteredTasks[index];

                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    task.status =
                                        task.status == language.completed
                                        ? language.pending
                                        : language.completed;
                                  });
                                },

                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 8,
                                  ),

                                  child: Row(
                                    children: [
                                      /// NAME
                                      Expanded(
                                        flex: 2,
                                        child: taskNameWidget(task, context),
                                      ),

                                      /// DESCRIPTION
                                      Expanded(
                                        flex: 3,
                                        child: Text(task.description),
                                      ),

                                      /// DATE
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          Functions.getFormatDate(
                                            task.createDate,
                                          ),
                                        ),
                                      ),

                                      /// STATUS
                                      Expanded(
                                        flex: 2,
                                        child: statusWidget(task.status),
                                      ),

                                      /// ACTIONS
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.edit_outlined,
                                                color: Colors.blue,
                                              ),
                                              onPressed: () {
                                                showEditTaskDialog(index);
                                              },
                                            ),

                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete_outline,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                showDeleteTaskDialog(index);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// STATUS WIDGET

Widget statusWidget(String status) {
  bool isCompleted = status == language.completed;

  return Row(
    children: [
      Icon(
        Icons.circle,
        size: 10,
        color: isCompleted ? Colors.green : Colors.orange,
      ),

      const SizedBox(width: 6),

      Text(
        status,
        style: TextStyle(
          color: isCompleted ? Colors.green : Colors.orange,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

/// TASK NAME WIDGET

Widget taskNameWidget(TaskModel task, BuildContext context) {
  bool isCompleted = task.status == language.completed;
  bool isPending = task.status == language.pending;

  return Row(
    children: [
      if (isCompleted) const Icon(Icons.check_circle, color: Colors.green),

      if (isPending)
        Icon(Icons.circle_outlined, color: colors(context).textColor),

      const SizedBox(width: 6),

      Expanded(
        child: Text(
          task.name,
          style: TextStyle(
            decoration: isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
      ),
    ],
  );
}
