import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/adminProvider/adminProjectProvider.dart';
import 'package:surveyist/admin_uI/excellFile.dart';
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
  // String? selectedTaskType;
  // String? selectedFile; // this will hold selected file
  // List<List<dynamic>> excelData = []; // this will excel preview....
  final List<String> taskType = ["Excel Sheet", "PDF", "Image", "Form"];

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
            Container(
              child: Column(
                children: [
                  DropdownButton<String>(
                      value: newTaskProvider.selectedTaskType,
                      hint: Text("select_task_type"),
                      items: taskType.map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList(),
                      onChanged: (value) =>
                          newTaskProvider.setTaskType(value!)),
                  ElevatedButton(
                      onPressed: () {
                        newTaskProvider.pickFile();
                      },
                      child: Text("Select_file"))
                ],
              ),
            ),
            if (newTaskProvider.selectedFile != null) ...[
              Text("Selected File:${newTaskProvider.selectedFile!.path.split('/').last}"),
              const SizedBox(
                height: 10,
              ),
              if (newTaskProvider.selectedTaskType == 'Excel Sheet' &&
                  newTaskProvider.excelData.isNotEmpty)
                Expanded(
                    child: SingleChildScrollView(
                  child: DataTable(
                      columns: newTaskProvider.excelData.first
                          .map((e) => DataColumn(label: Text(e.toString())))
                          .toList(),
                      rows: List<DataRow>.generate(newTaskProvider.excelData.length,(index)=>DataRow(selected:newTaskProvider.selectedRow.contains(index),
                      onSelectChanged: (isSelected){
                        newTaskProvider.toggleRowAndColumn(index);
                      },
                      cells:newTaskProvider.excelData[index].map((cell)=>DataCell(Text(cell.toString()))).toList(),
                      )
                      )),
                ))
            ],
            // if (newTaskProvider.selectedFile != null)
            //   Text("Selected File: ${newTaskProvider.selectedFile!.path.split('/').last}"),
            // const SizedBox(height: 10),

            // // Show Excel Data Preview with Row Selection
            // if (newTaskProvider.selectedTaskType == 'Excel Sheet' &&
            //     newTaskProvider.excelData.isNotEmpty)
            //   Expanded(
            //     child: SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: DataTable(
            //         columns: newTaskProvider.excelData.first
            //             .map((e) => DataColumn(label: Text(e.toString())))
            //             .toList(),
            //         rows: List<DataRow>.generate(
            //           newTaskProvider.excelData.length,
            //           (index) => DataRow(
            //             selected: newTaskProvider.selectedRow.contains(index),
            //             onSelectChanged: (isSelected) {
            //               newTaskProvider.toggleRowAndColumn(index);
            //             },
            //             cells: newTaskProvider.excelData[index]
            //                 .map((cell) => DataCell(Text(cell.toString())))
            //                 .toList(),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
            if(newTaskProvider.selectedRow.isNotEmpty)
            ElevatedButton(onPressed: () {
              final selectedData=newTaskProvider.getSelectedData();
              showDialog(context: context, builder: (_)=>AlertDialog(
                title:Text("selectRow"),
                content: SingleChildScrollView(
                  child: Column(
                    children:selectedData.map((row){
                      return Text(row.join(","));
                    }).toList(),

                  ),
                ),
                actions: [
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: Text("close"))
                ],
              ));
              
              
            }, child:Text("view selected row")),
            // if (newTaskProvider.selectedRow.isNotEmpty)
            //   ElevatedButton(
            //     onPressed: () {
            //       final selectedData = newTaskProvider.getSelectedData();
            //       showDialog(
            //         context: context,
            //         builder: (_) => AlertDialog(
            //           title: const Text("Selected Rows"),
            //           content: SingleChildScrollView(
            //             child: Column(
            //               children: selectedData
            //                   .map((row) => Text(row.join(", ")))
            //                   .toList(),
            //             ),
            //           ),
            //           actions: [
            //             TextButton(
            //               onPressed: () => Navigator.pop(context),
            //               child: const Text("Close"),
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //     child: const Text("View Selected Rows"),
            //   ),

            //------------------------hide date 20-2-2025 image picker function implement here------------
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => ImageSelect(),
            //           ));
            //     },
            //     child: Text("image_select")),


            ElevatedButton(onPressed: () {
              
              Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExcelReaderPage(),
                        ));
              
            }, child: Text("pick excell file")),

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
