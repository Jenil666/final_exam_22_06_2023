import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddController extends GetxController
{
  TimeOfDay data = TimeOfDay.now();
  RxString time = "".obs;
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtTask = TextEditingController();
  TextEditingController txtType = TextEditingController();
}