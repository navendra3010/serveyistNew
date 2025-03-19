// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';

import 'package:surveyist/users_UI/user_work_history.dart';
import 'package:surveyist/users_UI/user_dashboard.dart';

import 'package:surveyist/users_UI/users_profile_ui.dart';
import 'package:surveyist/utils/app_constant.dart';


class FooterUiForUsers extends StatelessWidget {
 const  FooterUiForUsers(
      {required this.selectMenu2, super.key,this.notificationCount});

  final ButtomMenu2 selectMenu2;
  final int? notificationCount;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 7 / 100,
      // width: MediaQuery.of(context).size.width*100/100,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white),
      // color: const Color.fromARGB(255, 78, 78, 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              if (ButtomMenu2.userHome != selectMenu2) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserDashBoardScreen()));
              }
            },
            child: Icon(Icons.home,
                    color: ButtomMenu.home != selectMenu2
                        ? Colors.black
                        : Colors.grey)),
          
          InkWell(
            onTap: () {
              if (ButtomMenu2.userWorkHistory != selectMenu2) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const UserWorkHistory()));
              }
            },
            child: Icon(Icons.camera,
                    color: ButtomMenu.users != selectMenu2
                        ? Colors.black
                        : Colors.grey)),
          
          // InkWell(
          //   onTap: () {
          //     if (ButtomMenu2.progess != selectMenu2)
          //       Navigator.pushReplacement(context,
          //           MaterialPageRoute(builder: (context) => WorkProgess()));
          //   },
          //   child: Container(
          //       child: Icon(Icons.create,
          //           color: ButtomMenu.ProjectOverView != selectMenu2
          //               ? Colors.black
          //               : Colors.grey)),
          // ),
          InkWell(
            onTap: () {
              if (ButtomMenu2.userprofile != selectMenu2) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UsersprofilePage()));
              }
            },
            child: Icon(Icons.person,
                    color: ButtomMenu.profile != selectMenu2
                        ? Colors.black
                        : Colors.grey)),
          
        ],
      ),
    );
  }
}
