import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:meta/meta.dart';
import 'package:task_management_system/application/tasks/model/task_model.dart';
import 'package:task_management_system/application/tasks/repository/task_repository.dart';

import '../../../configure_di.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksState.initial()) {
    on<GetTasksEvent>(_onGetTasks);
    on<AddTaskEvent>(_onAddTask);
    on<EditTaskEvent>(_onEditTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  Future<void> _onGetTasks(
    GetTasksEvent event,
    Emitter<TasksState> emit,
  ) async {
    emit(state.copyWith(status: TaskState.loading, isLoading: true));
    EasyLoading.show();

    try {
      final tasks = await getIt<TaskRepo>().getTasks();

      emit(
        state.copyWith(
          status: TaskState.success,
          tasks: tasks,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: TaskState.failure, isLoading: false));
      EasyLoading.dismiss();
    }
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TasksState> emit) async {
    emit(state.copyWith(status: TaskState.loading, isLoading: true));
    EasyLoading.show();

    try {
      await getIt<TaskRepo>().addTask(
        name: event.name,
        description: event.description,
        status: event.status,
      );

      emit(state.copyWith(status: TaskState.success, isLoading: false));
    } catch (e) {
      emit(state.copyWith(status: TaskState.failure, isLoading: false));
      EasyLoading.dismiss();
    }
  }

  Future<void> _onEditTask(
    EditTaskEvent event,
    Emitter<TasksState> emit,
  ) async {
    emit(state.copyWith(status: TaskState.loading, isLoading: true));
    EasyLoading.show();

    try {
      await getIt<TaskRepo>().editTask(
        id: event.id,
        name: event.name,
        description: event.description,
        status: event.status,
      );

      emit(state.copyWith(status: TaskState.success, isLoading: false));
    } catch (e) {
      emit(state.copyWith(status: TaskState.failure, isLoading: false));
      EasyLoading.dismiss();
    }
  }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TasksState> emit,
  ) async {
    emit(state.copyWith(status: TaskState.loading, isLoading: true));
    EasyLoading.show();

    try {
      await getIt<TaskRepo>().deleteTask(id: event.id);

      emit(state.copyWith(status: TaskState.success, isLoading: false));
    } catch (e) {
      emit(state.copyWith(status: TaskState.failure, isLoading: false));
      EasyLoading.dismiss();
      rethrow;
    } finally {
      EasyLoading.dismiss();
    }
  }
}
