import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/app/core/utils/extension.dart';
import 'package:todolist/app/modules/home/controller/home_controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  DoingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doneTodos.isEmpty && homeCtrl.doingTodos.isEmpty
          ? Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.0.wp),
                  child: Image.asset(
                    "assets/emptyTask.jpg",
                    fit: BoxFit.cover,
                    width: 65.0.wp,
                  ),
                ),
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...homeCtrl.doingTodos
                    .map(
                      (element) => Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 3.0.wp,
                          horizontal: 9.0.wp,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                fillColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.grey,
                                ),
                                value: element["done"],
                                onChanged: (value) {
                                  homeCtrl.doneTodo(
                                    element["title"],
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                              child: Text(
                                element["title"],
                                style: TextStyle(
                                  fontSize: 14.0.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                if (homeCtrl.doingTodos.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                    child: const Divider(
                      thickness: .5,
                      color: Colors.black54,
                    ),
                  ),
              ],
            ),
    );
  }
}
