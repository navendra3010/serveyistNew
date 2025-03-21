import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyist/adminModel/project_model.dart';
import 'package:surveyist/adminModel/task_model.dart';
import 'package:surveyist/userModel/user_profile_model.dart';

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
      List<Map<String, dynamic>> filter = [];
      for (var taskDoc in snapshot.docs) {
        filter.add({
          "taskId": taskDoc.id,
          "projectId": projectID,
          "documentId": documentID,
          "data": taskDoc.data(),
        });
      }
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? userID = pref.getString("userId");
      List<Map<String, dynamic>> filtered = filter.where((map) {
        return map['data']['assignTo'] == userID;
      }).toList();
      allTask = filtered;

      return allTask;
    });
  }

// date 25-2-2025 this function fatch all details for task.....................................
  Stream<TaskModel?> getListenTaskDetails(
      String taskId, String projectId, String documentId) {
    return _store
        .collection("Project")
        .doc(documentId)
        .collection("task")
        .doc(taskId)
        .snapshots()
        .map((snap) => snap.exists ? TaskModel.formJson(snap) : null);
  }

  //Date 27-2-2025 user get notification all project when assigh the new tAsk any project---------------------------------------------------------
  Stream<List<Map<String, dynamic>>> getTaskUpdatedPerProject() {
    return _store.collection("Project").snapshots().asyncMap((snapshot) async {
      List<Map<String, dynamic>> allupdatedResult = [];
      List<Map<String, dynamic>> filterUpdate = [];
      for (var element in snapshot.docs) {
        final docResponse = await element.reference.collection("task").get();
        for (var docRef in docResponse.docs) {
          filterUpdate.add({
            "taskUniqiueId": docRef.id,
            "data": docRef.data(),
          });
        }
        SharedPreferences pref = await SharedPreferences.getInstance();
        String? userID = pref.getString("userId");
        List<Map<String, dynamic>> filteredTask = filterUpdate.where((map) {
          return map["data"]["assignTo"] == userID;
        }).toList();
        allupdatedResult = filteredTask;
      }
      return allupdatedResult;
    });
  }

//date this funcation submit the complete task.............................
  void setSubmitTask(String taskId, String documentId, String projectId) {
    _store
        .collection("Project")
        .doc(documentId)
        .collection("task")
        .doc(taskId)
        .update({"status": "completed"});
  }

  Stream<List<Map<String, dynamic>>> getAllProjectTask() {
    return _store.collection("Project").snapshots().asyncMap((snapshot) async {
      List<Map<String, dynamic>> history = [];

      List<Map<String, dynamic>> updateHistory = [];
      for (var element in snapshot.docs) {
        final dofreffrece = await element.reference.collection("task").get();
        for (var docRef in dofreffrece.docs) {
          //  print(docRef.data());
          updateHistory.add({"data": docRef.data()});
        }

        SharedPreferences pref = await SharedPreferences.getInstance();
        String? userID = pref.getString("userId");
        List<Map<String, dynamic>> filteredhistory = updateHistory.where((map) {
          return map["data"]["assignTo"] == userID;
        }).toList();
        history = filteredhistory;
      }
      return history;
    });
  }

//date 3-3-2025 this function fatch  userAcoount details from admin account...................................
  Stream<Userprofilemodel?> getFacthUserAccountDetails(String? userID) {
    try {
      if (userID == null) {
        throw ArgumentError('User ID cannot be null');
      }
      return _store.collection("allusers").doc(userID).snapshots().map(
          (snapshot) => snapshot.exists
              ? Userprofilemodel.fromFireStore(snapshot)
              : null);
    } catch (e) {
      //print('Error fetching user details: $e');
      rethrow;
    }
  }

  // Future<void> getNews() async {
  //   try {
  //     final response = await http.get(Uri.parse(
  //         'https://newsapi.org/v2/everything?q=tesla&from=2025-03-19&to=2025-03-19&sortBy=popularity&apiKey=26fa926270e944a0b0d9b8af77fd2609'));

  //           var data=json.decode(response.body);
  //           print(data);

  //    // print(response.body);
  //   } catch (e) {
  //     print(e);
  //   }
  //}
}
