import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  String? id;
  String? tittle;
  String? projectName;
  String? projectLocation;
  String? projectDiscription;
  DateTime? startDate;
  DateTime? endDate;
  List<Map<String,dynamic>>? team;
  int? progress;
  int? totalTask;

  ProjectModel(
      {this.id,
      this.tittle,
      this.projectName,
      this.projectLocation,
      this.projectDiscription,
      this.startDate,
      this.endDate,
      this.team,
      this.progress,
      this.totalTask});

  //convert model class to json strcture.................................................
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "projectName": projectName,
      "projectLocation": projectLocation,
      "projectDiscription": projectDiscription,
      "startDate": startDate,
      "endDate": endDate,
      "team": team,
      "progress": progress,
      "totalTask":totalTask,
    };
  }
  // convert firestor document to model class..............for show data on ui..................
  factory ProjectModel.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
   // print("parsing document id${doc.id}");
    return ProjectModel(
      id: doc.id,
      tittle: data["tittle"] ?? '',
      projectName: data["projectName"] ?? '',
      projectLocation: data["projectLocation"] ?? '',
      projectDiscription: data["projectDiscription"] ?? '',
      startDate: (data["startDate"]as Timestamp).toDate(),
      endDate: (data["endDate"]as Timestamp).toDate(),
      team: List<Map<String,dynamic>>.from(data["team"] ?? []),
      progress: data["progress"]  as int,
      totalTask:data["totalTask"] as int,
    );
  }
}
