import 'package:flutter/material.dart';
import 'package:surveyist/admin_uI/adminDashboard.dart';
import 'package:surveyist/admin_uI/adminProfile.dart';
import 'package:surveyist/admin_uI/projectOverViewUI.dart';
import 'package:surveyist/admin_uI/viewAllUser.dart';
import 'package:surveyist/users_UI/UserWorkHistory.dart';
import 'package:surveyist/users_UI/userDashboard.dart';
import 'package:surveyist/users_UI/userWorkProgess.dart';
import 'package:surveyist/users_UI/usersProfileUi.dart';
import 'package:surveyist/utils/appConstant.dart';
import 'package:surveyist/utils/appImage.dart';

class footerUiForUsers extends StatelessWidget {
   footerUiForUsers(
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
              if (ButtomMenu2.userHome != selectMenu2)
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserDashBoardScreen()));
            },
            child: Container(
                child: Icon(Icons.home,
                    color: ButtomMenu.home != selectMenu2
                        ? Colors.black
                        : Colors.grey)),
          ),
          InkWell(
            onTap: () {
              if (ButtomMenu2.UserWorkHistory != selectMenu2)
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => UserWorkHistory()));
            },
            child: Container(
                child: Icon(Icons.camera,
                    color: ButtomMenu.users != selectMenu2
                        ? Colors.black
                        : Colors.grey)),
          ),
          InkWell(
            onTap: () {
              if (ButtomMenu2.progess != selectMenu2)
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => WorkProgess()));
            },
            child: Container(
                child: Icon(Icons.create,
                    color: ButtomMenu.ProjectOverView != selectMenu2
                        ? Colors.black
                        : Colors.grey)),
          ),
          InkWell(
            onTap: () {
              if (ButtomMenu2.userprofile != selectMenu2)
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UsersprofilePage()));
            },
            child: Container(
                child: Icon(Icons.person,
                    color: ButtomMenu.profile != selectMenu2
                        ? Colors.black
                        : Colors.grey)),
          ),
        ],
      ),
    );
  }
}
