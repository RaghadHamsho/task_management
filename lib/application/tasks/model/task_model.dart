import '../../../main.dart';

class TaskModel {
  final String name;
  final String description;
  final DateTime createDate;
   TaskStatus status;

  TaskModel({
    required this.name,
    required this.description,
    required this.createDate,
    required this.status,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      createDate: DateTime.parse(json['createDate']),
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'createDate': createDate.toIso8601String(),
      'status': status,
    };
  }
}
List<TaskModel> taskList = [
  TaskModel(
    name: "Design UI",
    description: "Create dashboard layout",
    createDate: DateTime(2026, 3, 12),
    status: TaskStatus.pending, // استخدم اللغة هنا
  ),
  TaskModel(
    name: "Fix Bugs",
    description: "Resolve login bug",
    createDate: DateTime(2026, 3, 10),
    status: TaskStatus.completed, // استخدم اللغة هنا
  ),
  TaskModel(
    name: "API Integration",
    description: "Connect mobile app with backend API",
    createDate: DateTime(2026, 3, 8),
    status: TaskStatus.pending,
  ),
  TaskModel(
    name: "Testing",
    description: "Test all modules before release",
    createDate: DateTime(2026, 3, 5),
    status: TaskStatus.completed,
  ),
];

enum TaskStatus { pending, completed }