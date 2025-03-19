import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:surveyist/userModel/device_info_model.dart';
import 'package:surveyist/userModel/device_location_model.dart';

class UserLoginModel {
  bool? loginStatus;
  bool? logOutStatus;
  String? loginDate;
  String? loginTime;
  String? logOutDate;
  String? logOutTime;

  String? userName;
  String? userEmpId;
  String? role;
  String? uniqueId;
  List<Devicelocation> location;
  List<Deviceinformation> deviceinfo;

  // List<Deviceinfo>deviceinfo;

  UserLoginModel({
    this.loginDate,
    this.loginTime,
    this.userEmpId,
    this.userName,
    this.role,
    this.uniqueId,
    this.logOutDate,
    this.logOutTime,
    this.loginStatus,
    this.logOutStatus,
    List<Deviceinformation>? deviceinfo,
    List<Devicelocation>? location,
  })  : location = location ?? [],
        deviceinfo = deviceinfo ?? [];

  Map<String, dynamic> toFireStore() {
    return {
      "login_date": loginDate,
      "Login_time": loginTime,
      "logOut_date": logOutDate,
      "LogOut_time": logOutTime,
      "Login_status": loginStatus,
      "LogOut_status": logOutStatus,
      "full_name": userName,
      "employeId": userEmpId,
      "role": role,
      "unique_Id": uniqueId,
      "location": location.map((loc) => loc.toFireStore()).toList(),
      "deviceinfo": deviceinfo.map((info) => info.toFireStore()).toList(),
    };
  }

  factory UserLoginModel.fromFireStore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserLoginModel(
      loginDate: data['login_date'] ?? " ",
      loginTime: data['Login_time'] ?? " ",
      logOutDate: data['logOut_date'] ?? " ",
      logOutTime: data['LogOut_time'] ?? " ",
      loginStatus: data['Login_status'] ?? false,
      logOutStatus: data['LogOut_status'] ??false,
      userName: data['full_name'] ?? "",
      uniqueId: data['unique_Id'] ?? "",
      role: data['role'] ?? "",
      userEmpId: data['unique_Id'] ?? '',
      location: data['location'] != null
          ? (data['location'] as List<dynamic>)
              .map((loc) =>
                  Devicelocation.fromFireStore(loc as Map<String, dynamic>))
              .toList()
          : [],
      deviceinfo: data['deviceinfo'] != null
          ? (data['deviceinfo'] as List<dynamic>)
              .map((info) =>
                  Deviceinformation.fromFireStore(info as Map<String, dynamic>))
              .toList()
          : [],
    );
  }
}
