import 'dart:async';

import 'package:flutter/material.dart';
import 'package:surveyist/adminModel/projectModel.dart';
import 'package:surveyist/adminModel/taskModel.dart';
import 'package:surveyist/userFireStoreService/userFireStore.dart';

class UserProjectProviderClass extends ChangeNotifier {
  FireStoreServiceClass fireStoreService = FireStoreServiceClass();
  List<Map<String, dynamic>> projectData = [];
// this function for fatch all project to assign to the user..........................................
  void allAssignProject() {
    fireStoreService.getAllAssignProject().listen((data) {
      projectData = data;
      notifyListeners();
    });
  }

  //date 25-2-2025 this provider function will fatch per project detail based on assigh them

  ProjectModel? _selectmodoel;
  ProjectModel? get selectModel => _selectmodoel;
  void userPerProjectDetails(String documentID, String projectID) {
    fireStoreService
        .getUserPerProjectDetails(documentID, projectID)
        .listen((data) {
      _selectmodoel = data;
      notifyListeners();
    });
  }

  //date this function will  fatch assigh task by admin per project....................................
  List<Map<String, dynamic>> taskPerProject = [];
  void userlistenTask(String documentID, String projectID) {
    fireStoreService.getUserListenTask(documentID, projectID).listen((data) {
      // print(" this is data task${data}");
      taskPerProject = data;

      notifyListeners();
    });
  }
  //date 25-2-2025 this funtion will fatch all details of task details.....................................

  TaskModel? _taskDetailModel;
  TaskModel? get taskDetailmopdel => _taskDetailModel;
  void listenTaskDetails(String taskId, String projectId, String documentId) {
    fireStoreService
        .getListenTaskDetails(taskId, projectId, documentId)
        .listen((data) {
      _taskDetailModel = data;
      notifyListeners();
    });
  }

  //Date 27-2-2025 user get notification all project when assigh the new tAsk any project---------------------------------------------------------
  List<Map<String, dynamic>> tolist = [];
  List<Map<String, dynamic>> previousList = [];
  List<Map<String, dynamic>> finalList = [];
  void taskUpdatePerProject() {
    fireStoreService.getTaskUpdatedPerProject().listen((data) {
      tolist = data;
      notifyListeners();
      // previousList = List.from(tolist);
      // tolist = List<Map<String, dynamic>>.from(data);
      //  List<Map<String, dynamic>> newItems = tolist.where((newItem) {
      //   // Here we compare by assuming each item has a unique 'id'
      //   return !previousList.any((oldItem) => oldItem['taskUniqiueId'] == newItem['taskUniqiueId']);
      // }).toList();
      // //print(tolist);
      // finalList=newItems;
      //  notifyListeners();

      //   if (newItems.isNotEmpty) {
      //   print('New items added:');
      //   newItems.forEach((item) {
      //     print(item); // This will print the new item that was added
      //   });
      // } else {
      //   print('No new items added');
      // }
    });
  }

//date 28-2-2025 -------------------------this function submit the task ......................................

  void submitTask(String taskId, String documentId, String projectId) {
    fireStoreService.setSubmitTask(taskId, documentId, projectId);

    notifyListeners();
  }

  // this function fatch all task all project ...................................................................
  List<Map<String, dynamic>> historyOfTask = [];
  void allProjectTask() {
    fireStoreService.getAllProjectTask().listen((data) {
      historyOfTask = data;
      notifyListeners();
      print(data.length);
    });
  }
}
