import 'package:final_exam_22_06_2023/screens/add/controller/add_sontroller.dart';
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
          title: Text("Add Screen"),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
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
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
              ),
              child: TextField(
                controller: getxAddController.txtTask,
                decoration: InputDecoration(
                  hintText: "Enter Type",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none
                  )
                ),
              ),
            ),
            Obx(
              () =>  Container(
                height: 7.7.h,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
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
            ElevatedButton(onPressed: () {
              DbHelper.dbHelper.insertDatabase(task: getxAddController.txtTask.text, title: getxAddController.txtTitle.text,type: getxAddController.txtType.text);
            }, child: Text("Add")),
          ],
        ),
      ),
    );
  }
}
