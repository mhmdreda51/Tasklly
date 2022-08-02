import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/app/core/utils/extension.dart';
import 'package:todolist/app/modules/home/controller/home_controller.dart';

import '../../../data/models/task.dart';
import '../widgets/add_card.dart';
import '../widgets/task_card.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({Key? key, required this.controller}) : super(key: key);
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                height: Get.height,
                width: Get.width,
                padding: EdgeInsets.only(top: 6.0.wp, bottom: 55.0.wp),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    ...controller.tasks
                        .map(
                          (e) => LongPressDraggable(
                            data: e,
                            onDragStarted: () =>
                                controller.changeDeleting(true),
                            onDraggableCanceled: (_, __) =>
                                controller.changeDeleting(false),
                            onDragEnd: (_) => controller.changeDeleting(false),
                            feedback: Opacity(
                              opacity: 0.8,
                              child: TaskCard(
                                task: Task(
                                  color: e.color,
                                  title: e.title,
                                  icon: e.icon,
                                ),
                              ),
                            ),
                            child: TaskCard(
                              task: Task(
                                color: e.color,
                                title: e.title,
                                icon: e.icon,
                                todos: e.todos,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    AddCard(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
