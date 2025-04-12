import 'package:flutter/material.dart';

import 'package:surveyist/users_UI/user_dashboard.dart';

import 'package:surveyist/utils/app_font.dart';
import 'package:surveyist/utils/app_button.dart';

class TasksubmitPage extends StatefulWidget {
  const TasksubmitPage({super.key});

  @override
  State<TasksubmitPage> createState() => _TasksubmitPageState();
}

class _TasksubmitPageState extends State<TasksubmitPage> {
  DateTime startDate = DateTime.now();

  DateTime endDate = DateTime.now();

  void selectprojectStartDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2027));
    if (picked != null) {
      setState(() {
        startDate = picked;
        //print(picked);
      });
    }
  }

  void selectProjectendDate(BuildContext context) async {
    DateTime endDate = DateTime.now();

    final end = await showDatePicker(
        context: context,
        initialDate: endDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2027));
    if (end != null) {
      setState(() {
        endDate = end;
        //  print(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar:AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 100,
                ),
                const Center(
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
                const Card(
                  color: Color.fromARGB(255, 92, 92, 92),
                  child: Text(
                    "  Task_Name    ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: "submit task",
                      hintStyle:
                          TextStyle(fontSize: 12, fontFamily: AppFont.fontFamily),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                const Card(
                  color: Color.fromARGB(255, 92, 92, 92),
                  child: Text(
                    "  final_Report  ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                TextFormField(
                  decoration: const InputDecoration(
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
                const Card(
                  color: Color.fromARGB(255, 92, 92, 92),
                  child: Text(
                    " Description    ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 20 / 100,
                  width: MediaQuery.of(context).size.width * 100 / 100,
                  //color: Colors.amber,
                  child: TextFormField(
                    maxLines: 15,
                    maxLength: 1000,
                    decoration: const InputDecoration(
                        hintText: "Discription....",
                        hintStyle: TextStyle(
                            fontSize: 12, fontFamily: AppFont.fontFamily),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                const Card(
                  color: Color.fromARGB(255, 92, 92, 92),
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
                            child: 
                               const Icon(Icons.calendar_month),
                            
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.height * 5 / 100,
                          ),
                          Text("$startDate".split(' ')[0]),
                          
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                const Card(
                  color: Color.fromARGB(255, 92, 92, 92),
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
                            child:  const Icon(Icons.calendar_month),
                            
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.height * 5 / 100,
                          ),
                        
                             Text("$endDate".split(' ')[0]),
                          
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
                  child: const Center(
                    child: Text("Select_image"),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 100,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                const Card(
                  color: Color.fromARGB(255, 92, 92, 92),
                  child: Text(
                    "  Other_Details  ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Other_Detail__Of_project.",
                      hintStyle:
                          TextStyle(fontSize: 12, fontFamily: AppFont.fontFamily),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 3 / 100,
                ),
                MyButton(
                      text: "submit", color: Colors.black, onPressed: () 
                      {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const UserDashBoardScreen()));
                    
                      }),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
