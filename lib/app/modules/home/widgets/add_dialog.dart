import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todolist/app/core/utils/extension.dart';
import 'package:todolist/app/modules/home/controller/home_controller.dart';

import '../../../core/values/colors.dart';

class AddDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: darkGray,
        appBar: AppBar(
          backgroundColor: darkGray,
          elevation: 0.0,
          leading: Padding(
            padding: EdgeInsets.only(left: 2.0.wp),
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Get.back();
                homeCtrl.editCtrl.clear();
                homeCtrl.changeTask(null);
              },
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 2.0.wp),
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: Text(
                  "Done",
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (homeCtrl.formKey.currentState!.validate()) {
                    if (homeCtrl.task.value == null) {
                      EasyLoading.showError("Please select task type");
                    } else {
                      var success = homeCtrl.updateTask(
                        homeCtrl.task.value!,
                        homeCtrl.editCtrl.text,
                      );
                      if (success) {
                        EasyLoading.showSuccess("Todo item add success");
                        Get.back();
                        homeCtrl.changeTask(null);
                      } else {
                        EasyLoading.showError("Todo item already exist");
                      }
                      homeCtrl.editCtrl.clear();
                    }
                  }
                },
              ),
            ),
          ],
        ),
        body: Form(
          key: homeCtrl.formKey,
          child: Padding(
            padding: EdgeInsets.only(top: 5.0.wp),
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
              padding: EdgeInsets.only(top: 5.0.wp),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                    child: Text(
                      "New Task",
                      style: TextStyle(
                          fontSize: 20.0.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                    child: TextFormField(
                      controller: homeCtrl.editCtrl,
                      autofocus: true,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]!),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your todo item";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5.0.wp,
                      bottom: 2.0.wp,
                      left: 5.0.wp,
                    ),
                    child: Text(
                      "Add To",
                      style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                    ),
                  ),
                  ...homeCtrl.tasks
                      .map(
                        (element) => Obx(() {
                          return InkWell(
                            onTap: () => homeCtrl.changeTask(element),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.0.wp,
                                vertical: 3.0.wp,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        IconData(
                                          element.icon,
                                          fontFamily: "MaterialIcons",
                                        ),
                                        color: HexColor.fromHex(element.color),
                                      ),
                                      SizedBox(width: 3.0.wp),
                                      Text(
                                        element.title,
                                        style: TextStyle(
                                          fontSize: 12.0.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (homeCtrl.task.value == element)
                                    const Icon(
                                      Icons.check,
                                      color: Colors.blue,
                                    ),
                                ],
                              ),
                            ),
                          );
                        }),
                      )
                      .toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
