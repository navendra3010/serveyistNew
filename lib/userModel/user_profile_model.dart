import 'package:cloud_firestore/cloud_firestore.dart';

class Userprofilemodel {
  String? userName;
  String? userEmail;
  String? userDateOfBirth;
  String? userEmployeId;
  String? userLoginId;
  String? userGender;
  String? userAddress;
  String? userMobileNumber;
  String? role;
  String? uniqueId;
  String? loginPassword;

  Userprofilemodel(
      {this.userName,
      this.userEmail,
      this.userDateOfBirth,
      this.userEmployeId,
      this.userLoginId,
      this.userAddress,
      this.userGender,
      this.role,
      this.loginPassword,
      this.userMobileNumber,this.uniqueId});
  Map<String, dynamic> toFireStore() {
    return {
      "full_name": userName,
      "date_Of_Birth": userDateOfBirth,
      "gender": userGender,
      "email": userEmail,
      "address": userAddress,
      "employeId": userEmployeId,
      "mobile_number": userMobileNumber,
      "login_Id": userLoginId,
      "role": role,
      "unique_Id":uniqueId,
      "Login_Password":loginPassword
    };
  }

  factory Userprofilemodel.fromFireStore(
      DocumentSnapshot doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Userprofilemodel(
      userName: data["full_name"],
      userDateOfBirth: data["date_Of_Birth"],
      userGender: data["gender"],
      userEmail: data["email"],
      userAddress: data["address"],
      userEmployeId: data["employeId"],
      userMobileNumber: data["mobile_number"],
      userLoginId: data["login_Id"],
      role: data['role'],
      uniqueId: data["unique_Id"],
      loginPassword: data["Login_password"],
    );
  }
}
