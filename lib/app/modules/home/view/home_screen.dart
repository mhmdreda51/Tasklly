import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/app/core/utils/extension.dart';

import '../../../core/values/colors.dart';
import '../../report/rebort_screen.dart';
import '../Componants/list_view_screen.dart';
import '../Componants/mainfloating_button.dart';
import '../controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: darkGray,
        appBar: appBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 7.0.wp),
          child: MainFloatingButton(controller: controller),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 5.0.wp),
          child: ListViewScreen(controller: controller),
        ),
      ),
    );
  }
}

AppBar appBar() {
  return AppBar(
    backgroundColor: darkGray,
    elevation: 0.0,
    centerTitle: true,
    title: Text(
      "Tasklly",
      style: GoogleFonts.squarePeg(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 11.0.wp,
      ),
    ),
    leading: IconButton(
      icon: const Icon(
        Icons.data_usage_outlined,
        size: 20,
      ),
      onPressed: () => Get.to(ReportScreen()),
    ),
  );
}
