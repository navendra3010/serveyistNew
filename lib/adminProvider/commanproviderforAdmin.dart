import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyist/UI_for_all/loginUI.dart';
import 'package:surveyist/adminModel/allUsersModel.dart';
import 'package:surveyist/adminProvider/fireStoreServiceforAdmin/fireStoreserAdmin.dart';
import 'package:surveyist/userModel/userlogin.dart';

class CommanproviderAdmin extends ChangeNotifier {
  ViewAllUsers? viewuser;
  UserLoginModel? userLoginModel;
  FireStoreServiceForAdmin frstr = FireStoreServiceForAdmin();

// all users yet -------------------------------------------------------------------------------------
  Stream<List<ViewAllUsers>> get allUsersStream {
    return frstr.getAllUsers();
  }
  

  Stream<List<QuerySnapshot<Map<String, dynamic>>>> allLoginUser() {
    
    
    return frstr.getAllLoginUser();
    
  }
  // admin logout------------------------------------------------------------------------------------
  Future<void> adminLogOut(context) async {
    final sf = await SharedPreferences.getInstance();
    sf.remove("role");
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreenForAll()));
  }
}
