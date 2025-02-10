import 'dart:core';

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
  double? taskProgress;
  String? taskFeedBack;

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
      this.taskFeedBack});
  //cnvert model class to json formate for store  data in firstore------------------------------
  Map<String, dynamic> toJson() {
    return {
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
      assignTo: List<String>.from(data["assignTo"] ?? []),
    );
  }
}
