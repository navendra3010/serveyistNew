import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/adminModel/task_model.dart';
import 'package:surveyist/userProviders/userProjectProvider.dart';
import 'package:surveyist/users_UI/userTaskDetails.dart';

class UserProjectDetailUi extends StatefulWidget {
  String projectID;
  String documentID;
  UserProjectDetailUi(
      {super.key, required this.projectID, required this.documentID});

  @override
  State<UserProjectDetailUi> createState() => _UserProjectDetailUiState();
}

class _UserProjectDetailUiState extends State<UserProjectDetailUi> {
  @override
  void initState() {
    super.initState();
    //this will fatch project details...........
    Provider.of<UserProjectProviderClass>(context, listen: false)
        .userPerProjectDetails(widget.documentID, widget.projectID);
    // this wil fatch all fatch asssigh to this project..............
    Provider.of<UserProjectProviderClass>(context, listen: false)
        .userlistenTask(widget.documentID, widget.projectID);
  }

  @override
  Widget build(BuildContext context) {
    final userProjectProvider =
        Provider.of<UserProjectProviderClass>(context).selectModel;
    final tasprovider =
        Provider.of<UserProjectProviderClass>(context, listen: false);

    if (userProjectProvider == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
        body: Container(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 5 / 100,
            ),
            Container(
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back)),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.amber),
                    child: Center(
                      child: Text(
                        "${userProjectProvider.projectName}",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.location_pin),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 5 / 100,
                        ),
                        Text("${userProjectProvider.projectLocation}"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
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
                            "${userProjectProvider.projectDiscription}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2 / 100,
                    width: MediaQuery.of(context).size.width * 90 / 100,
                    decoration: BoxDecoration(color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
            // task detail enter............................................................date
            tasprovider.taskPerProject.isEmpty
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
                            width: MediaQuery.of(context).size.width * 90 / 100,
                            child: ListView.builder(
                              shrinkWrap: true,
                              primary: true,
                              itemCount: tasprovider.taskPerProject.length,
                              itemBuilder: (context, index) {
                                //  final taskdet=tasprovider.taskPerProject[index]["data"];
                                //  final taskId=tasprovider.taskPerProject[index]["taskId"];
                                final taskData =
                                    tasprovider.taskPerProject[index]["data"];
                                final taskId =
                                    tasprovider.taskPerProject[index]["taskId"];
                                final projectId = tasprovider
                                    .taskPerProject[index]["projectId"];
                                final documentId = tasprovider
                                    .taskPerProject[index]["documentId"];
                                print("task id-------------------${taskId}");
                                print(" project id--------------${projectId}");
                                print(
                                    " document id-----------------------${documentId}");

                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                userTaskDetailsUi(
                                                    taskId: taskId,
                                                    projectId: projectId,
                                                    documentId: documentId)));
                                  },
                                  child: Card(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(taskData["taskName"]),
                                            Text(taskData["status"],style:TextStyle(color:taskData["status"]=="completed"?Colors.green:Colors.red),),
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
    ));
  }
}
