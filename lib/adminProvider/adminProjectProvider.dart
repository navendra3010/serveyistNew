import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:surveyist/adminModel/projectModel.dart';
import 'package:surveyist/adminProvider/fireStoreServiceforAdmin/fireStoreserAdmin.dart';
import 'package:surveyist/admin_uI/projectOverViewUI.dart';
import 'package:surveyist/utils/app_Language.dart';

import '../utils/appSnackBarOrToastMessage.dart';

class Projectprovider extends ChangeNotifier {
  TextEditingController dateStartcontroller = TextEditingController();
  TextEditingController dateEndcontroller = TextEditingController();
  FireStoreServiceForAdmin fireser = FireStoreServiceForAdmin();
  DateTime startDate = DateTime.now();

  DateTime endDate = DateTime.now();
  bool isShowItem = false;

  Future selectprojectStartDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2027));

    if (picked != null) {
      dateStartcontroller.text = formate(picked);
      notifyListeners();
    }
  }

  Future selectprojectEndDate(BuildContext context) async {
    DateTime? end = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2027));

    if (end != null) {
      dateEndcontroller.text = formate(end);
      notifyListeners();
    }
  }

  String formate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
   //this provider function for create new project by admin each time...........................................
  //function provider for add project......
  bool loadUser = false;
  Future<void> addProjectProvider(
      ProjectModel obj, BuildContext context) async {
    if (obj.projectName == "" || obj.projectName == null) {
      ShowTaostMessage.toastMessage(context, " Enter_project_name is nul");
    } else if (obj.projectLocation == "" || obj.projectLocation == null) {
      ShowTaostMessage.toastMessage(context, "Enter_loaction ");
    } else if (obj.startDate == "" || obj.startDate == null) {
      ShowTaostMessage.toastMessage(context, "Enter_Project_start_Date");
    } else if (obj.endDate == "" || obj.endDate == null) {
      ShowTaostMessage.toastMessage(context, "Enter_Project_end_Date");
    } else if (obj.projectDiscription == "" || obj.projectDiscription == null) {
      ShowTaostMessage.toastMessage(context, "Enter_Project_Descriptions");
    } else {
      loadUser = true;
      notifyListeners();
      // print(obj.toJson());
      fireser.createProject(obj.toJson());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProjectOverView()),
      );
     
    }
  }

//this stream for display alll users  for create team................................
  Stream<List<Map<String, dynamic>>> teamUser() {
    return fireser.getTeam();
  }

//this list when admin select user store there
  List<Map<String, dynamic>> selectUserIdForTeam = [];

  final StreamController<List<Map<String, dynamic>>> _userStreamController =
      StreamController<List<Map<String, dynamic>>>.broadcast();

  Stream<List<Map<String, dynamic>>> get userStream =>
      _userStreamController.stream;

  //toggel for select users.............................................
  void toggleUserId(String userId, String userName, String employeId) {
    Map<String, String> userData = {
      "userId": userId,
      "name": userName,
      "empId": employeId
    };

    if (selectUserIdForTeam.any((user) => user["userId"] == userId)) {
      selectUserIdForTeam.removeWhere((user) => user["userId"] == userId);

      notifyListeners();
    } else {
      selectUserIdForTeam.add(userData);

      // notifyListeners();
    }
    _userStreamController.sink.add(selectUserIdForTeam);

    notifyListeners();
  }
  //this function for show all project from project over view page.....................................
  Future<void>  getAllProjectProvider()async
  {
    print("providr calling");
    await fireser.getAllProjectFireStore();
  }
}
