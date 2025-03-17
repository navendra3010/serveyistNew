import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:surveyist/adminModel/taskModel.dart';
import 'package:surveyist/adminProvider/adminProjectProvider.dart';
import 'package:surveyist/admin_uI/createNewTaskUi.dart';
import 'package:surveyist/admin_uI/taskDetails.dart';
import 'package:intl/intl.dart';

class ProjectDetailui extends StatefulWidget {
  String projectId;
  String documentId;

  ProjectDetailui(
      {super.key, required this.projectId, required this.documentId});
  @override
  State<ProjectDetailui> createState() => _MyProjectDetailsUi();
}

class _MyProjectDetailsUi extends State<ProjectDetailui> {
  @override
  void initState() {
    super.initState();
    Provider.of<Projectprovider>(context, listen: false)
        .listenAllProjectDetail(widget.projectId, widget.documentId);

    Provider.of<Projectprovider>(context, listen: false)
        .listenTask(widget.projectId, widget.documentId);
  }

  @override
  Widget build(BuildContext context) {
    final pdprovider = Provider.of<Projectprovider>(context,listen: true).selectedProject;
    final thisPageProvider = Provider.of<Projectprovider>(context,listen: false);

    if (pdprovider == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 4 / 100,
                        width: MediaQuery.of(context).size.width * 100 / 100,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text(
                            "${pdprovider.projectName}",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w600),
                          )
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 1 / 100,
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_pin),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 5 / 100,
                          ),
                          Text("${pdprovider.projectLocation}"),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 2 / 100,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Description",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green)),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 1 / 100,
                            ),
                            Text(
                              "${pdprovider.projectDiscription}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ]),
                    ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              TextButton(
                onPressed: () {
                  thisPageProvider.showAndHideTeam();
                },
                child: Text(
                    "${thisPageProvider.isShowTeam == false ? "View_team" : "Hide_ Team"}",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.green)),
              ),
              thisPageProvider.isShowTeam == true
                  ? SizedBox(
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: pdprovider.team!.length,
                          itemBuilder: (context, index) {
                            List<Map<String, dynamic>>? team = pdprovider.team;
                            final user = team![index];

                            return Column(
                              children: [
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        5 /
                                        100,
                                    width: MediaQuery.of(context).size.width *
                                        20 /
                                        100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: const Color.fromARGB(
                                            255, 221, 209, 209)),
                                    child: Center(child: Text(user["name"]))),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      25 /
                                      100,
                                ),
                              ],
                            );
                          }),
                    )
                  : SizedBox(),
              Container(
                height: MediaQuery.of(context).size.height * 0.3 / 100,
                width: MediaQuery.of(context).size.width * 100 / 100,
                color: const Color.fromARGB(255, 218, 217, 216),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Createnewtask(
                              projectId: widget.projectId,
                              documentId: widget.documentId),
                        ));
                  },
                  child: Text("Create_Task")),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              thisPageProvider.task.isEmpty
                  ? Center(
                      child: Text("Dont_Have_Any_Task"),
                    )
                  : SingleChildScrollView(
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
                                itemCount: thisPageProvider.task.length,
                                itemBuilder: (context, index) {
                                  final taskData = thisPageProvider.task[index]
                                      ["data"] as TaskModel;
                                  final taskId =
                                      thisPageProvider.task[index]["taskId"];

                                  DateTime? startDate = taskData.taskStartDate;
                                  String? formattedStartDate =
                                      DateFormat('dd-MM-yyyy')
                                          .format(startDate!);
                                  DateTime? EndDate = taskData.taskEndDate;
                                  String? formattedEndtDate =
                                      DateFormat('dd-MM-yyyy').format(EndDate!);

                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TaskDetailsUi(
                                                projectID: widget.projectId,
                                                documentID: widget.documentId,
                                                taskID: taskId),
                                          ));
                                    },
                                    child: Card(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              //  Text("TasK_Name"),
                                              Text("${taskData.taskName}"),
                                              Text(
                                                "${taskData.status}",
                                                style: TextStyle(
                                                    color: taskData.status ==
                                                            "pending"
                                                        ? Colors.red
                                                        : Colors.green),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text("${formattedStartDate}"),
                                              Text("${formattedEndtDate}"),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
