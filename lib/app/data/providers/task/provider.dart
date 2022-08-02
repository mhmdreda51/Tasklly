import 'dart:convert';

import 'package:get/get.dart';
import 'package:todolist/app/core/utils/keys.dart';
import 'package:todolist/app/data/models/task.dart';
import 'package:todolist/app/data/services/storage/services.dart';

class TaskProvider {
  final _storage = Get.find<StorageServices>();

//   {
//     'tasks':[
//   {
//   'title': 'work',
//   'icon': '#ff123456',
//   'color': oxe123,
//   }
//     ]
// }
  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
