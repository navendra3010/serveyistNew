import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/adminModel/projectModel.dart';
import 'package:surveyist/userProviders/userProjectProvider.dart';
import 'package:surveyist/utils/appFont.dart';

class UserAllProject extends StatefulWidget {
  const UserAllProject({super.key});

  @override
  State<UserAllProject> createState() => _UserAllProjectUI();
}

class _UserAllProjectUI extends State<UserAllProject> {
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
            Container(
                child: Text(
              "Projects",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.amber),
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  2 /
                  100, // Spacing between items
            ),
            userProjectPro.projectData.isEmpty
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 40 / 100,
                              width:
                                  MediaQuery.of(context).size.width * 90 / 100,
                              child: ListView.builder(
                                shrinkWrap: true,
                                primary: true,
                                itemCount: userProjectPro.projectData.length,
                                itemBuilder: (context, index) {
                                  final project =
                                      userProjectPro.projectData[index]["data"]
                                          as ProjectModel;
                                  final projectId = userProjectPro
                                      .projectData[index]["projectId"];
                                  final docId = userProjectPro
                                      .projectData[index]["docId"];

                                  return InkWell(
                                      onTap: () {
                                        // print(userProjectPro.projectData[index]
                                        //     ["projectId"]);
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) => ProjectDetailui(projectId:projectId,documentId:docId),
                                        //     ));
                                      },

                                      // ),
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom:
                                                  10), // Space between items
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  7 /
                                                  100,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  38 /
                                                  100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: const Color.fromARGB(
                                                    255, 228, 153, 41),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                            8.0), // Inner padding
                                                    child: Text(
                                                      "${project.projectName}",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontFamily:
                                                            AppFont.fontFamily,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 4),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              "Starting_Date",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            Text(
                                                              "${project.startDate.toString().substring(0, 11)}",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              "Ending_Date",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                            Text(
                                                              "${project.endDate.toString().substring(0, 11)}",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ))));
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ));
  }
}
