import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:surveyist/adminModel/projectModel.dart';
import 'package:surveyist/adminProvider/fireStoreServiceforAdmin/fireStoreserAdmin.dart';

class Projectprovider extends ChangeNotifier {
  TextEditingController dateStartcontroller = TextEditingController();
  TextEditingController dateEndcontroller = TextEditingController();
  FireStoreServiceForAdmin fireser = FireStoreServiceForAdmin();
  DateTime startDate = DateTime.now();

  DateTime endDate = DateTime.now();

  //set project start date provider start---------------------------------------------------
  // void setDate(context) async {
  //   DateTime now = await selectprojectStartDate(context);
  //   // String selectDate = DateFormat('dd-MM-yyyy').format(now);
  //   // print(selectDate);
  //   // dateStartcontroller.text = selectDate;
  //   dateStartcontroller.text=DateFormat('dd-MM-yyyy').format(now);
  //   notifyListeners();
  // }

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

  //end----------------------------
  //set project starend date provider end---------------------------------------------------
  // void setEndDate(context) async {
  //   DateTime now = await selectprojectEndDate(context);
  //  // String selectDate = DateFormat('dd-MM-yyyy').format(now);
  //  // print(selectDate);
  //  // dateEndcontroller.text = selectDate;
  //  dateEndcontroller.text= DateFormat('dd-MM-yyyy').format(now);
  //   notifyListeners();
  // }

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

  // provider for all team
  List<dynamic>? team = [];

  Future<void> getTeam() async {
    print("working------------");
    List<dynamic> items = await fireser.createTeam();
    for (var element in items) {
      print(element);
    }
    team = items;
  }

  //function provider for add project......
  Future<void> addProjectProvider(ProjectModel pm) async {
    // fireser.addProject();
    //  ProjectModel p = ProjectModel();
    if (pm != null) {
      print(pm.projectName.toString());
      print(pm.projectLocation);
      print(pm.endDate);
      print(pm.startDate);
      print(pm.projectDiscription);
      print(pm.team);
      notifyListeners();
    } else {
      print("object null");
      notifyListeners();
    }
  }

//this stream for display alll users  for create team................................
  Stream<List<Map<String, dynamic>>> teamUser() {
    return fireser.getTeam();
  }

//this list when admin select user store there
  List<Map<String,dynamic>> selectUserIdForTeam = [];

  final StreamController<List<Map<String,dynamic>>> _userStreamController =
      StreamController<List<Map<String,dynamic>>>.broadcast();

  Stream<List<Map<String, dynamic>>> get userStream => _userStreamController.stream;

  //toggel for select users.............................................
  void toggleUserId(String userId, String userName, String employeId) {
    Map<String,String>userData={"userId":userId,"name":userName,"empId":employeId};

    if (selectUserIdForTeam.any((user)=>user["userId"]==userId) ){
      selectUserIdForTeam.removeWhere((user)=>user["userId"]==userId);
    } else {
      selectUserIdForTeam.add(userData);
    }
    _userStreamController.sink.add(selectUserIdForTeam);
    notifyListeners();
  }
}
