import 'package:cloud_firestore/cloud_firestore.dart';

//this page for  user acccount model and user account model for daata fatch.........................

class UserAccount {
  String? fullName;
  String? dob;
  String? gender;
  String? email;
  String? address;
  String? role;
  bool? isAdmin;
  String? uniqueId;

  DateTime? createdAt;

  String? employeId;
  String? mobileNumber;
  String? loginId;
  String? loginPassword;
  UserAccount(
      {this.fullName,
      this.dob,
      this.gender,
      this.email,
      this.employeId,
      this.mobileNumber,
      this.loginId,
      this.loginPassword,
      this.address,
      this.createdAt,
      this.isAdmin,
      this.role,
      this.uniqueId});

  Map<String, dynamic> toFireStore() {
    return {
      "full_name": fullName,
      "date_Of_Birth": dob,
      "gender": gender,
      "email": email,
      "address": address,
      "employeId": employeId,
      "mobile_number": mobileNumber,
      "login_Id": loginId,
      "Login_password": loginPassword,
      "isAdmin": isAdmin,
      "role": role,
      "unique_Id":uniqueId,
      "Date_Time": FieldValue.serverTimestamp(),
    };
  }

  factory UserAccount.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return UserAccount(
      fullName: documentSnapshot["full_name"],
      dob: documentSnapshot["date_Of_Birth"],
      gender: documentSnapshot["gender"],
      email: documentSnapshot["email"],
      address: documentSnapshot["address"],
      employeId: documentSnapshot["employeId"],
      mobileNumber: documentSnapshot["mobile_number"],
      loginId: documentSnapshot["login_Id"],
      loginPassword: documentSnapshot["Login_password"],
      isAdmin: documentSnapshot['isAdmin'],
      role: documentSnapshot['role'],
      uniqueId: documentSnapshot['unique_Id'],
      createdAt: (documentSnapshot['created_at'] as Timestamp).toDate(),
    );
  }
}
