import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todolist/app/modules/home/controller/home_controller.dart';

import '../../../core/values/colors.dart';
import '../../../data/models/task.dart';
import '../widgets/add_dialog.dart';

class MainFloatingButton extends StatelessWidget {
  const MainFloatingButton({Key? key, required this.controller})
      : super(key: key);
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return DragTarget<Task>(
      onAccept: (Task task) {
        controller.deleteTask(task);
        EasyLoading.showSuccess("Delete Success");
      },
      builder: (_, __, ___) {
        return Obx(
          () => FloatingActionButton(
            backgroundColor: controller.deleting.value ? Colors.red : darkGray,
            onPressed: () {
              if (controller.tasks.isNotEmpty) {
                Get.to(AddDialog(), transition: Transition.downToUp);
              } else {
                EasyLoading.showInfo("Please Create Your Task Type");
              }
            },
            child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
          ),
        );
      },
    );
  }
}
