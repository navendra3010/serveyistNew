import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:surveyist/adminModel/projectModel.dart';
import 'package:surveyist/adminModel/taskModel.dart';
import 'package:surveyist/adminProvider/fireStoreServiceforAdmin/fireStoreserAdmin.dart';

import 'package:surveyist/admin_uI/projectOverViewUI.dart';

import '../utils/appSnackBarOrToastMessage.dart';

class Projectprovider extends ChangeNotifier {
  TextEditingController dateStartcontroller = TextEditingController();
  TextEditingController dateEndcontroller = TextEditingController();
  FireStoreServiceForAdmin fireser = FireStoreServiceForAdmin();
  DateTime startDate = DateTime.now();

  DateTime endDate = DateTime.now();
  bool isShowItem = false;
// this function select project date whem will admin create new project.....................
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
  // this function select  end date of project date whem will admin create new project.....................

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

// this funcation convert into  a specific formate.................................
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
      try {
         loadUser = true;
        notifyListeners();
        
        // print(obj.toJson());
        //here  with the help of model classs new project will be created.........................
        fireser.createProject(obj.toJson());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProjectOverView()),
        );
       
      } catch (e) {
        print("${e}");
      }
      finally
      {
        loadUser=false;
        notifyListeners();
      }
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

      // notifyListeners();
    } else {
      selectUserIdForTeam.add(userData);

      // notifyListeners();
    }
    _userStreamController.sink.add(selectUserIdForTeam);

    notifyListeners();
  }

//date project details...18-2-2025..................................................................
// final fetch project  name only.......................................................................
  List<Map<String, dynamic>> _project = [];

  List<Map<String, dynamic>> get project => _project;

//listen to all project. final fatch name and progresss ..........
  void listenProject() {
    fireser.allProject().listen((projectList) {
      _project = projectList;
      notifyListeners();
    });
  }

  //Date 18-2-2025------------------------------------------------
  /// this funtion fatch project complete details................
  ProjectModel? _selectedProject;
  ProjectModel? get selectedProject => _selectedProject;
  void listenAllProjectDetail(String projectId, String documentId) {
    fireser.allprojectDetails(projectId, documentId).listen((projectItems) {
      _selectedProject = projectItems;
      notifyListeners();
    });
  }

  //show team when admin click on view team...........................\

  bool isViewTeam = false;
  void showTeam() {
    isViewTeam = !isViewTeam;
    notifyListeners();
  }

  String? selectedTaskType;
  File? selectedFile; // this will hold selected file
  bool _isuploading = false;

  void setTaskType(String taskType) {
    selectedTaskType = taskType;
    notifyListeners();
  }

  Future<void> pickFile() async {
    print("this pickup function fine--------------------------------------");
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: selectedTaskType == "Excel Sheet"
            ? ['xlsx', 'xls']
            : selectedTaskType == "PDF"
                ? ["pdf"]
                : selectedTaskType == "Image"
                    ? ['jpg', 'jpeg', 'png']
                    : null);

    if (result != null) {
      print("reslut noy nulll-------------------------------------");
      selectedFile = File(result.files.single.path!);

      notifyListeners();
    }
  }

  /// this function for assigh task to user..
  ///
  List<Map<String, dynamic>> _teamList = [];
  List<Map<String, dynamic>> get teamList => _teamList;
  Future<void> taskAssignToUser(String? documentId, String? projectId) async {
    _teamList = await fireser.getTaskAssignToUser(documentId, projectId);
    notifyListeners();
  }

  //date 22-2-2025 this function will create new task....................................
  bool isTaskCreated = false;
  Future<void> createNewTask(
      String taskName,
      String taskDescription,
      DateTime? taskStart,
      DateTime? taskEnd,
      String? selectedUserId,
      String? projectId,
      String? documentId) async {
    fireser.getCreatedNewTask(taskName, taskDescription, taskStart, taskEnd,
        selectedUserId, projectId, documentId);
    isTaskCreated = true;

    notifyListeners();
  }

  //date 22-2-2025 this function will  fatch all task of per project  show on project detials page....................................
  List<Map<String, dynamic>> _task = [];

  List<Map<String, dynamic>> get task => _task;
  void listenTask(String projectId, String documentId) {
    fireser.getListenTask(projectId, documentId).listen((pro) {
      _task = pro;

      totalCompletedTasl(projectId, documentId);
      int len = _task.length;

      fireser.toTotalTask(len, projectId, documentId);

      notifyListeners();
    });
  }

  TaskModel? _selectTaskModel;
  TaskModel? get selectTaskModel => _selectTaskModel;

//date 24-2-2025 this provider funcation will fatch task details..............................................................
  void taskDetails(String projectID, String documentID, String taskID) {
    fireser.getTaskDetails(documentID, taskID).listen((taskDe) {
      _selectTaskModel = taskDe;
      notifyListeners();
    });
  }

  //Date 28-2-2025 the calutlate the complete task -----------------------------------------------------------
  List<Map<String, dynamic>> compelted = [];

  void totalCompletedTasl(String projectId, String documentId) {
    print("complted--------------------------------");
    fireser.getTotalCompletedTak(projectId, documentId).listen((task) {
      List<Map<String, dynamic>> filter = task.where((item) {
        return item["status"] == "completed";
      }).toList();

      compelted = filter;
      int completedLen = compelted.length;
      updatecompletedTasl(projectId, documentId, completedLen);
      notifyListeners();
      // print(compelted);
    });
  }

  //date 28-2-2025 this complete update total complete task per project----------------------
  void updatecompletedTasl(
      String projectId, String documentId, int completedLen) {
    fireser.getUpDateCompleted(projectId, documentId, completedLen);
    // notifyListeners();
  }
  //date 4-2-2025 t this function edit the from into user details and edit from.........................................................

  bool isEdited = false;
  void formEdit() {
    isEdited = !isEdited;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }

//date 11-3-2025
//this provider function update the project name only admin side.
  void showEditDialogBox(
      projectId, docId, BuildContext context, String? projectName) {
    TextEditingController updateController =
        TextEditingController(text: projectName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit project name"),
          content: TextField(
            controller: updateController,
            decoration: InputDecoration(hintText: "Enter new project  name"),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("cancel")),
            TextButton(
                onPressed: () async {
                  try {
                    if (updateController.text.trim().isNotEmpty) {
                      final update = FirebaseFirestore.instance
                          .collection("Project")
                          .doc(docId)
                          .collection("P_Name")
                          .doc(projectId)
                          .update(
                              {"projectName": updateController.text.trim()});
                    }
                    ShowTaostMessage.toastMessage(
                        context, " project Update successfuly");
                    Navigator.pop(context);
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("update"))
          ],
        );
      },
    );

    notifyListeners();
  }

  //date 11-3-2025.......................................
  // this funcation delete the project
  void deleteProject(BuildContext context, docId, projectId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete project"),
          actions: [
            TextButton(
                onPressed: () async {
                  final delete = await FirebaseFirestore.instance
                      .collection("Project")
                      .doc(docId)
                      .collection("P_Name")
                      .doc(projectId)
                      .collection("task")
                      .get();
                  for (var delete in delete.docs) {
                    FirebaseFirestore.instance
                        .collection("task")
                        .doc(delete.id)
                        .delete();
                  }
                  FirebaseFirestore.instance
                      .collection("Project")
                      .doc(docId)
                      .delete();
                  ShowTaostMessage.toastMessage(
                      context, " project Deleted successfuly");
                  Navigator.pop(context);
                },
                child: Text("Delete")),
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("cancel")),
          ],
        );
      },
    );
  }

  //date 11-3-2025
  bool isShowTeam = false;

  void showAndHideTeam() {
    isShowTeam = !isShowTeam;
    // if(isShowItem==true)
    // {
    //   changeText="view Team";
    //  notifyListeners();
    // }
    // else  if(isShowTeam==false){
    //   changeText="Hide Team";
    // notifyListeners();
    // }
    print(isShowTeam);
    notifyListeners();
  }



   
}
