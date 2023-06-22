import 'package:final_exam_22_06_2023/screens/add/view/add_screen.dart';
import 'package:final_exam_22_06_2023/screens/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main()
{
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) =>  GetMaterialApp(
        theme: ThemeData(
          useMaterial3: true
        ),
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(name: '/', page: () => HomeScreen(),),
          GetPage(name: '/add', page: () => AddScreen(),),
        ],
      ),
    ),
  );
}