import 'package:final_exam_22_06_2023/utils/dbHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<Map> mainData = <Map>[].obs;
  TextEditingController txtUpdateTitle = TextEditingController();
  TextEditingController txtUpdateTask = TextEditingController();
  TextEditingController txtUpdateType = TextEditingController();
  RxString time = ''.obs;
  TimeOfDay data = TimeOfDay.now();
  Future<void> readData() async {
    mainData.value = await DbHelper.dbHelper.readDatabase();
    print(mainData);
  }

  void updateData(
      {required String? title, required String? task, required String? id, required String? type,required String? time}) {
    DbHelper.dbHelper.updateDatabase(
        type: type, title: title, task: task, id: id,time: time);
    readData();
  }

  void delete({required String? id})
  {
    DbHelper.dbHelper.deleteDatabase(id: id);
    readData();
  }

}