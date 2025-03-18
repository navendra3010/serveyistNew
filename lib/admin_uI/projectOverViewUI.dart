import 'package:flutter/material.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:provider/provider.dart';
import 'package:surveyist/adminModel/project_model.dart';
import 'package:surveyist/adminProvider/admin_project_provider.dart';

import 'package:surveyist/admin_uI/new_prject_ui.dart';
import 'package:surveyist/admin_uI/projectDetails.dart';
import 'package:surveyist/utils/TextSyle.dart';
import 'package:surveyist/utils/appConstant.dart';

import 'package:surveyist/utils/appFooter.dart';

class ProjectOverView extends StatefulWidget {
 const ProjectOverView({super.key});

  @override
  State<ProjectOverView> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<ProjectOverView> {
  @override
  void initState() {
    super.initState();
    Provider.of<Projectprovider>(context, listen: false).listenProject();
  }

  @override
  Widget build(BuildContext context) {
    final overViewProvider =
        Provider.of<Projectprovider>(context, listen: false);
    return Scaffold(
      body: Column(
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
                "Project_overview",
                style: CustomText.nameOfTextStyle,
              )),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 100,
          ),

          Container(
            height: MediaQuery.of(context).size.height * 2 / 100,
            width: MediaQuery.of(context).size.width * 90 / 100,
            //  color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Project Name",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 3 / 100,
                ),
                Text(
                  "completed Task/Total Task",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 3 / 100,
                ),
                Text(
                  "Status",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 2 / 100,
                ),
              ],
            ),
          ),

          //date......................................18-2-2025..................................

          Consumer<Projectprovider>(
              builder: (context, overViewProvider, child) {
            return overViewProvider.project.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 50 / 100,
                            width: MediaQuery.of(context).size.width * 90 / 100,
                            child: ListView.builder(
                              shrinkWrap: true,
                              primary: true,
                              itemCount: overViewProvider.project.length,
                              itemBuilder: (context, index) {
                                final project = overViewProvider.project[index]
                                    ["data"] as ProjectModel;
                                final projectId = overViewProvider
                                    .project[index]["projectId"];
                                final docId =
                                    overViewProvider.project[index]["docId"];

                                int? totalProgress = project.progress;
                                int? totalTask = project.totalTask;
                                int? asIntRound;

                                if (totalProgress == null ||
                                    totalTask == null ||
                                    totalTask == 0) {
                                  asIntRound = 0;
                                } else {
                                  var percen =
                                      (totalProgress * 100) / totalTask;

                                  asIntRound = percen.round();
                                }
                                bool projectComplete = false;
                                if (totalProgress == totalTask) {
                                  projectComplete = true;
                                }

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      print(overViewProvider.project[index]
                                          ["projectId"]);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProjectDetailui(
                                                    projectId: projectId,
                                                    documentId: docId),
                                          ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: projectComplete == true
                                              ? const Color.fromARGB(
                                                  255, 186, 211, 187)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                1 /
                                                100,
                                          ),
                                          // Container(
                                          //   child: Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.end,
                                          //     children: [
                                          //       InkWell(
                                          //         onTap: () {
                                          //           overViewProvider
                                          //               .showEditDialogBox(
                                          //                   projectId,
                                          //                   docId,
                                          //                   context,
                                          //                   project.projectName);
                                          //         },
                                          //         child: Icon(Icons.edit),
                                          //       ),
                                          //       SizedBox(
                                          //         width: MediaQuery.of(context)
                                          //                 .size
                                          //                 .width *
                                          //             8 /
                                          //             100,
                                          //       ),
                                          //       InkWell(
                                          //         onTap: () {
                                          //           overViewProvider
                                          //               .deleteProject(context,
                                          //                   docId, projectId);
                                          //           print("Delete");
                                          //         },
                                          //         child: Icon(Icons.delete),
                                          //       )
                                          //     ],
                                          //   ),
                                          // ),
                                          // SizedBox(
                                          //   height: MediaQuery.of(context)
                                          //           .size
                                          //           .height *
                                          //       1 /
                                          //       100,
                                          // ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      30 /
                                                      100,
                                                  child: Text(
                                                    "${project.projectName}",
                                                  ),
                                                ),
                                                Text(
                                                    " ${project.progress}/ ${project.totalTask ?? "0"}"),
                                                Container(
                                                  child:
                                                       LinearPercentIndicator(
                                                          width: 100.0,
                                                          lineHeight: 25.0,
                                                          percent:
                                                              asIntRound / 100,
                                                          barRadius:
                                                              Radius.circular(
                                                                  10),
                                                          backgroundColor:
                                                              Colors.grey,
                                                          center: Text(
                                                              "${asIntRound}%"),
                                                          progressColor:
                                                              Colors.amber),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                2 /
                                                100,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 221, 187, 138),
          onPressed: () {
            print("create new project");
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Newproject(),
                ));
          },
          // child:Text("New_project"),),
          child: Icon(Icons.add)),
      bottomNavigationBar: AppFooterUi(
          notificationCount: 0, selectMenu: ButtomMenu.ProjectOverView),
    );
  }
}
