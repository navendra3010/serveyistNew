import 'package:flutter/material.dart';

import 'package:surveyist/users_UI/userDashboard.dart';
import 'package:surveyist/utils/appButton.dart';
import 'package:surveyist/utils/appFont.dart';

class TasksubmitPage extends StatefulWidget {
  const TasksubmitPage({super.key});

  @override
  State<TasksubmitPage> createState() => _TasksubmitPageState();
}

class _TasksubmitPageState extends State<TasksubmitPage> {
  DateTime StartDate = DateTime.now();

  DateTime EndDate = DateTime.now();

  void selectprojectStartDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: StartDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2027));
    if (picked != null) {
      setState(() {
        StartDate = picked;
        print(picked);
      });
    }
  }

  void selectProjectendDate(BuildContext context) async {
    DateTime endDate = DateTime.now();

    final end = await showDatePicker(
        context: context,
        initialDate: EndDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2027));
    if (end != null) {
      setState(() {
        EndDate = end;
        //  print(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar:AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 100,
                ),
                Center(
                  child: Card(
                    color: Colors.black,
                    child: Text(
                      "Submit_Task",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 100,
                ),
                Card(
                  color: const Color.fromARGB(255, 92, 92, 92),
                  child: Text(
                    "  Task_Name    ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Task_name.",
                      hintStyle:
                          TextStyle(fontSize: 12, fontFamily: AppFont.fontFamily),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                Card(
                  color: const Color.fromARGB(255, 92, 92, 92),
                  child: Text(
                    "  final_Report  ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Final_Report_Of_project.",
                      hintStyle:
                          TextStyle(fontSize: 12, fontFamily: AppFont.fontFamily),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
               
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                Card(
                  color: const Color.fromARGB(255, 92, 92, 92),
                  child: Text(
                    " Description    ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 20 / 100,
                  width: MediaQuery.of(context).size.width * 100 / 100,
                  //color: Colors.amber,
                  child: TextFormField(
                    maxLines: 15,
                    maxLength: 1000,
                    decoration: InputDecoration(
                        hintText: "Discription....",
                        hintStyle: TextStyle(
                            fontSize: 12, fontFamily: AppFont.fontFamily),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                Card(
                  color: const Color.fromARGB(255, 92, 92, 92),
                  child: Text(
                    " Starting_Date    ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
        
                Container(
                  height: MediaQuery.of(context).size.height * 5 / 100,
                  width: MediaQuery.of(context).size.width * 100 / 100,
                  //color:Colors.amber,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 0.5)),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              selectprojectStartDate(context);
                            },
                            child: Container(
                              child: Icon(Icons.calendar_month),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.height * 5 / 100,
                          ),
                          Container(
                            
                            child: Text("${StartDate}".split(' ')[0]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                Card(
                  color: const Color.fromARGB(255, 92, 92, 92),
                  child: Text(
                    " Task_Submit_Date  ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 5 / 100,
                  width: MediaQuery.of(context).size.width * 100 / 100,
                  //color:Colors.amber,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 0.5)),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              selectProjectendDate(context);
                            },
                            child: Container(
                              child: Icon(Icons.calendar_month),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.height * 5 / 100,
                          ),
                          Container(
                            child: Text("${EndDate}".split(' ')[0]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 100,
                ),
        
                // Container(
                //    height: MediaQuery.of(context).size.height * 20 / 100,
                //   width: MediaQuery.of(context).size.width * 100 / 100,
                //   decoration:BoxDecoration(
                //     border:Border.all(width: 0.5),
                //     Image.file(File(_image!.path));
                //   ),
        
                // child:FloatingActionButton(onPressed: (){
                //   getImage();
                // }),
                // )
                // FloatingActionButton(onPressed: ()
                // {getImage();},
                // child:Text("select image"),),
                Container(
                  height: MediaQuery.of(context).size.height * 20 / 100,
                  width: MediaQuery.of(context).size.width * 100 / 100,
                  decoration: BoxDecoration(border: Border.all(width: 0.5)),
                  child: Center(
                    child: Text("Select_image"),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 100,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                Card(
                  color: const Color.fromARGB(255, 92, 92, 92),
                  child: Text(
                    "  Other_Details  ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Other_Detail__Of_project.",
                      hintStyle:
                          TextStyle(fontSize: 12, fontFamily: AppFont.fontFamily),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 3 / 100,
                ),
                Container(
                  child: MyButton(
                      text: "submit", color: Colors.black, onPressed: () 
                      {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserDashBoardScreen()));
                    
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
