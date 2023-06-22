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
          backgroundColor: Colors.white,
          title: Text("Home Screen",style: TextStyle(color: Colors.black),),
          centerTitle: true,
        ),
        body: Obx(
          () =>  ListView.builder(
            itemCount: getxHomeController.mainData.length,
            itemBuilder: (context, index) {
              getxHomeController.time.value = "${getxHomeController.mainData[index]["${DbHelper.dbHelper.c_time}"]}";
              return InkWell(
                onDoubleTap: () {
                  getxHomeController.delete(id: "${getxHomeController.mainData[index]['${DbHelper.dbHelper.c_id}']}");
                },
                onLongPress: () {
                  getxHomeController.txtUpdateTask = TextEditingController(text: "${getxHomeController.mainData[index]['${DbHelper.dbHelper.c_task}']}");
                  getxHomeController.txtUpdateTitle = TextEditingController(text: "${getxHomeController.mainData[index]['${DbHelper.dbHelper.c_title}']}");
                  getxHomeController.txtUpdateType = TextEditingController(text: "${getxHomeController.mainData[index]['${DbHelper.dbHelper.c_type}']}");
                  Get.defaultDialog(title: "Update",content: Container(
                    height: 335,
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
                        Obx(
                              () =>  Container(
                            height: 7.7.h,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            child: Row(children: [
                              SizedBox(width: 10,),
                              Text('${getxHomeController.time}'),
                              Spacer(),
                              IconButton(onPressed: () async {
                                TimeOfDay? newTime = await showTimePicker(context: context, initialTime: getxHomeController.data);
                                if(newTime != null)
                                {
                                  getxHomeController.time.value = "${newTime.hour}:${newTime.minute}";
                                }
                              }, icon: Icon(Icons.timelapse)),
                              SizedBox(width: 10,),
                            ]),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            DropdownMenu(
                                controller: getxHomeController.txtUpdateType,
                                dropdownMenuEntries: [
                              DropdownMenuEntry(value: 'Urgent', label: 'Urgent'),
                              DropdownMenuEntry(value: 'Low', label: 'Low'),
                              DropdownMenuEntry(value: 'Medium', label: 'Medium'),
                              DropdownMenuEntry(value: 'High', label: 'High'),
                            ]),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(onPressed: () {
                              getxHomeController.updateData(time: "${getxHomeController.time}",type: getxHomeController.txtUpdateType.text, title: getxHomeController.txtUpdateTitle.text, task: getxHomeController.txtUpdateTask.text, id: "${getxHomeController.mainData[index]['${DbHelper.dbHelper.c_id}']}");
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
                  padding: EdgeInsets.all(10),
                  height: 18.h,
                  width: 100.w,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${getxHomeController.mainData[index]['${DbHelper.dbHelper.c_title}']}",
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          Spacer(),
                          Container(
                            height: 4.h,
                            width: 15.w,
                            alignment: Alignment.center,
                            child:  Text("${getxHomeController.mainData[index][DbHelper.dbHelper.c_type]}"),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${getxHomeController.mainData[index]['${DbHelper.dbHelper.c_task}']}",
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          Spacer(),
                          Text("${getxHomeController.mainData[index][DbHelper.dbHelper.c_time]}")
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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
                      // border: Border.all(color: Colors.black)
                  ),
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
