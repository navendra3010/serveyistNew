import 'package:cloud_firestore/cloud_firestore.dart';


class ViewAllUsers {
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

  ViewAllUsers(
      {this.userName,
      this.userEmail,
      this.userDateOfBirth,
      this.userEmployeId,
      this.userLoginId,
      this.userAddress,
      this.userGender,
      this.role,
      this.userMobileNumber,
      this.uniqueId});
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
      "unique_Id": uniqueId,
    };
  }

  factory ViewAllUsers.fromFireStore(DocumentSnapshot snapshot) {
   // Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final data = snapshot.data() as Map<String, dynamic>;
    return ViewAllUsers(
      userName: data["full_name"],
      userDateOfBirth: data["date_Of_Birth"],
      userGender: data["gender"],
      userEmail: data["email"],
      userAddress: data["address"],
      userEmployeId: data["employeId"],
      userMobileNumber: data["mobile_number"],
      userLoginId: data["login_Id"],
      role: data['role'],
      uniqueId: data['unique_Id'],
    );
  }
}
