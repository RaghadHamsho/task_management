part of 'tasks_bloc.dart';

enum TaskState { initial, loading, success, failure , forgetSuccess,forgetFailure }
class TasksState {
  final TaskState status;
  final List<TaskModel>? tasks;
  final String? message;
  final bool isLoading;

  const TasksState({
    this.status = TaskState.initial,
    this.tasks,
    this.message,
    this.isLoading = false,
  });

  factory TasksState.initial() => const TasksState();

  TasksState copyWith({
    TaskState? status,
    final List<TaskModel>? tasks,
    String? message,
    bool? isLoading,
  }) {
    return TasksState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}