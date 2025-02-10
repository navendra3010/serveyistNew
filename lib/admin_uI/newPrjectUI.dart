import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/adminModel/projectModel.dart';
import 'package:surveyist/adminProvider/adminProjectProvider.dart';
import 'package:surveyist/utils/TextSyle.dart';
import 'package:surveyist/utils/appButton.dart';
import 'package:surveyist/utils/appFont.dart';

class Newproject extends StatefulWidget {
  Newproject({super.key});
  @override
  State<Newproject> createState() => _MyNewProjectUI();
}

class _MyNewProjectUI extends State<Newproject> {
  TextEditingController projectNameController = TextEditingController();
  TextEditingController projectLocationController = TextEditingController();
  TextEditingController projectDiscriptionControlller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final newProject = Provider.of<Projectprovider>(context);
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 5 / 100,
              ),
              //new projec text container-------------------------------------------------
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 5 / 100,
                  width: MediaQuery.of(context).size.width * 100 / 100,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 221, 187, 138),
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                  child: Center(
                      child: Text(
                    "New_project",
                    style: CustomText.nameOfTextStyle,
                  )),
                ),
              ),
              //end---------------------------------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
                        controller: projectNameController,
                        decoration: InputDecoration(
                          hintText: 'Enter_Project_Name',
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              //start-------------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 120.0, // Fixed width for the label
                    child: Text('project_Location',
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
                          controller: projectLocationController,
                          // keyboardType:TextInputType.name,
                          decoration: InputDecoration(
                              hintText: 'Enter_Project_Location')),
                    ),
                  ),
                ],
              ),
              //end-------------------------------------------------------------

              //start date select--------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 125.0,
                    child: TextButton(
                      onPressed: () {
                        newProject.setDate(context);
                      },
                      child: Column(
                        children: [
                          Container(
                            child: Icon(Icons.calendar_month),
                          ),
                          Text("Project_Start_Date")
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: 200.0, // Fixed width
                      height: 45.0, // Fixed height
                      child: TextField(
                        controller: newProject.dateStartcontroller,
                      ),
                    ),
                  )
                ],
              ),
              //start date select--------------------------------------------end
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 120.0,
                    child: TextButton(
                      onPressed: () {
                        newProject.setEndDate(context);
                      },
                      child: Column(
                        children: [
                          Container(
                            child: Icon(Icons.calendar_month),
                          ),
                          Text("Project_End_Date")
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: 200.0, // Fixed width
                      height: 45.0, // Fixed height
                      child: TextField(
                        controller: newProject.dateEndcontroller,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 5 / 100,
              ),
              //-----------------start----------project description------container-----------------------------
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 10 / 100,
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  //color: Colors.amber,
                  child: TextFormField(
                    controller: projectDiscriptionControlller,
                    maxLines: 15,
                    maxLength: 1000,
                    decoration: InputDecoration(
                        hintText: "Project_Discription....",
                        hintStyle: TextStyle(
                            fontSize: 12, fontFamily: AppFont.fontFamily),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
              ),
              //-----------------end----------project description----------container-------------------------
              TextButton(
                onPressed: () {
                  newProject.getTeam();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 3 / 100,
                  width: MediaQuery.of(context).size.width * 30 / 100,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 221, 187, 138),
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                  child: Center(
                      child: Text(
                    "Create_Team",
                    style: CustomText.nameOfTextStyle,
                  )),
                ),
              ),

              MyButton(
                text: "create_project",
                color: const Color.fromARGB(255, 221, 187, 138),
                onPressed: () {
                  // print(
                  //     "${projectDiscriptionControlller.text},${projectNameController.text},${projectLocationController.text},${newProject.dateEndcontroller.text},${newProject.dateStartcontroller.text}");

                  ProjectModel pm = ProjectModel();
                  pm.projectName = projectNameController.text.toString().trim();
                  pm.projectLocation =
                      projectNameController.text.toString().trim();
                 // pm.startDate = newProject.dateStartcontroller();
                  // pm.endDate = newProject.dateEndcontroller.text
                  //     .toString()
                  //     .trim() as DateTime?;
                  // pm.projectDiscription =
                  //     projectDiscriptionControlller.text.toString().trim();
                },
              ),
              //submit buttom-------------------------------------------------------------------------end`
            ],
          ),
        ));
  }
}
