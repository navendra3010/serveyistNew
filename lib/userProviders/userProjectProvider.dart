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
      print(projectData);
    });

  }

  //date 25-2-2025 this provider function will fatch per project detail based on assigh them 
 
 ProjectModel? _selectmodoel;
 ProjectModel? get selectModel=>_selectmodoel;
   void userPerProjectDetails(String documentID, String projectID)
   {
    fireStoreService.getUserPerProjectDetails(documentID,projectID).listen((data){
      _selectmodoel=data;
      notifyListeners();
    });

   }
   //date this function will  fatch assigh task by admin per project....................................
      List<Map<String,dynamic>> taskPerProject=[];
   void userlistenTask(String documentID, String projectID)
   {
    fireStoreService.getUserListenTask(documentID,projectID).listen((data){
     // print(" this is data task${data}");
      taskPerProject=data;
      
      notifyListeners();

    });
   }
 //date 25-2-2025 this funtion will fatch all details of task details.....................................

 TaskModel? _taskDetailModel;
 TaskModel? get taskDetailmopdel=>_taskDetailModel;
  void listenTaskDetails(String taskId, String projectId, String documentId) 
  {

    fireStoreService.getListenTaskDetails(taskId,projectId,documentId).listen((data){
      _taskDetailModel=data;
      notifyListeners();
    });

  }

}
