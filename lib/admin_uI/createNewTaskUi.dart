import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/adminModel/taskModel.dart';
import 'package:surveyist/adminProvider/adminProjectProvider.dart';
import 'package:surveyist/admin_uI/projectDetails.dart';
import 'package:surveyist/admin_uI/projectOverViewUI.dart';

import 'package:surveyist/utils/TextSyle.dart';
import 'package:surveyist/utils/appButton.dart';
import 'package:surveyist/utils/appFont.dart';
import 'package:surveyist/utils/appSnackBarOrToastMessage.dart';

class Createnewtask extends StatefulWidget {
  String? projectId;
  String? documentId;
  Createnewtask({super.key, required this.projectId, required this.documentId});
  @override
  State<Createnewtask> createState() => MycreateUi();
}

class MycreateUi extends State<Createnewtask> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescription = TextEditingController();

  final List<String> taskType = [
    "Excel Sheet",
    "PDF",
    "Image",
  ];

  String? selectedUserId;

  void initState() {
    super.initState();

    Provider.of<Projectprovider>(context, listen: false)
        .taskAssignToUser(widget.documentId, widget.projectId);
  }

  @override
  Widget build(BuildContext context) {
    final newTaskProvider =
        Provider.of<Projectprovider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 5 / 100,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 5 / 100,
                width: MediaQuery.of(context).size.width * 100 / 100,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 221, 187, 138),
                    borderRadius: BorderRadius.all(Radius.circular(80))),
                child: Center(
                    child: Text(
                  "New_Task",
                  style: CustomText.nameOfTextStyle,
                )),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              SizedBox(
                width: 120.0, // Fixed width for the label
                child: Text('Task_Name',
                    style: TextStyle(
                        fontFamily: AppFont.fontFamily,
                        fontWeight: FontWeight.w700,
                        fontSize: 16)),
              ),
              Flexible(
                child: SizedBox(
                  width: 200.0, // Fixed width
                  height: 45.0, // Fixed height
                  child: TextField(
                    controller: taskNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter_Task_Name',
                    ),
                  ),
                ),
              ),
            ]),
            //date 19-2-2025-------------------------------------
            //select calendar start date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 125.0,
                  child: TextButton(
                    onPressed: () {
                      // Consumer<Projectprovider>(builder: (context, newTaskProvider, child) {
                      //   return selectprojectStartDate(context);
                      // },);
                      newTaskProvider.selectprojectStartDate(context);
                    },
                    child: Column(
                      children: [
                        Container(
                          child: Icon(Icons.calendar_month),
                        ),
                        Text("Task_Assigh_Date")
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    width: 200.0, // Fixed width
                    height: 45.0, // Fixed height
                    child: TextField(
                      controller: newTaskProvider.dateStartcontroller,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 120.0,
                  child: TextButton(
                    onPressed: () {
                      newTaskProvider.selectprojectEndDate(context);
                    },
                    child: Column(
                      children: [
                        Container(
                          child: Icon(Icons.calendar_month),
                        ),
                        Text("Task_Due_Date")
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    width: 200.0, // Fixed width
                    height: 45.0, // Fixed height
                    child: TextField(
                      controller: newTaskProvider.dateEndcontroller,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
            //-----------------start----------Task description------container-----------------------------
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 10 / 100,
                width: MediaQuery.of(context).size.width * 90 / 100,
                //color: Colors.amber,
                child: TextFormField(
                  controller: taskDescription,
                  maxLines: 15,
                  maxLength: 1000,
                  decoration: InputDecoration(
                      hintText: "Task_Discription....",
                      hintStyle: TextStyle(
                          fontSize: 12, fontFamily: AppFont.fontFamily),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
            ),
            Consumer<Projectprovider>(
                builder: (context, newTaskProvider, child) {
              return Container(
                child: Column(
                  children: [
                    DropdownButton<String>(
                        value: newTaskProvider.selectedTaskType,
                        hint: Text("select_task_type"),
                        items: taskType.map((type) {
                          return DropdownMenuItem(
                              value: type, child: Text(type));
                        }).toList(),
                        onChanged: (value) =>
                            newTaskProvider.setTaskType(value!)),
                    ElevatedButton(
                        onPressed: () {
                          newTaskProvider.selectedTaskType == null
                              ? Center(
                                  child: ShowTaostMessage.toastMessage(
                                      context, "Select_Task_File"))
                              : newTaskProvider.pickFile();
                        },
                        child: Text("Select_files")),
                    if (newTaskProvider.selectedFile != null)
                      Text(newTaskProvider.selectedFile != null
                          ? "SelectTed file are${newTaskProvider.selectedFile!.path.split('/').last}"
                          : "no file selected"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                  ],
                ),
              );
            }),

            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),

            Container(
              child: Column(children: [
                Consumer<Projectprovider>(
                    builder: (context, newTaskProvider, child) {
                  return newTaskProvider.teamList.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            DropdownButton<String>(
                              hint: Text("Select User"),
                              value: selectedUserId,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedUserId = newValue;
                                });
                              },
                              items: newTaskProvider.teamList
                                  .map<DropdownMenuItem<String>>((user) {
                                return DropdownMenuItem<String>(
                                  value: user["userId"],
                                  child: Text(user["name"]),
                                );
                              }).toList(),
                            ),
                            if (selectedUserId != null)
                              Text("Selected User ID: $selectedUserId"),
                          ],
                        );
                })
              ]),
            ),

            MyButton(
              text: "Create_Task",
              color: const Color.fromARGB(255, 221, 187, 138),
              onPressed: () {
                newTaskProvider.createNewTask(
                    taskNameController.text,
                    taskDescription.text,
                    dateFormate(newTaskProvider.dateStartcontroller.text),
                    dateFormate(newTaskProvider.dateEndcontroller.text),
                    selectedUserId,
                    widget.projectId,
                    widget.documentId);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProjectOverView(),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }

  DateTime? dateFormate(String date) {
    if (date == "") {
      return null;
    } else {
      return DateTime.parse(date);
    }
  }
}
