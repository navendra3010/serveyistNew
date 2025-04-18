import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surveyist/adminModel/create_user_account_model.dart';
import 'package:surveyist/admin_uI/admin_dashboard.dart';
import 'package:surveyist/userFireStoreService/user_fire_store.dart';
import 'package:surveyist/userModel/user_profile_model.dart';

import 'package:surveyist/utils/app_snack_bar_or_toast_message.dart';
import 'package:surveyist/utils/app_language.dart';

class Accountcreate extends ChangeNotifier {
  FireStoreServiceClass fireServices = FireStoreServiceClass();

  //refreance of collection firebase........................
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool isAccountCreate = false;
  User? currentUser;
  Future<void> userNewAccount(UserAccount obj, context) async {
    int mobileLen = obj.mobileNumber!.length;
    int loginPass = obj.loginPassword!.length;
    if (obj.fullName == "") {
      ShowTaostMessage.toastMessage(
          context, Applanguage.fullName[Applanguage.language]);
    } else if (obj.dob == "") {
      ShowTaostMessage.toastMessage(
          context, Applanguage.dob[Applanguage.language]);
    } else if (obj.gender == "") {
      ShowTaostMessage.toastMessage(
          context, Applanguage.gender[Applanguage.language]);
    } 
    else if ((!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(obj.email!))) {
      ShowTaostMessage.toastMessage(
          context, Applanguage.notValidEmail[Applanguage.language]);
    }
     else if (obj.address == "") {
      ShowTaostMessage.toastMessage(
          context, Applanguage.address[Applanguage.language]);
    } else if (obj.employeId == "") {
      ShowTaostMessage.toastMessage(
          context, Applanguage.employeId[Applanguage.language]);
    } else if (obj.mobileNumber == "") {
      ShowTaostMessage.toastMessage(
          context, Applanguage.mobileNumber[Applanguage.language]);
    } else if (mobileLen <= 9) {
      ShowTaostMessage.toastMessage(
          context, Applanguage.mobileLength[Applanguage.language]);
    }
     else if ((!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(obj.loginId!))) {
      ShowTaostMessage.toastMessage(
          context, Applanguage.loginIdvalid[Applanguage.language]);
    }
     else if (obj.loginId == "") {
      ShowTaostMessage.toastMessage(
          context, Applanguage.loginId[Applanguage.language]);
    } else if (obj.loginPassword == "") {
      ShowTaostMessage.toastMessage(
          context, Applanguage.passwordNameessage[Applanguage.language]);
    } else if (loginPass <= 4) {
      ShowTaostMessage.toastMessage(
          context, Applanguage.loginPasswordmsg[Applanguage.language]);
    } else {
      //there fire store  check admin exit or not
      bool adminExit = await checkIfAdminAccounntt();
      notifyListeners();
      String? userRole = obj.isAdmin! && adminExit ? 'admin' : 'user';
      notifyListeners();

      try {
        /// firebas user account afterr checking admin or user account exit it will execute------------------------
        isAccountCreate = true;
        notifyListeners();
        firebaseAuth
            .createUserWithEmailAndPassword(
                email: obj.loginId!, password: obj.loginPassword!)
            .then((value) {
          String userId = value.user!.uid;
          obj.role = userRole;
          obj.uniqueId = userId;
          // UserAccount obj1 = UserAccount();
          isAccountCreate = false;
          notifyListeners();

          createUserOnfireStore(userId, context, obj.toFireStore());
        });

        ShowTaostMessage.toastMessage(context, "Succesfully_Account_Created");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminDashboardPage()),
        );

      
        isAccountCreate = false;
        notifyListeners();
      } on PlatformException catch (e) {
        String message;

        if (e.code == 'invalid-credential') {
          message = 'Invalid credentials. Please check your details.';
        } else {
          message = 'Platform error. Please try again.';
        }

        isAccountCreate = false;
        notifyListeners();
        ShowTaostMessage.toastMessage(context, message);
      } on FirebaseAuthException catch (e) {
        String message;

        switch (e.code) {
          case 'invalid-credential':
          case 'wrong-password':
          case 'invalid-email':
            message = 'Invalid email or password. Please try again.';
            break;
          case 'user-not-found':
            message = 'No account found. Would you like to sign up?';
            break;
          case 'too-many-requests':
            message = 'Too many failed attempts. Try again later.';
            break;
          case 'user-disabled':
            message = 'This account has been disabled.';
            break;
          default:
            message = 'Login failed. Please check your details.';
        }
        isAccountCreate = false;
        notifyListeners();
        ShowTaostMessage.toastMessage(context, message);

       // return null;
        // print("FirebaseAuthException: ${e.code}");
      } catch (e) {
        //print("Unknown error: $e");
        isAccountCreate = false;
        notifyListeners();
        ShowTaostMessage.toastMessage(
          context,
          'Account already created to this email. Please change Email address.',
        );
      }
    }
  }

//account adding also on fire store along with fire base authication.............................
  Future<void> createUserOnfireStore(
      String userCurrrentID, context, Map<String, dynamic> fireStore) async {
    try {
      final addData = firestore.collection("allusers").doc(userCurrrentID);
      addData.set(fireStore);
    } catch (e) {
     // print("Unknown error: $e");
      isAccountCreate = false;
      notifyListeners();
      ShowTaostMessage.toastMessage(
        context,
        'Account already created to this email. Please change Email address.',
      );
    }
    //UserAccount us=UserAccount();
  }

  Future<bool> checkIfAdminAccounntt() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("allusers")
        .where('role', isEqualTo: 'admin')
        .get();

    return snapshot.docs.isEmpty;
  }

  //Date 3-3-2025.......................... thid function fatch user details per  admin only see the details...................................
  Userprofilemodel? _model;
  Userprofilemodel? get model => _model;

  void fatchUserAccountDetails(String? userID) {
    fireServices.getFacthUserAccountDetails(userID).listen((details) {
      _model = details;
      notifyListeners();

      // if (_model != null) {
      //  // print(_model!.userName);
      // } else {
      //   print('User details are not available.');
      // }
    });
  }
}
