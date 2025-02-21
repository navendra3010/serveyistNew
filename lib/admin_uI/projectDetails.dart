import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/adminProvider/adminProjectProvider.dart';
import 'package:surveyist/admin_uI/createNewTaskUi.dart';

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
    print(widget.projectId);
    print(widget.documentId);
  }

  @override
  Widget build(BuildContext context) {
    final pdprovider = Provider.of<Projectprovider>(context).selectedProject;
    if (pdprovider == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "${pdprovider.projectName}",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.location_pin),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 5 / 100,
                            ),
                            Text("${pdprovider.projectLocation}"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 2 / 100,
                      ),
                      Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Description",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green)),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    1 /
                                    100,
                              ),
                              Text(
                                "${pdprovider.projectDiscription}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ]),
                      ),
                    ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              TextButton(
                onPressed: () {},
                child: Text("View_Team",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.green)),
              ),
              // view team member.......................................
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3 / 100,
                width: MediaQuery.of(context).size.width * 100 / 100,
                color: const Color.fromARGB(255, 218, 217, 216),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              SizedBox(
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
                              height:
                                  MediaQuery.of(context).size.height * 5 / 100,
                              width:
                                  MediaQuery.of(context).size.width * 20 / 100,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color:
                                      const Color.fromARGB(255, 221, 209, 209)),
                              child: Center(child: Text(user["name"]))),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 25 / 100,
                          ),
                        ],
                      );
                    }),
              ),
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
                  child: Text("Create_Task"))
            ],
          ),
        ),
      ),
    );
  }
}
