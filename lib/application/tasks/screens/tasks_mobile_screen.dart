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
  List<String> statuses = ["all Status", "Completed", "Pending"];
  String selectedStatus = "all Status";

  /// FILTER TASKS
  List<TaskModel> get filteredTasks {
    if (selectedStatus == "all Status") return taskList;
    return taskList.where((task) => getTaskStatusText(task.status) == selectedStatus).toList();
  }

  /// ================= ADD TASK DIALOG =================
  void showAddTaskDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController descController = TextEditingController();

    TaskStatus status = TaskStatus.pending; // استخدم enum بدلاً من النص

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
                    DropdownButton2<TaskStatus>(
                      value: status,
                      items: TaskStatus.values.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item == TaskStatus.pending ? "Pending" : "Completed",
                            style: TextStyle(fontSize: 14, color: colors(context).textColor),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {         // <-- check null first
                          setStateDialog(() {
                            status = value;
                          });
                        }
                      },
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
                    onPressed: () => Navigator.pop(context),
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
                            status: status, // هنا نخزن enum
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

  /// ================= EDIT TASK DIALOG =================
  void showEditTaskDialog(int index) {
    final task = taskList[index];
    TextEditingController nameController = TextEditingController(
      text: task.name,
    );
    TextEditingController descController = TextEditingController(
      text: task.description,
    );
    TaskStatus status = task.status; // استخدم enum هنا

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
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
                    DropdownButton2<TaskStatus>(
                      value: status,
                      items: TaskStatus.values.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item == TaskStatus.pending ? "Pending" : "Completed",
                            style: TextStyle(fontSize: 14, color: colors(context).textColor),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {         // <-- check null first
                          setStateDialog(() {
                            status = value;
                          });
                        }
                      },
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
                          status: status, // هنا نخزن enum
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


  @override
  Widget build(BuildContext context) {


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


                return InkWell(
                  onTap: () {

                      setState(() {
                        task.status =
                        task.status == TaskStatus.completed
                            ? TaskStatus.pending
                            : TaskStatus.completed;
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(child: taskNameWidget(task, context)),
                              statusWidget(task.status)
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

Widget statusWidget(TaskStatus status) {
  bool isCompleted = status == TaskStatus.completed;

  return Row(
    children: [
      Icon(Icons.circle, size: 10, color: isCompleted ? Colors.green : Colors.orange),
      const SizedBox(width: 6),
      Text(
        getTaskStatusText(status),
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
  bool isCompleted = task.status == TaskStatus.completed;

  return Row(
    children: [
      Icon(
        isCompleted ? Icons.check_circle : Icons.circle_outlined,
        color: isCompleted ? Colors.green : colors(context).textColor,
        size: 18,
      ),
      const SizedBox(width: 6),
      Flexible(
        child: Text(
          task.name,
          style: TextStyle(
            decoration:
            isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}

String getTaskStatusText(TaskStatus status) {
  switch (status) {
    case TaskStatus.pending:
      return "Pending";
    case TaskStatus.completed:
      return "Completed";
  }

}