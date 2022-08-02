import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/app/core/utils/extension.dart';
import 'package:todolist/app/modules/home/controller/home_controller.dart';

import '../../../core/values/colors.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({Key? key, required this.controller})
      : super(key: key);
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          splashColor: Colors.transparent, highlightColor: Colors.transparent),
      child: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.tapIndex.value,
          onTap: (int index) => controller.changeTapIndex(index),
          selectedItemColor: darkGray,
          unselectedItemColor: darkGray.withOpacity(.3),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(right: 15.0.wp),
                child: const Icon(Icons.apps),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(left: 15.0.wp),
                child: const Icon(Icons.data_usage_outlined),
              ),
              label: "Report",
            ),
          ],
        );
      }),
    );
  }
}
