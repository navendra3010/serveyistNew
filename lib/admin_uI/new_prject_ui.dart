import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/adminModel/project_model.dart';
import 'package:surveyist/adminProvider/admin_project_provider.dart';
import 'package:surveyist/utils/TextSyle.dart';
import 'package:surveyist/utils/appButton.dart';
import 'package:surveyist/utils/appFont.dart';

class Newproject extends StatefulWidget {
  const Newproject({super.key});
  @override
  State<Newproject> createState() => _MyNewProjectUI();
}

class _MyNewProjectUI extends State<Newproject> {
  TextEditingController projectNameController = TextEditingController();
  TextEditingController projectLocationController = TextEditingController();
  TextEditingController projectDiscriptionControlller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final newProject = Provider.of<Projectprovider>(context, listen: false);
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
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
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 221, 187, 138),
                        borderRadius: BorderRadius.all(Radius.circular(80))),
                    child: const Center(
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
                    const SizedBox(
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
                          decoration: const InputDecoration(
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
                    const SizedBox(
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
                            decoration: const InputDecoration(
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
                          newProject.selectprojectStartDate(context);
                        },
                        child: Column(
                          children: [
                            const Icon(Icons.calendar_month),
                            const Text("Project_Start_Date")
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
                          newProject.selectprojectEndDate(context);
                        },
                        child: Column(
                          children: [
                            Icon(Icons.calendar_month),
                            const Text("Project_End_Date")
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
                    // width: MediaQuery.of(context).size.width * 90 / 100,
                    //color: Colors.amber,
                    child: TextFormField(
                      controller: projectDiscriptionControlller,
                      maxLines: 15,
                      maxLength: 1000,
                      decoration: const InputDecoration(
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
                    // newProject.getTeam();
                    // newProject.showData();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 3 / 100,
                    width: MediaQuery.of(context).size.width * 30 / 100,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 221, 187, 138),
                        borderRadius: BorderRadius.all(Radius.circular(80))),
                    child: const Center(
                        child: Text(
                      "Create_Team",
                      style: CustomText.nameOfTextStyle,
                    )),
                  ),
                ),

                //this cunsumer show the team member which is selected for project.
                Consumer<Projectprovider>(
                    builder: (context, newProject, child) {
                  if (newProject.selectUserIdForTeam.isEmpty) {
                    return const Center(
                        child: Text("No users selected for the team"));
                  }
                  return StreamBuilder<List<Map<String, dynamic>>>(
                    stream: newProject.userStream, // Replace with actual stream
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // Loading indicator
                      }

                      if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }
                      final userList = snapshot.data ?? [];
                      return SizedBox(
                        height: 50.0, // Set a fixed height for the ListView
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            var uid = userList[index];
                            // print(uid);
                            return Container(
                              width:
                                  100.0, // Set a fixed width for each item (optional)
                              margin: const EdgeInsets.symmetric(
                                  horizontal:
                                      2.0), // Optional margin for spacing
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 221, 187, 138),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Vertically center the text
                                children: [
                                  Text(uid["name"] ?? "no"),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                // this function will select teea, for selected user or team...................
                Consumer<Projectprovider>(
                    builder: (context, newProject, child) {
                  return Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 20 / 100,
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color.fromRGBO(255, 250, 250, 1)),
                      child: StreamBuilder<List<Map<String, dynamic>>>(
                        stream: newProject.teamUser(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text("no data"),
                            );
                          }
                          var userData = snapshot.data!;
                          // print(userData);
                          return SizedBox(
                              height: 80.0,
                              child: ListView.builder(
                                itemCount: userData.length,
                                itemBuilder: (context, index) {
                                  var us = userData[index];
                                  // String userId=us.id;
                                  String userId = us["id"];
                                  String userName = us["full_name"];
                                  String emplpoyeId = us["employeId"];
                                  return CheckboxListTile(
                                    title: Text(userName),
                                    subtitle: Text(emplpoyeId),
                                    value: newProject.selectUserIdForTeam
                                        .any((us) => us["userId"] == userId),
                                    onChanged: (bool? selected) {
                                      newProject.toggleUserId(userId,
                                          us["full_name"], us["employeId"]);
                                    },
                                  );
                                },
                              ));
                        },
                      ),
                    ),
                  );
                }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 5 / 100,
                ),

                Consumer<Projectprovider>(
                    builder: (context, newProject, child) {
                  return newProject.loadUser
                      ? const CircularProgressIndicator()
                      : MyButton(
                          text: "create_project",
                          color: const Color.fromARGB(255, 221, 187, 138),
                          onPressed: () {
                            // print(
                            //     "${projectDiscriptionControlller.text},${projectNameController.text},${projectLocationController.text},${newProject.dateEndcontroller.text},${newProject.dateStartcontroller.text}");

                            ProjectModel pm = ProjectModel();
                            pm.projectName = projectNameController.text.trim();
                            pm.projectLocation =
                                projectLocationController.text.trim();
                            pm.startDate =
                                parseDate(newProject.dateStartcontroller.text);
                            pm.endDate =
                                parseDate(newProject.dateEndcontroller.text);

                            pm.projectDiscription =
                                projectDiscriptionControlller.text.trim();
                            pm.team = newProject.selectUserIdForTeam;
                            pm.progress = 0;
                            pm.totalTask = 0;
                            newProject.addProjectProvider(pm, context);
                          },
                        );
                })
                //submit buttom-------------------------------------------------------------------------end`
              ],
            ),
          ),
        ));
  }

  DateTime? parseDate(String date) {
    if (date == "") {
      return null;
    } else {
      return DateTime.parse(date);
    }
  }
}
