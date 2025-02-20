import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:surveyist/adminModel/projectModel.dart';
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
  Future<void> getAllProjectProvider() async {
    print("providr calling");
    await fireser.getAllProjectFireStore();
  }

  Stream<List<Map<String, dynamic>>> getAllStreamProjects() {
    return fireser.getAllproject();
  }
  //this stream for new typw load projecrt
  // Stream <List<ProjectModel>> getLoadProject()
  // {
  //   return fireser.loadProject();
  // }

//date project details...18-2-2025..................................................................
// final fetch project  name only.......................................................................
  List<Map<String, dynamic>> _project = [];
  ProjectModel? _selectedProject;

  List<Map<String, dynamic>> get project => _project;
  ProjectModel? get selectedProject => _selectedProject;
//listen to all project...........
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
  final List<String> taskType = ["Excel Sheet", "PDF", "Image", "Form"];

  bool isViewTeam = false;
  void showTeam() {
    isViewTeam = !isViewTeam;
    notifyListeners();
  }

  String? _selectedTaskType;
  File? _selectedFile; // this will hold selected file
  bool _isuploading = false;

  List<List<dynamic>> _excelData = [];
  String? get selectedTaskType => _selectedTaskType;
  File? get selectedFile => _selectedFile;
  bool get isuploading => _isuploading;
  List<List<dynamic>> get excelData => _excelData;

  void setTaskType(String taskType) {
    _selectedTaskType = taskType;
  }

  Future<void> pickFile() async {
    FilePickerResult? result;

    if (_selectedTaskType == 'Excel Sheet') {
      print("excelll shet");
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
      );
    } else if (_selectedTaskType == "PDF") {
      print("pdf");
      result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    } else if (_selectedTaskType == "Image") {
      print("iamge");
      result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
    } else if (_selectedTaskType == "Form") {
      print("from");
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['doc', 'docx'],
      );
    }

    if (result!= null) {
      print("reslut noy nulll-------------------------------------");
      _selectedFile = File(result.files.single.path!);

      print("selected file type is${_selectedFile}-------------------------");
      // if (_selectedTaskType =='Excel Sheet') {
      //   print("excel file selected-------------------------------------");
      //   await readExcel(_selectedFile!);
      // }
      notifyListeners();
    }
  }

  Future<void> readExcel(File file) async {
    print("this function is working---------------------");
    final bytes = await file.readAsBytes();
    final excel = Excel.decodeBytes(bytes);
    _excelData = [];
    for (var table in excel.tables.keys) {
      print("table dta are==============================${table}");
      for (var row in excel.tables[table]!.rows) {
        _excelData.add(row.map((cell) => cell?.value ?? '').toList());
        print(_excelData);
      }
    }
    //notifyListeners();
  }
  Set<int>_selectedRows={};

  Set<int> get selectedRow=>_selectedRows;
  void toggleRowAndColumn(int index)
  {
    if(_selectedRows.contains(index))
    {
      _selectedRows.remove(index);
    }
    else
    {
      _selectedRows.add(index);
    }
    notifyListeners();
  }

  List<List<dynamic>> getSelectedData()
  {
    return _selectedRows.map((index)=>_excelData[index]).toList();
  }
}
