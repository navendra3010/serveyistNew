import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/adminModel/projectModel.dart';
import 'package:surveyist/adminProvider/adminProjectProvider.dart';

import 'package:surveyist/admin_uI/newPrjectUI.dart';
import 'package:surveyist/utils/TextSyle.dart';
import 'package:surveyist/utils/appConstant.dart';

import 'package:surveyist/utils/appFooter.dart';

class ProjectOverView extends StatefulWidget {
  ProjectOverView({super.key});

  @override
  State<ProjectOverView> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<ProjectOverView> {
  @override
  Widget build(BuildContext context) {
    final overViewProvider = Provider.of<Projectprovider>(context);
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
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 30 / 100,
              width: MediaQuery.of(context).size.width * 90 / 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: const Color.fromRGBO(255, 250, 250, 1)),
              child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: overViewProvider.getAllStreamProjects(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text("No_Project_yet");
                    }

                    List<Map<String, dynamic>> project = snapshot.data!;
                    return ListView.builder(
                    
                      itemCount: project.length,
                      itemBuilder: (context, index) {
                        final proj = project[index];

                        return Container(
                          height: MediaQuery.of(context).size.height * 6 / 100,
                          width: MediaQuery.of(context).size.width * 9 / 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                           // color: const Color.fromARGB(255, 221, 187, 138),
                          ),
                          child: Card(
                            child: Column(
                              children: [
                                Text("${proj["projectLocation"]}"),
                              
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ),
          // Center(
          //   child: Container(
          //     height: MediaQuery.of(context).size.height * 30 / 100,
          //     width: MediaQuery.of(context).size.width * 90 / 100,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.all(Radius.circular(20)),
          //         color: const Color.fromRGBO(255, 250, 250, 1)),
          //     child: StreamBuilder<List<ProjectModel>>(
          //         stream: overViewProvider.getLoadProject(),
          //         builder: (context, snapshot) {
          //           if (snapshot.connectionState == ConnectionState.waiting) {
          //             return CircularProgressIndicator();
          //           }
          //           if (!snapshot.hasData || snapshot.data!.isEmpty) {
          //             return Text("No_Project_yet");
          //           }

          //           var user = snapshot.data!;
          //           return ListView.builder(
                    
          //             itemCount: user.length,
          //             itemBuilder: (context, index) {
          //               final proj = user[index];

          //               return Container(
          //                 height: MediaQuery.of(context).size.height * 6 / 100,
          //                 width: MediaQuery.of(context).size.width * 9 / 100,
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(10),
          //                  // color: const Color.fromARGB(255, 221, 187, 138),
          //                 ),
          //                 child: Card(
          //                   child: Column(
          //                     children: [
          //                       Text("${proj.projectName}"),
                              
          //                     ],
          //                   ),
          //                 ),
          //               );
          //             },
          //           );
          //         }),
          //   ),
          // ),
          Center(
            child: TextButton(
                onPressed: () {
                  overViewProvider.getAllProjectProvider();
                },
                child: Text("get_users")),
          ),
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
