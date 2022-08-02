import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todolist/app/core/utils/extension.dart';
import 'package:todolist/app/core/values/colors.dart';
import 'package:todolist/app/modules/home/controller/home_controller.dart';

import 'Widgets/report_status_row.dart';

class ReportScreen extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGray,
      appBar: AppBar(
        backgroundColor: darkGray,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Reports",
          style: TextStyle(color: Colors.white, fontSize: 14.0.sp),
        ),
      ),
      body: Obx(() {
        var createdTasks = homeCtrl.getTotalTask();
        var completedTasks = homeCtrl.getTotalDoneTask();
        var liveTasks = createdTasks - completedTasks;
        var percent = (completedTasks / createdTasks * 100).toStringAsFixed(0);
        return Padding(
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
            padding: const EdgeInsets.only(top: 40),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReportStatusRow(
                      color: teal,
                      title: "Live Tasks",
                      number: liveTasks,
                    ),
                    ReportStatusRow(
                      number: completedTasks,
                      color: Colors.orange,
                      title: "Completed",
                    ),
                    ReportStatusRow(
                      color: Colors.blue,
                      title: "Created",
                      number: createdTasks,
                    ),
                  ],
                ),
                SizedBox(height: 30.0.wp),
                UnconstrainedBox(
                  child: SizedBox(
                    height: 70.0.wp,
                    width: 70.0.wp,
                    child: CircularStepProgressIndicator(
                      totalSteps: createdTasks == 0 ? 1 : createdTasks,
                      currentStep: completedTasks,
                      stepSize: 20,
                      selectedColor: teal,
                      unselectedColor: Colors.grey[200],
                      padding: 0,
                      width: 150,
                      height: 150,
                      roundedCap: (_, __) => true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${createdTasks == 0 ? 0 : percent} %",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0.sp,
                            ),
                          ),
                          SizedBox(height: 1.5.wp),
                          Text(
                            "Efficiency",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
