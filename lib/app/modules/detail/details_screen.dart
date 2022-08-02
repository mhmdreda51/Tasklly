import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todolist/app/core/utils/extension.dart';
import 'package:todolist/app/modules/detail/Widgets/done_list.dart';
import 'package:todolist/app/modules/home/controller/home_controller.dart';

import '../../core/values/colors.dart';
import 'Widgets/doing_list.dart';

class DetailsScreen extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value!;
    var color = HexColor.fromHex(task.color);
    var icon = task.icon;
    var title = task.title;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: darkGray,
        appBar: AppBar(
          backgroundColor: darkGray,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Get.back();
              homeCtrl.updateTodos();
              homeCtrl.changeTask(null);
              homeCtrl.editCtrl.clear();
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
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
              padding: const EdgeInsets.only(top: 40),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                    child: Row(
                      children: [
                        Icon(
                          IconData(
                            icon,
                            fontFamily: "MaterialIcons",
                          ),
                          color: color,
                          size: 30,
                        ),
                        SizedBox(width: 3.0.wp),
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    var totalTodos =
                        homeCtrl.doingTodos.length + homeCtrl.doneTodos.length;
                    return Padding(
                      padding: EdgeInsets.only(
                        top: 3.0.wp,
                        left: 20.0.wp,
                        right: 20.0.wp,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "$totalTodos Tasks",
                            style: TextStyle(
                              fontSize: 12.0.sp,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 3.0.wp),
                          Expanded(
                            child: StepProgressIndicator(
                              totalSteps: totalTodos == 0 ? 1 : totalTodos,
                              currentStep: homeCtrl.doneTodos.length,
                              size: 5,
                              padding: 0,
                              selectedGradientColor: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [color.withOpacity(0.5), color],
                              ),
                              unselectedGradientColor: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.grey[100]!, Colors.grey[100]!],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0.wp,
                      vertical: 2.0.wp,
                    ),
                    child: TextFormField(
                      controller: homeCtrl.editCtrl,
                      autofocus: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please Enter Your Todo Item";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]!),
                        ),
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.check_box_outline_blank,
                            color: darkGray.withOpacity(.5),
                          ),
                          onPressed: () {},
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.done,
                            color: darkGray,
                          ),
                          onPressed: () {
                            if (homeCtrl.formKey.currentState!.validate()) {
                              var success =
                                  homeCtrl.addTodo(homeCtrl.editCtrl.text);
                              if (success) {
                                EasyLoading.showSuccess(
                                  "Todo Item Added Successfully",
                                );
                              } else {
                                EasyLoading.showError(
                                    "Todo Item Already Exist");
                              }
                              homeCtrl.editCtrl.clear();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  DoingList(),
                  DoneList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
