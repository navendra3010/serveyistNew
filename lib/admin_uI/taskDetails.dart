import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/adminProvider/adminProjectProvider.dart';

class TaskDetailsUi extends StatefulWidget {
  String projectID;
  String documentID;
  String taskID;

  TaskDetailsUi(
      {super.key,
      required this.projectID,
      required this.documentID,
      required this.taskID});

  @override
  State<TaskDetailsUi> createState() => _TaskDetailsUiState();
}

class _TaskDetailsUiState extends State<TaskDetailsUi> {
  @override
  void initState() {
    super.initState();
    Provider.of<Projectprovider>(context, listen: false)
        .taskDetails(widget.projectID, widget.documentID, widget.taskID);
  }
  DateTime? now;

  @override
  Widget build(BuildContext context) {
    final taskdDetailProvider =
        Provider.of<Projectprovider>(context).selectTaskModel;
    if (taskdDetailProvider == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
        body: Container(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 5 / 100,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back)),
                  ),
                  Center(
                    child: Text(
                      "${taskdDetailProvider.taskName}",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ),
                   SizedBox(
              height: MediaQuery.of(context).size.height * 3 / 100,
            ),
                  Center(
                    child: Text("Description",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.green)),
                  ),
                   SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
                  Center(
                    child: Text(
                      "${taskdDetailProvider.taskDescription}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 226, 195, 103)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Status",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 175, 87, 76))),
                        Text("${taskdDetailProvider.status}"),
                      ],
                    ),
                  ),
                   

                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
