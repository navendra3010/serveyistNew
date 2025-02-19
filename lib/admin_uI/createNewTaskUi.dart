import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/adminProvider/adminProjectProvider.dart';
import 'package:surveyist/localization/Camera&gallery.dart';
import 'package:surveyist/utils/TextSyle.dart';
import 'package:surveyist/utils/appButton.dart';
import 'package:surveyist/utils/appFont.dart';

class Createnewtask extends StatefulWidget {
  Createnewtask({super.key});
  @override
  State<Createnewtask> createState() => MycreateUi();
}

class MycreateUi extends State<Createnewtask> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController selectItemController = TextEditingController();

  var selectItem = [
    'Male',
    'Female',
    'other',
  ];
  @override
  Widget build(BuildContext context) {
    final newTaskProvider = Provider.of<Projectprovider>(context);

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
                child: Text('project_Name',
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
                  // controller: projectDiscriptionControlller,
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
            Row(
              children: [
                SizedBox(
                  width: 150,
                  child: Text("SELECT_TASK_TYPE",
                      style: TextStyle(
                          fontFamily: AppFont.fontFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 12)),
                ),
                Flexible(
                  child: SizedBox(
                      width: 200.0, // Fixed width
                      height: 45.0, // Fixed height
                      child: TextField(
                        controller: selectItemController,
                        decoration: InputDecoration(
                          suffixIcon: PopupMenuButton<String>(
                            icon: const Icon(Icons.arrow_drop_down),
                            onSelected: (String value) {
                              selectItemController.text = value;
                            },
                            itemBuilder: (BuildContext context) {
                              return selectItem
                                  .map<PopupMenuItem<String>>((String value) {
                                return new PopupMenuItem(
                                    child: new Text(value), value: value);
                              }).toList();
                            },
                          ),
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageSelect(),
                      ));
                },
                child: Text("image_select")),

            MyButton(
              text: "Create_Task",
              color: const Color.fromARGB(255, 221, 187, 138),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
