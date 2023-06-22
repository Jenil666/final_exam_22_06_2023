import 'package:final_exam_22_06_2023/screens/add/controller/add_sontroller.dart';
import 'package:final_exam_22_06_2023/screens/home/controller/home_controller.dart';
import 'package:final_exam_22_06_2023/utils/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  AddController getxAddController = Get.put(AddController());
  HomeController getxHomeController = Get.put(HomeController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getxAddController.time.value = "${getxAddController.data.hour}:${getxAddController.data.minute}";
  }
  @override
  Widget build(BuildContext context) {
    //todo add type
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {
              DbHelper.dbHelper.insertDatabase(task: getxAddController.txtTask.text, title: getxAddController.txtTitle.text,type: getxAddController.txtType.text,time: getxAddController.time.value);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data Added")));
              getxAddController.txtTask.clear();
              getxAddController.txtTitle.clear();
            }, icon: Icon(Icons.save,color: Colors.black,)),
            SizedBox(width: 10,),
          ],
          leading: IconButton(onPressed: () {
            getxHomeController.readData();
            Get.back();
          }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
          backgroundColor: Colors.white,
          title: Text("Add Screen",style: TextStyle(color: Colors.black),),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black)
              ),
              child: TextField(
                controller: getxAddController.txtTitle,
                decoration: InputDecoration(
                  hintText: "Enter Title",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none
                  )
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black)
              ),
              child: TextField(
                controller: getxAddController.txtTask,
                decoration: InputDecoration(
                  hintText: "Enter Task",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none
                  )
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownMenu(
                    inputDecorationTheme: InputDecorationTheme(enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)) ),
                      controller: getxAddController.txtType,
                      dropdownMenuEntries: [
                        DropdownMenuEntry(value: 'Urgent', label: 'Urgent'),
                        DropdownMenuEntry(value: 'Low', label: 'Low'),
                        DropdownMenuEntry(value: 'Medium', label: 'Medium'),
                        DropdownMenuEntry(value: 'High', label: 'High'),
                      ]),
                  Obx(
                        () =>  Container(
                      height: 7.3.h,
                      width: 38.w,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black)
                      ),
                      child: Row(children: [
                        SizedBox(width: 10,),
                        Text('${getxAddController.time}'),
                        Spacer(),
                        IconButton(onPressed: () async {
                          TimeOfDay? newTime = await showTimePicker(context: context, initialTime: getxAddController.data);
                          if(newTime != null)
                          {
                            getxAddController.time.value = "${newTime.hour}:${newTime.minute}";
                          }
                        }, icon: Icon(Icons.timelapse)),
                        SizedBox(width: 10,),
                      ]),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
