import 'package:cloud_firestore/cloud_firestore.dart';

class LoginRecord {
  String? loginDate;
  String? loginTime;
  double? latitude;
  double? longitude;
  String? address;
  String? deviceId;
  String? deviceBrand;
  String? device;
  String? model;
  String? board;
  LoginRecord(
      {this.loginDate,
      this.loginTime,
      this.address,
      this.latitude,
      this.longitude,
      this.deviceBrand,
      this.model,
      this.board,
      this.device,
      this.deviceId});
  factory LoginRecord.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data();
    return LoginRecord(
        loginDate: data?['login_date'] ,
      loginTime: data?['Login_time'] ,
      latitude: data?['latitude'] ,
      longitude: data?['longitude'],
      address: data?['address'] ,
      deviceId: data?['device_Id'],
      deviceBrand: data?['device_brand'],
      device: data?['device'] ,
      model: data?['model'] ,
      board: data?['board'],

    );
  }
}
