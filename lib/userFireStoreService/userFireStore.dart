import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyist/adminModel/projectModel.dart';
import 'package:surveyist/adminModel/taskModel.dart';

class FireStoreServiceClass {
  final _store = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getAllAssignProject() {
    return _store.collection("Project").snapshots().asyncMap((sanp) async {
      List<Map<String, dynamic>> allpro = [];
      for (var projectDoc in sanp.docs) {
        var taskcollection =
            await projectDoc.reference.collection("P_Name").get();
        for (var pNameDoc in taskcollection.docs) {
          Map<String, dynamic> data = pNameDoc.data();
          List team = data["team"] ?? [];
          SharedPreferences pref = await SharedPreferences.getInstance();
          String? userID = pref.getString("userId");
          bool isuserLoggedIn =
              team.any((member) => member["userId"] == userID);
          if (isuserLoggedIn) {
            allpro.add({
              "projectId": pNameDoc.id,
              "documentId": projectDoc.id,
              "data": ProjectModel.fromJson(pNameDoc),
            });
          }
        }
      }
      return allpro;
    });
  }

//date 25-2-2025 this function project details per project.......................................
  Stream<ProjectModel?> getUserPerProjectDetails(
      String documentID, String projectID) {
    return _store
        .collection("Project")
        .doc(documentID)
        .collection("P_Name")
        .doc(projectID)
        .snapshots()
        .map((snapshot) =>
            snapshot.exists ? ProjectModel.fromJson(snapshot) : null);
  }

  // date 25-2-2025  this function  listen ptask based on project................................................
  Stream<List<Map<String, dynamic>>> getUserListenTask(
      String documentID, String projectID) {
    return _store
        .collection("Project")
        .doc(documentID)
        .collection("task")
        .snapshots()
        .asyncMap((snapshot) async {
      List<Map<String, dynamic>> allTask = [];
      List<Map<String,dynamic>> filter=[];
      for (var taskDoc in snapshot.docs) {
           

        filter.add({
          "taskId":taskDoc.id,
          "projectId":projectID,
          "documentId":documentID,
          "data":taskDoc.data(),
        });
      }
        SharedPreferences pref = await SharedPreferences.getInstance();
          String? userID = pref.getString("userId");
          List<Map<String,dynamic>> filtered=filter.where((map){

            return map['data']['assignTo'] == userID;
          }).toList();
          allTask=filtered;
     

      return allTask;
    });
  }
// date 25-2-2025 this function fatch all details for task.....................................
  Stream<TaskModel?> getListenTaskDetails(String taskId, String projectId, String documentId) {

    return _store.collection("Project").doc(documentId).collection("task").doc(taskId).snapshots().map((snap)=>snap.exists? TaskModel.FormJson(snap):null);
  }
}
