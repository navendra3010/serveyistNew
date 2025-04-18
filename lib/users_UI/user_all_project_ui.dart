import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/adminModel/project_model.dart';
import 'package:surveyist/userProviders/user_project_provider.dart';
import 'package:surveyist/users_UI/user_project_details.dart';
import 'package:surveyist/utils/app_font.dart';

class UserAllProject extends StatefulWidget {
  const UserAllProject({super.key});

  @override
  State<UserAllProject> createState() => _UserAllProjectUI();
}

class _UserAllProjectUI extends State<UserAllProject> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProjectProviderClass>(context, listen: false)
        .allAssignProject();
  }

  @override
  Widget build(BuildContext context) {
    final userProjectPro = Provider.of<UserProjectProviderClass>(context);
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            const Text(
              "Projects",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.amber),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  2 /
                  100, // Spacing between items
            ),
            // userProjectPro.projectData.isEmpty
            //     ? Center(
            //         child: Center(
            //             child: userProjectPro.isLoading == true
            //                 ? const CircularProgressIndicator(
            //                     //         size: 200,
            //                     // circleSize: 15,
            //                     // currentSteps: 50,
            //                     // totalSteps: 10,
            //                     // progressColor: Color.fromARGB(255, 2, 145, 45),
            //                     // stepColor: Color.fromARGB(255, 137, 255, 147)),

            //                     )
            //                 : const Center(
            //                     child: Text("No project Assign yet"),
            //                   )))
            //     : SingleChildScrollView(
            //         child: Column(
            //           children: [
            //             Center(
            //               child: SizedBox(
            //                 height:
            //                     MediaQuery.of(context).size.height * 40 / 100,
            //                 width: MediaQuery.of(context).size.width * 90 / 100,
            //                 child: ListView.builder(
            //                   shrinkWrap: true,
            //                   primary: true,
            //                   itemCount: userProjectPro.projectData.length,
            //                   itemBuilder: (context, index) {
            //                     final project = userProjectPro
            //                         .projectData[index]["data"] as ProjectModel;
            //                     final projectId = userProjectPro
            //                         .projectData[index]["projectId"];
            //                     final docId = userProjectPro.projectData[index]
            //                         ["documentId"];

            //                     return InkWell(
            //                         onTap: () {
            //                           // print(userProjectPro.projectData[index]
            //                           //     ["projectId"]);
            //                           Navigator.push(
            //                               context,
            //                               MaterialPageRoute(
            //                                 builder: (context) =>
            //                                     UserProjectDetailUi(
            //                                         projectID: projectId,
            //                                         documentID: docId),
            //                               ));
            //                         },

            //                         // ),
            //                         child: Padding(
            //                             padding: const EdgeInsets.only(
            //                                 bottom: 10), // Space between items
            //                             child: Container(
            //                                 height: MediaQuery.of(context)
            //                                         .size
            //                                         .height *
            //                                     10 /
            //                                     100,
            //                                 width: MediaQuery.of(context)
            //                                         .size
            //                                         .width *
            //                                     38 /
            //                                     100,
            //                                 decoration: BoxDecoration(
            //                                   borderRadius:
            //                                       BorderRadius.circular(15),
            //                                   color: const Color.fromARGB(
            //                                       255, 228, 153, 41),
            //                                 ),
            //                                 child: Column(
            //                                   mainAxisAlignment:
            //                                       MainAxisAlignment
            //                                           .spaceBetween,
            //                                   children: [
            //                                     Padding(
            //                                       padding: const EdgeInsets
            //                                           .symmetric(
            //                                           horizontal:
            //                                               8.0), // Inner padding
            //                                       child: Text(
            //                                         "${project.projectName}",
            //                                         maxLines: 1,
            //                                         overflow:
            //                                             TextOverflow.ellipsis,
            //                                         style: const TextStyle(
            //                                           fontSize: 12,
            //                                           color: Colors.white,
            //                                           fontFamily:
            //                                               AppFont.fontFamily,
            //                                           fontWeight:
            //                                               FontWeight.w600,
            //                                         ),
            //                                       ),
            //                                     ),
            //                                     Padding(
            //                                       padding: const EdgeInsets
            //                                           .symmetric(
            //                                           horizontal: 8.0,
            //                                           vertical: 4),
            //                                       child: Row(
            //                                         mainAxisAlignment:
            //                                             MainAxisAlignment
            //                                                 .spaceBetween,
            //                                         children: [
            //                                           Column(
            //                                             children: [
            //                                               const Text(
            //                                                 "Starting_Date",
            //                                                 style: TextStyle(
            //                                                   fontSize: 12,
            //                                                   fontWeight:
            //                                                       FontWeight
            //                                                           .w600,
            //                                                   color:
            //                                                       Colors.white,
            //                                                 ),
            //                                               ),
            //                                               Text(
            //                                                 project.startDate
            //                                                     .toString()
            //                                                     .substring(
            //                                                         0, 11),
            //                                                 style:
            //                                                     const TextStyle(
            //                                                   fontSize: 12,
            //                                                   fontWeight:
            //                                                       FontWeight
            //                                                           .w600,
            //                                                   color:
            //                                                       Colors.white,
            //                                                 ),
            //                                               ),
            //                                             ],
            //                                           ),
            //                                           Column(
            //                                             children: [
            //                                               const Text(
            //                                                 "Ending_Date",
            //                                                 style: TextStyle(
            //                                                   fontSize: 12,
            //                                                   fontWeight:
            //                                                       FontWeight
            //                                                           .w600,
            //                                                   color: Colors.red,
            //                                                 ),
            //                                               ),
            //                                               Text(
            //                                                 project.endDate
            //                                                     .toString()
            //                                                     .substring(
            //                                                         0, 11),
            //                                                 style:
            //                                                     const TextStyle(
            //                                                   fontSize: 12,
            //                                                   fontWeight:
            //                                                       FontWeight
            //                                                           .w600,
            //                                                   color: Colors.red,
            //                                                 ),
            //                                               ),
            //                                             ],
            //                                           ),
            //                                         ],
            //                                       ),
            //                                     ),
            //                                   ],
            //                                 ))));
            //                   },
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //date 4-4-25----------------------
            userProjectPro.projectData.isEmpty
    ? Center(
        child: userProjectPro.isLoading
            ? const CircularProgressIndicator()
            : const Text("No project assigned yet"),
      )
    : SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: true,
                  itemCount: userProjectPro.projectData.length,
                  itemBuilder: (context, index) {
                    final project = userProjectPro.projectData[index]["data"] as ProjectModel;
                    final projectId = userProjectPro.projectData[index]["projectId"];
                    final docId = userProjectPro.projectData[index]["documentId"];
          
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProjectDetailUi(
                              projectID: projectId,
                              documentID: docId,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(255, 228, 153, 41),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  project.projectName??"",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontFamily: AppFont.fontFamily,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildDateColumn("Starting_Date", project.startDate!),
                                    _buildDateColumn("Ending_Date", project.endDate!, color: Colors.red),
                                  ],
                                ),
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
      )
          ],
        ));
  }
  Widget _buildDateColumn(String label, DateTime date, {Color color = Colors.white}) {
  return Column(
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
      Text(
        date.toString().substring(0, 11),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    ],
  );
}
}
