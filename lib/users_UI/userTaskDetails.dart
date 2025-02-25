import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/userProviders/userProjectProvider.dart';

class userTaskDetailsUi extends StatefulWidget {
  String taskId;
  String projectId;
  String documentId;
  userTaskDetailsUi(
      {super.key,
      required this.taskId,
      required this.projectId,
      required this.documentId});

  @override
  State<userTaskDetailsUi> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<userTaskDetailsUi> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProjectProviderClass>(context,listen: false)
        .listenTaskDetails(widget.taskId, widget.projectId, widget.documentId);
  }

  @override
  Widget build(BuildContext context) {
    final taskDetailsProvider =
        Provider.of<UserProjectProviderClass>(context).taskDetailmopdel;

    if (taskDetailsProvider == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                    Container(
                       decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.amber),
                      child: Center(
                        child: Text(
                          "${taskDetailsProvider.taskName}",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
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
                        "${taskDetailsProvider.taskDescription}",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
