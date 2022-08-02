import 'package:get/get.dart';
import 'package:todolist/app/data/providers/task/provider.dart';
import 'package:todolist/app/data/services/storage/repository.dart';
import 'package:todolist/app/modules/home/controller/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
