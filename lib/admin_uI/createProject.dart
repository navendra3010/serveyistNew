import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surveyist/utils/TextSyle.dart';
import 'package:surveyist/utils/appButton.dart';
import 'package:surveyist/utils/appConstant.dart';
import 'package:surveyist/utils/appFont.dart';
import 'package:surveyist/utils/appFooter.dart';
import 'package:surveyist/utils/appImage.dart';
import 'package:surveyist/utils/dateFormates.dart';
import 'package:surveyist/utils/footerForUsers.dart';

class CreateProjectPage extends StatefulWidget {
  CreateProjectPage({super.key});

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
           SizedBox(
              height: MediaQuery.of(context).size.height * 5 / 100,
            ),
          Center(
            child: Container(
               height: MediaQuery.of(context).size.height * 5/ 100,
                width: MediaQuery.of(context).size.width * 100 / 100,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 221, 187, 138),
                    borderRadius: BorderRadius.all(Radius.circular(80))),
                    child:Center(child: Text("Project_overview",  style: CustomText.nameOfTextStyle,)),
            ),
          ),
        ],
      ),
      
       bottomNavigationBar:
          AppFooterUi(notificationCount: 0, selectMenu: ButtomMenu.createProject),
    );
    
  }
}