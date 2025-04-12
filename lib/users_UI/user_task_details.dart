// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:surveyist/userProviders/user_project_provider.dart';
import 'package:surveyist/users_UI/user_all_project_ui.dart';

import 'package:surveyist/utils/app_button.dart';
import 'package:surveyist/utils/app_font.dart';
import 'package:surveyist/utils/app_snack_bar_or_toast_message.dart';

class UserTaskDetailsUi extends StatefulWidget {
  final taskId;
  final projectId;
  final documentId;
 const UserTaskDetailsUi(
      {super.key,
      required this.taskId,
      required this.projectId,
      required this.documentId});

  @override
  State<UserTaskDetailsUi> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UserTaskDetailsUi> {
  TextEditingController taskfeedbackController=TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<UserProjectProviderClass>(context, listen: false)
        .listenTaskDetails(widget.taskId, widget.projectId, widget.documentId);
  }

  @override
  Widget build(BuildContext context) {
    final taskDetailsProvider =
        Provider.of<UserProjectProviderClass>(context).taskDetailmopdel;
    final detailProvider =
        Provider.of<UserProjectProviderClass>(context, listen: false);

    if (taskDetailsProvider == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
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
                    
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.amber),
                      child: Center(
                        child: Text(
                          "${taskDetailsProvider.taskName}",
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
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
                        "${taskDetailsProvider.taskDescription}",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                      SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    Center(
                      child: TextFormField(
                        controller:taskfeedbackController,
                  decoration: const InputDecoration(
                      hintText: "Work_ Report",
                      hintStyle:
                          TextStyle(fontSize: 12, fontFamily: AppFont.fontFamily),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                    )
                  ],
                ),

              
              
              SizedBox(
                height: MediaQuery.of(context).size.height * 10 / 100,
              ),
            MyButton(
                text: "Submit Task",
                color: Colors.amber,
                onPressed: () {
                   if(taskfeedbackController.text.trim().isEmpty)
                   {
                     ShowTaostMessage.toastMessage(context,"fill task report");

                   }
                   else
                   {
                          detailProvider.submitTask(
                      widget.taskId, widget.documentId, widget.projectId,taskfeedbackController.text.trim());
                       Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const UserAllProject(),
                                    ));
                 
                   }
                  // detailProvider.submitTask(
                  //     widget.taskId, widget.documentId, widget.projectId);
                  //      Navigator.pushReplacement(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                     builder: (context) => const UserAllProject(),
                  //                   ));
                 
                      
                },
              ),
            ],
          ),
        ),
      
    );
  }
}
