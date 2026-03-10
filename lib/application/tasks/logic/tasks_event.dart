part of 'tasks_bloc.dart';

@immutable
abstract class TasksEvent {}


class GetTasksEvent extends TasksEvent {
  GetTasksEvent();
}
class AddTaskEvent extends TasksEvent {
  final String? name;
  final String? description;
  final String?  status;

  AddTaskEvent([this.name , this.description , this.status]);
}
class EditTaskEvent extends TasksEvent {
  final int id ;
  final String? name;
  final String? description;
  final String?  status;

  EditTaskEvent(this.id,[  this.name , this.description , this.status]);
}
class DeleteTaskEvent extends TasksEvent {
  final int id ;
  DeleteTaskEvent(this.id);
}