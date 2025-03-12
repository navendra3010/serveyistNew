import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyist/adminModel/allUsersModel.dart';
import 'package:surveyist/adminModel/projectModel.dart';
import 'package:surveyist/adminModel/taskModel.dart';
import 'package:surveyist/userModel/userProfilemodel.dart';

class FireStoreServiceForAdmin {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DateTime now = DateTime.now();
  //all  user ................................................

  Stream<List<ViewAllUsers>> getAllUsers() {
    return _firestore.collection("allusers").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        for (var element in snapshot.docs) {
          // print(element.data());
        }
        return ViewAllUsers.FromFireStore(doc);
      }).toList();
    });
  }

//all login on admin dasghbord.............................................
  Stream<List<QuerySnapshot<Map<String, dynamic>>>> getAllLoginUser(String dateKey) {
  
    if(dateKey.isEmpty)
    {
       String dateKey2 = DateFormat('dd-MM-yyyy').format(now);
        dateKey=dateKey2;
        
    }


    try {
      // Fetch all user documents from the root collection
      return _firestore
          .collection("userLoginRecordPerDay")
          .snapshots()
          .asyncMap((snapshot) async {
        // Fetch all login records for the given date for each user
        final loginStreams = await Future.wait(
          snapshot.docs.map((userDoc) async {
            return await _firestore
                .collection("userLoginRecordPerDay")
                .doc(userDoc.id)
                .collection('loginDates')
                .doc(dateKey)
                .collection('logins')
                .get();
          }).toList(),
        );
        return loginStreams; // Return the list of QuerySnapshot
      });
    } catch (e) {
      print(e);
      return Stream.empty();
    }
  }

  ///function for fatch user for team and display them........................................
  Stream<List<Map<String, dynamic>>> getTeam() {
    return _firestore.collection("allusers").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id!;
        //data[doc.id]=doc["full_name"]; cs
        return data;
      }).toList();
    });
  }

  //this function for create mainProject................................................
  Future<ProjectModel?> createProject(Map<String, dynamic> json) async {
    bool? status = await creteProjectWithCollectionRefrance(json);
    if (status == true) {
      print("data has been save");
    }
  }

//another function bases on prevoius funacatiion for project----------
  Future<bool?> creteProjectWithCollectionRefrance(
      Map<String, dynamic> json) async {
    try {
      FirebaseFirestore frbs = FirebaseFirestore.instance;
      DocumentReference df = frbs.collection("Project").doc();
      DocumentSnapshot snapshot = await df.get();
      if (!snapshot.exists) {
        await df.set({
          'created_AT': DateTime.now(),
        });
        print("project collection has been created");
      }
      DocumentReference df1 = df.collection("P_Name").doc();
      DocumentSnapshot ds = await df1.get();
      if (!ds.exists) {
        await df1.set({
          'created_AT': DateTime.now(),
        });
      }

      await df1.set(json);
      return true;
    } catch (e) {
      print("${e}");
    }
  }

  // Future<void> getAllProjectFireStore() async {
  //   try {
  //     // Get all projects
  //     QuerySnapshot projectSnapshot =
  //         await FirebaseFirestore.instance.collection("Project").get();

  //     if (projectSnapshot.docs.isEmpty) {
  //       print("No projects found!");
  //       return;
  //     }

  //     // Loop through each project
  //     for (var projectDoc in projectSnapshot.docs) {
  //       String projectId = projectDoc.id;
  //       print("Project ID: $projectId");

  //       // Get all P_Name documents inside the project
  //       QuerySnapshot pNameSnapshot = await FirebaseFirestore.instance
  //           .collection("Project")
  //           .doc(projectId)
  //           .collection("P_Name")
  //           .get();

  //       if (pNameSnapshot.docs.isEmpty) {
  //         print("No P_Name documents found in project $projectId");
  //       } else {
  //         for (var pNameDoc in pNameSnapshot.docs) {
  //           print(
  //               "P_Name Document ID: ${pNameDoc.id}, Data: ${pNameDoc.data()}");
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     print("Error fetching projects: $e");
  //   }
  // }

  // Stream<List<Map<String, dynamic>>> getAllproject() {
  //   try {
  //     return _firestore
  //         .collection("Project")
  //         .snapshots()
  //         .asyncMap((snapshot) async {
  //       List<Map<String, dynamic>> projectList = [];

  //       for (var userdoc in snapshot.docs) {
  //         // Fetch each project's details
  //         print(userdoc.id);
  //         var projectDoc = await _firestore
  //             .collection("Project")
  //             .doc(userdoc.id)
  //             .collection("P_Name")
  //             .get();
  //         for (var element in projectDoc.docs) {
  //           print(element.data());
  //           projectList.add(element.data());
  //         }
  //       }

  //       return projectList;
  //     });
  //   } catch (e) {
  //     print("Error fetching projects: $e");
  //     return Stream.value([]);
  //   }
  // }

//Date 18-2-2025 show project details and when click on button show another details of project........................
  Stream<List<Map<String, dynamic>>> allProject() {
    return _firestore
        .collection("Project")
        .snapshots()
        .asyncMap((proShanoshot) async {
      List<Map<String, dynamic>> allprojets = [];
      for (var projectDoc in proShanoshot.docs) {
        var pNameCollection =
            await projectDoc.reference.collection("P_Name").get();
        for (var pNameDoc in pNameCollection.docs) {
          allprojets.add({
            "projectId": pNameDoc.id,
            "docId": projectDoc.id,
            "data": ProjectModel.fromJson(pNameDoc),
          });
        }
      }
      return allprojets;
    });
  }

//date 18-2-2025 allprojectDetails............................
  Stream<ProjectModel?> allprojectDetails(String projectId, String documentId) {
    return _firestore
        .collection('Project')
        .doc(documentId)
        .collection('P_Name')
        .doc(projectId)
        .snapshots()
        .map((snapshot) =>
                snapshot.exists ? ProjectModel.fromJson(snapshot) : null
            //print(ProjectModel.fromJson(snapshot).projectName);

            );
  }
  // assigh task to user..................................

  Future<List<Map<String, dynamic>>> getTaskAssignToUser(
      String? documentId, String? projectId) async {
    try {
      print("${projectId} project id.............");
      print("${documentId} document id-----------------");
      DocumentSnapshot snapshot = await _firestore
          .collection("Project")
          .doc(documentId)
          .collection("P_Name")
          .doc(projectId)
          .get();
      if (snapshot.exists) {
        List<dynamic> teamData = snapshot["team"];
        return teamData.map((e) => Map<String, dynamic>.from(e)).toList();
      }
    } catch (e) {
      print(e);
    }

    return [];
  }
  //date 22-2-2025 this function will create new task....................................

  Future<void> getCreatedNewTask(
      String taskName,
      String taskDescription,
      DateTime? taskStart,
      DateTime? taskEnd,
      String? selectedUserId,
      String? projectId,
      String? documentId) async {
    TaskModel tobject = TaskModel(
      taskName: taskName,
      taskDescription: taskDescription,
      taskStartDate: taskStart,
      taskEndDate: taskEnd,
      assignTo: selectedUserId,
      status: "pending",
      taskProgress: 0,
    );
    final crateTask = _firestore
        .collection("Project")
        .doc(documentId)
        .collection("task")
        .doc()
        .set(tobject.toJson());
    if (crateTask != null) {
      print("upload_Task");
    }
  }

  //date 22-2-2025 this function will fatch all tasl real time when oer task new task....................................

  Stream<List<Map<String, dynamic>>> getListenTask(
      String projectId, String documentId) {
    print("this functin working");
    return _firestore
        .collection("Project")
        .doc(documentId)
        .collection("task")
        .snapshots()
        .asyncMap((snapshot) {
      List<Map<String, dynamic>> allTask = [];
      for (var element in snapshot.docs) {
        // final dt=element.data();
        allTask.add({
          "taskId": element.id,
          "projectId": projectId,
          "documentId": documentId,
          "data": TaskModel.FormJson(element)
        });
      }
      return allTask;
    });
  }
//date 24-2-2025 this functoin will fatch all the task details......................................................

  Stream<TaskModel?> getTaskDetails(String documentID, String taskID) {
    return _firestore
        .collection("Project")
        .doc(documentID)
        .collection("task")
        .doc(taskID)
        .snapshots()
        .asyncMap((snapshot) =>
            snapshot.exists ? TaskModel.FormJson(snapshot) : null);
  }

  Future<Userprofilemodel?> getAdminProfile(String userid) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection("allusers").doc(userid).get();
      if (snapshot.exists) {
        // print(snapshot.data());
        return Userprofilemodel.FromFireStore(snapshot);
      }
      return null;
    } catch (e) {
      print("Error fetching user profile: $e");
      return null;
    }
  }

  //  Date 27-2-2027 this function count the total task of project per project
  void toTotalTask(int length, String projectId, String documentId) {
    _firestore
        .collection("Project")
        .doc(documentId)
        .collection("P_Name")
        .doc(projectId)
        .update({'totalTask': length});
  }
// this function  fatch total task aassin to the list..............................
  Stream<List<Map<String, dynamic>>> getTotalCompletedTak(
      String projectId, String documentId) {
    return _firestore
        .collection("Project")
        .doc(documentId)
        .collection("task")
        .snapshots()
        .map((snap) {
      List<Map<String, dynamic>> com = [];
      for (var docElement in snap.docs) {
        com.add(docElement.data());
      }
      return com;
    });
  }
// this funcation update the progress filed in the progress.....................................
  void getUpDateCompleted(
      String projectId, String documentId, int completedLen) {
    _firestore
        .collection("Project")
        .doc(documentId)
        .collection("P_Name")
        .doc(projectId)
        .update({"progress": completedLen});
  }
}
