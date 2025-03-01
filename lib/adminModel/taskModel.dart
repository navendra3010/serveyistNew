import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? taskId;

  String? taskName;
  String? status;
  String? taskType;
  String? taskDescription;
  DateTime? taskStartDate;
  DateTime? taskEndDate;
  String? assignTo;
  String? fileUrl;
  String? downloadUrl;
  int? taskProgress;
  String? taskFeedBack;
  String? selectedFile;

  TaskModel({
    this.taskId,
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
      "selectedFile": selectedFile,
      'taskId': taskId,
      "taskName": taskName,
      "status": status,
      "taskType": taskType,
      "taskDescription": taskDescription,
      "taskStartDate": taskStartDate,
      "taskEndDate":taskEndDate,
      "assignTo": assignTo,
    //  "taskProgress": taskProgress  as int,
      "taskFeedBack": taskFeedBack,
      "fileUrl": fileUrl,
      "downloadUrl": downloadUrl
    };
  }

  factory TaskModel.FormJson(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TaskModel(
      taskId: doc.id,
      taskName: data["taskName"] ?? '',
      status: data["status"] ?? '',
      taskType: data["taskType"] ?? '',
      taskDescription: data["taskDescription"] ?? '',
     // taskStartDate: ( data[DateTime]as Timestamp).toDate(),
    //  taskEndDate: ( data[DateTime] as Timestamp).toDate(),
     // taskProgress: data["taskProgress"],
      taskFeedBack: data["taskFeedBack"] ?? '',
      downloadUrl: data["downloadUrl"],
      fileUrl: data["fileUrl"],
      selectedFile: data["selectedFile"],
      assignTo:data["assignTo"],
    );
  }
}
