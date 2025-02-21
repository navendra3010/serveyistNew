import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? taskId;
  String? taskTittle;
  String? taskName;
  String? status;
  String? taskType;
  String? taskDescription;
  DateTime? taskStartDate;
  DateTime? taskEndDate;
  List<String>? assignTo;
  String? fileUrl;
  String? downloadUrl;
  double? taskProgress;
  String? taskFeedBack;
  File? selectedFile;

  TaskModel(
      {this.taskId,
      this.taskTittle,
      this.taskName,
      this.status,
      this.taskType,
      this.taskDescription,
      this.taskStartDate,
      this.taskEndDate,
      this.assignTo,
      this.taskProgress,
      this.taskFeedBack,
       this.fileUrl,
       this.downloadUrl,
       this.selectedFile,
       });
  //cnvert model class to json formate for store  data in firstore------------------------------
  Map<String, dynamic> toJson() {
    return {
      "selectedFile":selectedFile,
      'taskId': taskId,
      "taskTittle": taskTittle,
      "taskName": taskName,
      "status": status,
      "taskType": taskType,
      "taskDescription": taskDescription,
      "taskStartDate": taskStartDate,
      "assignTo": assignTo,
      "taskProgress": taskProgress,
      "taskFeedBack": taskFeedBack,
      "fileUrl":fileUrl,
      "downloadUrl":downloadUrl
    };
  }

  factory TaskModel.FormJson(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TaskModel(
      taskId: doc.id,
      taskTittle: data["taskTittle"] ?? '',
      taskName: data["taskName"] ?? '',
      status: data["status"] ?? '',
      taskType: data["taskType"] ?? '',
      taskDescription: data["taskDescription"] ?? '',
      taskStartDate: data["taskStartDate"] ?? '',
      taskEndDate: data["taskEndDate"] ?? '',
      taskProgress: data["taskProgress"] ?? '',
      taskFeedBack: data["taskFeedBack"] ?? '',
      downloadUrl:data["downloadUrl"],
      fileUrl: data["fileUrl"],
      selectedFile:data["selectedFile"],
      assignTo: List<String>.from(data["assignTo"] ?? []),
    );
  }
}
