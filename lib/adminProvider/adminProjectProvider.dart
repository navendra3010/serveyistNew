import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
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
  // Future<void> getAllProjectProvider() async {
  //   print("providr calling");
  //   await fireser.getAllProjectFireStore();
  // }

  // Stream<List<Map<String, dynamic>>> getAllStreamProjects() {
  //   return fireser.getAllproject();
  // }

//date project details...18-2-2025..................................................................
// final fetch project  name only.......................................................................
  List<Map<String, dynamic>> _project = [];
  ProjectModel? _selectedProject;

  List<Map<String, dynamic>> get project => _project;
  ProjectModel? get selectedProject => _selectedProject;
//listen to all project. final fatch name and progresss ..........
  void listenProject() {
    fireser.allProject().listen((projectList) {
      _project = projectList;
      notifyListeners();
    });
  }
  //Date 18-2-2025------------------------------------------------
  /// this funtion fatch project complete details................

  void listenAllProjectDetail(String projectId, String documentId) {
    fireser.allprojectDetails(projectId, documentId).listen((projectItems) {
      print(projectItems);
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

  void createTask(TaskModel tmodel) {
    print("${tmodel.taskName}");
    print("${tmodel.taskDescription}");
    print("${tmodel.taskStartDate}");
    print("${tmodel.taskEndDate}");
    print(" this id null-------------${tmodel.selectedFile}");
    // print("${newTaskProvider.selectedFile!.path.split('/').last}");
  }

  //date 22-2-2025 this function will create new task....................................

  Future<void> createNewTask(
      String taskName,
      String taskDescription,
      DateTime? taskStart,
      DateTime? taskEnd,
      String? selectedUserId,
      String? projectId,
      String? documentId) async {
    print(taskName);
    print(taskDescription);
    print(taskStart);
    print(taskEnd);
    print(selectedUserId);

    fireser.getCreatedNewTask(taskName, taskDescription, taskStart, taskEnd,
        selectedUserId, projectId, documentId);
    notifyListeners();
  }

  //date 22-2-2025 this function will  fatch all task of per project  show on project detials page....................................
  List<Map<String, dynamic>> task = [];
  void listenTask(String projectId, String documentId) {
    fireser.getListenTask(projectId, documentId).listen((pro) {
      task = pro;
      notifyListeners();
    //  / print(task);

      // for (var element in pro) {
      //   print(element);
      // }
    });
  }
}
