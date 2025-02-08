import 'package:flutter/material.dart';
import 'package:surveyist/admin_uI/adminDashboard.dart';
import 'package:surveyist/admin_uI/adminProfile.dart';
import 'package:surveyist/admin_uI/projectOverViewUI.dart';
import 'package:surveyist/admin_uI/viewAllUser.dart';
import 'package:surveyist/utils/appConstant.dart';


class AppFooterUi extends StatelessWidget {
  const AppFooterUi(
      {required this.notificationCount, required this.selectMenu, super.key});

  final ButtomMenu selectMenu;
  final int? notificationCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 7 / 100,
      // width: MediaQuery.of(context).size.width*100/100,
      width: double.infinity,
      decoration:BoxDecoration(
         border:Border.all(width:1,color:Colors.grey),
         borderRadius:BorderRadius.circular(20),
        color:Colors.white
       //  color: const Color.fromARGB(255, 228, 153, 41),
      ),
     // color: const Color.fromARGB(255, 78, 78, 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              if (ButtomMenu.home != selectMenu) print("home page");

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdminDashboardPage()));
            },
            child: Container(child: Icon(Icons.home,color:ButtomMenu.home!=selectMenu?Colors.black:Colors.grey)),
          ),
          InkWell(
            onTap: () {
              if (ButtomMenu.users != selectMenu)
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => viewAllUserpage()));
            },
            child: Container(child: Icon(Icons.person,color:ButtomMenu.users!=selectMenu?Colors.black:Colors.grey)),
          ),
          InkWell(
            onTap: () {
              if (ButtomMenu.ProjectOverView != selectMenu)
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProjectOverView()));
            },
            child: Container(child: Icon(Icons.create,color:ButtomMenu.ProjectOverView!=selectMenu?Colors.black:Colors.grey)),
          ),
          InkWell(
            onTap: () {
              if (ButtomMenu.profile != selectMenu)
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminProfilePage()));
            },
            child: Container(child: Icon(Icons.circle,color:ButtomMenu.profile!=selectMenu?Colors.black:Colors.grey)),
          ),
        ],
      ),
    );
  }
}
