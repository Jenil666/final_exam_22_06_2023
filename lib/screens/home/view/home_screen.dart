import 'package:final_exam_22_06_2023/screens/home/controller/home_controller.dart';
import 'package:final_exam_22_06_2023/utils/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController getxHomeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DbHelper.dbHelper.checkDb();
    getxHomeController.readData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home Screen"),
        ),
        body: Obx(
          () =>  ListView.builder(
            itemCount: getxHomeController.mainData.length,
            itemBuilder: (context, index) {
              return InkWell(
                onDoubleTap: () {
                  getxHomeController.delete(id: "${getxHomeController.mainData[index]['${DbHelper.dbHelper.c_id}']}");
                },
                onLongPress: () {
                  getxHomeController.txtUpdateTask = TextEditingController(text: "${getxHomeController.mainData[index]['${DbHelper.dbHelper.c_task}']}");
                  getxHomeController.txtUpdateTitle = TextEditingController(text: "${getxHomeController.mainData[index]['${DbHelper.dbHelper.c_title}']}");
                  getxHomeController.txtUpdateType = TextEditingController(text: "${getxHomeController.mainData[index]['${DbHelper.dbHelper.c_type}']}");
                  Get.defaultDialog(title: "Update",content: Container(
                    height: 340,
                    width: 300,
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                          ),
                          child: TextField(
                            controller: getxHomeController.txtUpdateTitle,
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
                            controller: getxHomeController.txtUpdateTask,
                            decoration: InputDecoration(
                                hintText: "Enter Task",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none
                                )
                            ),
                          ),
                        ),
                        DropdownMenu(
                            controller: getxHomeController.txtUpdateType,
                            dropdownMenuEntries: [
                          DropdownMenuEntry(value: 'Urgent', label: 'Urgent'),
                          DropdownMenuEntry(value: 'Low', label: 'Low'),
                          DropdownMenuEntry(value: 'Medium', label: 'Medium'),
                          DropdownMenuEntry(value: 'High', label: 'High'),
                        ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(onPressed: () {
                              getxHomeController.updateData(type: getxHomeController.txtUpdateType.text, title: getxHomeController.txtUpdateTitle.text, task: getxHomeController.txtUpdateTask.text, id: "${getxHomeController.mainData[index]['${DbHelper.dbHelper.c_id}']}");
                              Get.back();
                            }, child: Text("Update")),
                            ElevatedButton(onPressed: () {
                              Get.back();
                            }, child: Text("cnncle")),
                          ],
                        ),
                      ],
                    ),
                  ));
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 10.h,
                  width: 100.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${getxHomeController.mainData[index]['${DbHelper.dbHelper.c_title}']}",
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${getxHomeController.mainData[index]['${DbHelper.dbHelper.c_task}']}",
                            style: TextStyle(fontSize: 10.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: getxHomeController.mainData[index]
                      ['${DbHelper.dbHelper.c_type}'] ==
                          "Urgent"
                          ? Colors.red.shade100
                          : getxHomeController.mainData[index]
                      ['${DbHelper.dbHelper.c_type}'] ==
                          "Low"
                          ? Colors.orange.shade100
                          : getxHomeController.mainData[index]
                      ['${DbHelper.dbHelper.c_type}'] ==
                          "Medium"
                          ? Colors.green.shade200
                          : getxHomeController.mainData[index]
                      ['${DbHelper.dbHelper.c_type}'] ==
                          "High"
                          ? Colors.yellow.shade100
                          : Colors.transparent,
                      border: Border.all(color: Colors.black)),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/add');
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
