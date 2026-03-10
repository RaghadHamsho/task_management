import 'package:task_management_system/application/tasks/model/task_model.dart';

import '../../../core/data/local_data/shared_pref.dart';
import '../../../core/data/new_remote/network_service.dart';
import '../../../core/data/new_remote/response_model.dart';
import '../../../core/values/constant.dart';

abstract class TaskRepo {
  Future<List<TaskModel>> getTasks();

  Future addTask({
    required String? name,
    required String? description,
    required String? status,
  });

  Future editTask({
    required int id,
    required String? name,
    required String? description,
    required String? status,
  });

  Future deleteTask({required int id});
}

class TaskRepoImpl implements TaskRepo {
  NetworkService networkService;

  TaskRepoImpl(this.networkService);

  @override
  Future<List<TaskModel>> getTasks() async {
    ResponseModel responseModel = await networkService.sendRequest(
      'api/tasks',
      method: HttpMethod.get,
      bodyType: BodyType.json,
    );

    return (responseModel.list as List)
        .map((e) => TaskModel.fromJson(e))
        .toList();
  }

  @override
  Future addTask({
    required String? name,
    required String? description,
    required String? status,
  }) async {
    bool done = false;
    ResponseModel responseModel = await networkService.sendRequest(
      'api/task',
      method: HttpMethod.post,
      bodyType: BodyType.json,
      body: {"name": name, "description": description, "status": status},
    );

    if (responseModel.status == 'OK') {
      done = true;
    }

    return done;
  }

  @override
  Future editTask({
    required int id,
    required String? name,
    required String? description,
    required String? status,
  }) async {
    bool done = false;

    ResponseModel responseModel = await networkService.sendRequest(
      'api/task/$id ',
      method: HttpMethod.put,
      bodyType: BodyType.json,
      body: {"name": name, "description": description, "status": status},
    );

    if (responseModel.status == 'OK') {
      done = true;
    }

    return done;
  }

  @override
  Future deleteTask({required int id}) async {
    bool done = false;

    ResponseModel responseModel = await networkService.sendRequest(
      'api/task/$id ',
      method: HttpMethod.delete,
    );

    if (responseModel.status == 'OK') {
      done = true;
    }

    return done;
  }
}
