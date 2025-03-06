import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:surveyist/adminModel/allUsersModel.dart';
import 'package:surveyist/adminModel/loginRecordmodel.dart';

class Adminhomeprovider extends ChangeNotifier {
  // bool isLoginRecord = false;
  // List<DocumentSnapshot> todaysLogins = [];
  // List<String> userIdLists = [];

  // Future<void> getTodayLogins() async {
  //   isLoginRecord = true;
  //   notifyListeners();

  //   try {
  //     DateTime startOfDay = DateTime.now();
  //     DateTime endOfDay = startOfDay.add(Duration(days: 1));

  //     QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collection("loginRecords")
  //         .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
  //         .where('timestamp', isLessThan: endOfDay)
  //         .orderBy('timestamp', descending: true) // Latest first
  //         .get();
  //     todaysLogins = snapshot.docs;
  //     // notifyListeners();
  //   } catch (e) {
  //     print("error fetching for today records${e.toString()}");
  //   } finally {
  //     isLoginRecord = false;
  //     notifyListeners();
  //   }
  // }

  // String _formatTimestamp(Timestamp timestamp) {
  //   DateTime date = timestamp.toDate();
  //   return '${date.hour}:${date.minute} - ${date.day}/${date.month}/${date.year}';
  // }

  // List alluserList = [];
  // bool isFatchDone = false;

 
//List loginRecordList=[];

  // Future<void> fetchAllLoginDetails() async {
  //   try {
  //     print("-----------\\===========================");
  //     QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('usersloginRecords')
  //         .get();
  //     for (var element in snapshot.docs) {
  //       //  var userData = element.data();
  //       //  print(userData);
  //       var usergetid = element.id;
  //      // print(usergetid);
  //       QuerySnapshot<Map<String, dynamic>> loginsSnapshot =
  //           await FirebaseFirestore.instance
  //               .collection('usersloginRecords')
  //               .doc(usergetid)
  //               .collection('loginDates')
  //               .doc("13-01-2025")
  //               .collection('logins')
  //               .get();
                
  //               // final loginData=loginsSnapshot.docs.map((e)=>LoginRecord.fromFireStore(e)).toList();
  //               // LoginRecordList=loginData;
  // List<LoginRecord> loginData = loginsSnapshot.docs
  //         .map((e) => LoginRecord.fromFireStore(e))
  //         .toList();

  //     loginRecordList.addAll(loginData); 
  //     int listlen=loginData.length;
      

  //       // Check if there are any records
  //       if (loginsSnapshot.docs.isEmpty) {
  //         // print("No login records found for userId: $userId on date: $date");
  //       } else {
  //         // print("Login details for userId: $userId on date: $date:");

  //         // Iterate through each document and print details
  //         // for (var doc in loginsSnapshot.docs) {
  //         //   print("Login ID: ${doc.id}");
  //         //   print("Data: device id ${doc.data()["device_Id"]}");
  //         // }
  //       }
  //      // print("hello------hello-----------");
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

}
