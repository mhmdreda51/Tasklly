import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/app/data/services/storage/services.dart';
import 'package:todolist/app/modules/home/biniding/biniding.dart';

import 'app/modules/home/view/home_screen.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageServices().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tasklly',
      initialBinding: HomeBinding(),
      theme: ThemeData(
        textTheme: GoogleFonts.robotoSlabTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home: HomePage(),
    );
  }
}
