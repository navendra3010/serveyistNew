import 'dart:io';

import 'package:flutter/material.dart';

import 'package:surveyist/admin_uI/createNewUsersUi.dart';
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
        const Color.fromARGB(255, 221, 187, 138),
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
