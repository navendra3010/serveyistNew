import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surveyist/UI_for_all/loginUI.dart';
import 'package:surveyist/userModel/userRegistrationModel.dart';
import 'package:surveyist/repositry/firebaseAuthentication.dart';
import 'package:surveyist/utils/appSnackBarOrToastMessage.dart';
import 'package:surveyist/utils/app_Language.dart';

class Sighupprovider extends ChangeNotifier {
  bool? isloading = false;
  String message = "";
  bool? isAdmin;
  String? createdUserID;

  // Future<void> sighupAthuntication(
  //     String email, String password, context) async {
  //   int len = password.length;
  //   if (email == "") {
  //     ShowTaostMessage.toastMessage(
  //         context, Applanguage.nullMessage[Applanguage.language]);
  //   } else if ((!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email))) {
  //     ShowTaostMessage.toastMessage(
  //         context, Applanguage.NotValidEmail[Applanguage.language]);
  //   } else if (password == "") {
  //     ShowTaostMessage.toastMessage(
  //         context, Applanguage.passwordNameessage[Applanguage.language]);
  //   } else if (len < 6) {
  //     ShowTaostMessage.toastMessage(
  //         context, Applanguage.passWordlength[Applanguage.language]);
  //   } else {
  //     try {
  //       await FirebaseauthenticationStatus.auth
  //           .createUserWithEmailAndPassword(email: email, password: password)
  //           .then((value) {
  //         isloading = true;
  //         notifyListeners();
  //         ShowTaostMessage.toastMessage(context, "Succesfully Account created");
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => LoginScreenForAll()),
  //         );
  //       });
  //     } on FirebaseAuthException catch (e) {
  //       print("FirebaseAuthException: ${e.code}");
  //       String message;

  //       if (e.code == 'user-not-found') {
  //         message = 'No user found with this email.';
  //       } else if (e.code == 'wrong-password') {
  //         message = 'Incorrect password. Please try again.';
  //       } else if (e.code == 'invalid-email') {
  //         message = 'The email address is not valid.';
  //       } else {
  //         message = 'this email already exits.';
  //       }

  //       isloading = false;
  //       notifyListeners();
  //       ShowTaostMessage.toastMessage(context, message);
  //     } on PlatformException catch (e) {
  //       String message;

  //       if (e.code == 'invalid-credential') {
  //         message = 'Invalid credentials. Please check your details.';
  //       } else {
  //         message = 'Platform error. Please try again.';
  //       }

  //       isloading = false;
  //       notifyListeners();
  //       ShowTaostMessage.toastMessage(context, message);
  //     } catch (e) {
  //       print("Unknown error: $e");
  //       isloading = false;
  //       notifyListeners();
  //       ShowTaostMessage.toastMessage(
  //         context,
  //         'An unexpected error occurred. Please try again.',
  //       );
  //     }
  //   }
  // }

  Future<void> createNewUser(
      UserRegistrationmodel userReg, BuildContext context) async {
    print(userReg.email);
    print(userReg.password);
    print(userReg.isAdmin);
    int len = userReg.password!.length;

    if (userReg.email == "") {
      ShowTaostMessage.toastMessage(
          context, Applanguage.nullMessage[Applanguage.language]);
    } else if ((!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(userReg.email!))) {
      ShowTaostMessage.toastMessage(
          context, Applanguage.NotValidEmail[Applanguage.language]);
    } else if (userReg.password == "") {
      ShowTaostMessage.toastMessage(
          context, Applanguage.passwordNameessage[Applanguage.language]);
    } else if (len < 6) {
      ShowTaostMessage.toastMessage(
          context, Applanguage.passWordlength[Applanguage.language]);
    }
    //here start user authuntication for new users....................
    else {
      bool adminExit = await checkIfAdminAccounnt();
      notifyListeners();
      String? userRole = userReg.isAdmin! && adminExit ? 'admin' : 'user';
      notifyListeners();

      try {
        await FirebaseauthenticationStatus.auth
            .createUserWithEmailAndPassword(
                email: userReg.email!, password: userReg.password!)
            .then((value) async {
          isloading = true;
          notifyListeners();
          ShowTaostMessage.toastMessage(context, "Succesfully Account created");

          createdUserID = value.user!.uid;
          UserRegistrationmodel newUserReg=UserRegistrationmodel();
           newUserReg.singupId=value.user!.uid;
          newUserReg.email=userReg.email;
          newUserReg.password=userReg.password;
          newUserReg.createdAt=DateTime.now();
         
          newUserReg.role=userRole;
          // print(
          //     "after create user account thier current user id is ${createdUserID}");
          //this code for fire store account
          // Future<bool> isStatus = userCreatedInFirestore(
          //     createdUserID, userReg.email, userReg.password, userRole);
          //Future<bool>isStatus=userCreatedInFirestore(newUserReg);
          // if (await isStatus) {
          //   isloading=true;
          //   notifyListeners();
          //   // ShowTaostMessage.toastMessage(
          //   //     context, "account created on firestore");
          //   // Navigator.push(
          //   //   context,
          //   //   MaterialPageRoute(builder: (context) => LoginScreenForAll()),
          //   // );
          // }
          isloading=true;
             notifyListeners();
           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreenForAll()),
            );
        });
      } on PlatformException catch (e) {
        String message;

        if (e.code == 'invalid-credential') {
          message = 'Invalid credentials. Please check your details.';
        } else {
          message = 'Platform error. Please try again.';
        }

        isloading = false;
        notifyListeners();
        ShowTaostMessage.toastMessage(context, message);
      } catch (e) {
        print("Unknown error: $e");
        isloading = false;
        notifyListeners();
        ShowTaostMessage.toastMessage(
          context,
          'Account already created to this email. Please change Email address.',
        );
      }
    }
  }
}

Future<bool> userCreatedInFirestore(UserRegistrationmodel obj
 
) async {
  try {
    CollectionReference crf = FirebaseFirestore.instance.collection('users');

    await crf.doc(obj.singupId).set(obj.toJson(),
      // "user_email": email,
      // "user_password": password,
      // "role": role,

     // 'updatedAt': 
    );
    SetOptions(merge: true);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> checkIfAdminAccounnt() async {
  QuerySnapshot adminQuery = await FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: 'admin')
      .get();
  return adminQuery.docs.isEmpty;
}
