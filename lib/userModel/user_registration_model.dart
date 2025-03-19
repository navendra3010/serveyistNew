import 'package:cloud_firestore/cloud_firestore.dart';

class UserRegistrationmodel {
  String? email;
  String? password;
  bool? isAdmin;
  String? role;
  String? singupId;
  DateTime? createdAt;

  UserRegistrationmodel(
      {this.email,
      this.password,
      this.isAdmin,
      this.role,
      this.singupId,
      this.createdAt});
  //convert fireStore document to userModel

  factory UserRegistrationmodel.fromfirestore(Map<String, dynamic> json) {
    return UserRegistrationmodel(
      singupId: json['singupId'],
      email: json['email'],
      password: json['password'],
      isAdmin: json['isAdmin'],
      role: json['role'],
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }
  //convert usermodel to josn fireStore
  Map<String, dynamic> toJson() {
    return {
      "singupId": singupId,
      "email": email,
      "password": password,
      "role": role,
      "isadmin": isAdmin,
      'created_at': FieldValue.serverTimestamp(),
    };
  }
}
