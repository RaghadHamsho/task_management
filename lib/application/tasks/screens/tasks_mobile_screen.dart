import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management_system/core/utils/functions.dart';
import 'package:task_management_system/core/widgets/button_widget.dart';

import '../../../app_theme.dart' hide AppColors;
import '../../../core/values/values.dart';
import '../../../main.dart';
import '../../auth/widgets/text_field_widget.dart';
import '../model/task_model.dart';

class TasksMobileScreen extends StatefulWidget {
  const TasksMobileScreen({super.key});

  @override
  State<TasksMobileScreen> createState() => _TasksMobileScreenState();
}

class _TasksMobileScreenState extends State<TasksMobileScreen> {
  String selectedStatus = language.allStatus;

  /// ================= ADD TASK DIALOG =================
  void showAddTaskDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController descController = TextEditingController();
    String status = language.pending;

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
                padding: const EdgeInsets.only(bottom: 9),
                child: Text(
                  language.addNewTask,
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
                    Text(language.taskName,
                        style: TextStyle(
                            fontSize: 14, color: colors(context).textColor)),
                    const SizedBox(height: 3),
                    CustomTextField(
                      controller: nameController,
                      hint: language.enterTaskName,
                    ),
                    const SizedBox(height: 15),

                    // Description
                    Text(language.taskDescription,
                        style: TextStyle(
                            fontSize: 14, color: colors(context).textColor)),
                    const SizedBox(height: 3),
                    CustomTextField(
                      controller: descController,
                      hint: language.enterTaskDescription,
                    ),
                    const SizedBox(height: 15),

                    // Status
                    Text(language.taskStatus,
                        style: TextStyle(
                            fontSize: 14, color: colors(context).textColor)),
                    const SizedBox(height: 3),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        value: status,
                        items: statuses
                            .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: colors(context).textColor)),
                        ))
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
                    text: language.cancel,
                    textColor: colors(context).textColor,
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
                      if (nameController.text.isEmpty) return;

                      setState(() {
                        taskList.add(TaskModel(
                          name: nameController.text,
                          description: descController.text,
                          createDate: DateTime.now(),
                          status: status,
                        ));
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

  /// ================= EDIT TASK DIALOG =================
  void showEditTaskDialog(int index) {
    final task = taskList[index];
    TextEditingController nameController =
    TextEditingController(text: task.name);
    TextEditingController descController =
    TextEditingController(text: task.description);
    String status = task.status;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateDialog) {
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
                    fontWeight: FontWeight.bold),
              ),
            ),
            content: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Task Name
                  Text(language.taskName,
                      style: TextStyle(
                          fontSize: 14, color: colors(context).textColor)),
                  const SizedBox(height: 3),
                  CustomTextField(
                    controller: nameController,
                    hint: language.enterTaskName,
                  ),
                  const SizedBox(height: 15),

                  // Description
                  Text(language.taskDescription,
                      style: TextStyle(
                          fontSize: 14, color: colors(context).textColor)),
                  const SizedBox(height: 3),
                  CustomTextField(
                    controller: descController,
                    hint: language.enterTaskDescription,
                  ),
                  const SizedBox(height: 15),

                  // Status
                  Text(language.taskStatus,
                      style: TextStyle(
                          fontSize: 14, color: colors(context).textColor)),
                  const SizedBox(height: 3),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      value: status,
                      items: statuses
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item,
                            style: TextStyle(
                                fontSize: 14,
                                color: colors(context).textColor)),
                      ))
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
        });
      },
    );
  }

  /// ================= DELETE TASK DIALOG =================
  void showDeleteTaskDialog(int index) {
    final task = taskList[index];

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
                  fontWeight: FontWeight.bold),
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
                            color: colors(context).textColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  language.deleteConfirmationMessage,
                  style: TextStyle(
                      fontSize: 14, color: colors(context).textColor),
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

  /// ================= FILTERED TASKS =================
  List<TaskModel> get filteredTasks {
    if (selectedStatus == language.allStatus) return taskList;

    return taskList
        .where((task) => task.status == selectedStatus)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<String> statuses = [
      language.allStatus,
      language.completed,
      language.pending,
    ];

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter & Add Row
          Row(
            children: [
              // Filter
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(language.filterByStatus,
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500, color: colors(context).textColor)),
                  const SizedBox(height: 4),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      value: selectedStatus,
                      hint: Text(language.selectStatus,
                          style: TextStyle(
                              fontSize: 14, color: colors(context).textColor)),
                      items: statuses
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item,
                            style: TextStyle(
                                fontSize: 12, color: colors(context).textColor)),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value!;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 40,
                        width: 160,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
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
              Spacer(),
              // Add Task Button
              Padding(
                padding: const EdgeInsets.only(top: 17.0),
                child: SizedBox(
                  width: 120,
                  child: CustomButton(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.kDarkGreenColor,
                        AppColors.kLightGreenColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    text: language.addNewTask,
                    onPressed: showAddTaskDialog,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Task List
          Expanded(
            child: ListView.separated(
              itemCount: filteredTasks.length,
              padding: const EdgeInsets.all(8),
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final task = filteredTasks[index];
                bool isCompleted = task.status == language.completed;
                bool isPending = task.status == language.pending;

                return InkWell(
                  onTap: () {
                    setState(() {
                      task.status = task.status == language.pending
                          ? language.completed
                          : language.pending;
                    });
                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: colors(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Task Name Row
                          Row(
                            children: [
                              if (isCompleted)
                                const Icon(Icons.check_circle,
                                    color: Colors.green, size: 24),
                              if (isPending)
                                Icon(Icons.circle_outlined,
                                    size: 24, color: colors(context).textColor),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  task.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    decoration: isCompleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    color: isCompleted
                                        ? Colors.grey
                                        : colors(context).textColor,
                                  ),
                                ),
                              ),
                              statusWidget(task.status ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Description
                          Text(
                            task.description,
                            maxLines: 3,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey.shade700),
                          ),
                          const SizedBox(height: 10),

                          // Date & Actions
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 16),
                              const SizedBox(width: 6),
                              Text(
                                Functions.getFormatDate(task.createDate),
                                style: const TextStyle(fontSize: 13),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () => showEditTaskDialog(index),
                                icon: const Icon(Icons.edit_outlined,
                                    color: Colors.blue),
                              ),
                              IconButton(
                                onPressed: () => showDeleteTaskDialog(index),
                                icon: const Icon(Icons.delete_outline,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// ================= HELPER WIDGETS =================
  Widget cellWidget(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Text(text,
          style: TextStyle(color: colors(context).textColor, fontSize: 14)),
    );
  }
}

/// Status Widget
Widget statusWidget(String status) {
  Color statusColor;

  if (status == language.completed) {
    statusColor = Colors.green; // مكتمل
  } else if (status == language.pending) {
    statusColor = Colors.orange; // معلق
  } else {
    statusColor = Colors.grey; // أي حالة أخرى
  }

  return Row(
    children: [
      Icon(
        Icons.circle,
        size: 10,
        color: statusColor,
      ),
      const SizedBox(width: 6),
      Text(
        status,
        style: TextStyle(
          fontSize: 14,
          color: statusColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

/// Task Name Widget
Widget taskNameWidget(TaskModel task, BuildContext context) {
  bool isCompleted = task.status == language.completed;
  bool isPending = task.status == language.pending;

  return Row(
    children: [
      if (isCompleted) const Icon(Icons.check_circle, color: Colors.green, size: 18),
      if (isPending) Icon(Icons.circle_outlined, size: 24, color: colors(context).textColor),
      if (isCompleted || isPending) const SizedBox(width: 6),
      Expanded(
        child: Text(
          task.name,
          style: TextStyle(
            fontSize: 14,
            decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
            color: isCompleted ? Colors.grey : colors(context).textColor,
          ),
        ),
      ),
    ],
  );
}