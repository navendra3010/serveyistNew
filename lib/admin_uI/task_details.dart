// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/adminProvider/admin_project_provider.dart';

class TaskDetailsUi extends StatefulWidget {
  final projectID;
  final documentID;
  final taskID;

 const TaskDetailsUi(
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
        Provider.of<Projectprovider>(context, listen: true).selectTaskModel;

    if (taskdDetailProvider == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return  Scaffold(
        body: Padding(
        padding:const EdgeInsets.all(5.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 5 / 100,
            ),
             Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                  
                 Center(
                    child: Text(
                      "${taskdDetailProvider.taskName}",
                      style:
                          const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 3 / 100,
                  ),
                  const Center(
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
                          const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 100,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 226, 195, 103)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Status",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 175, 87, 76))),
                        Text("${taskdDetailProvider.status}"),
                      ],
                    ),
                  ),
                ],
              ),
            
          ],
        ),
      
    ));
  }
}
