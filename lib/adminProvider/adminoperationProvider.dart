import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:surveyist/adminModel/loginRecordmodel.dart';

class AllOpeationAndUpdate extends ChangeNotifier {
  //   List<LoginRecord> loginRecords = [];


  // Future<void> userLoginRecord() async {
  //  try{

  //     List<LoginRecord> loadedRecords = [];
  //     final userdocs=await FirebaseFirestore.instance.collection('loginRecords').get();
  //    final querySnapshot=await FirebaseFirestore.instance.collection('dateKey').get();
  //    for (var doc in querySnapshot.docs ) {
  //     loadedRecords.add(LoginRecord.fromFireStore(doc.data() as DocumentSnapshot<Map<String, dynamic>>));
       
  //    }
  //    loginRecords=loadedRecords;
  //    notifyListeners();
  //   List<LoginRecord> loadedRecords = [];

  //     // Fetch all user documents in the loginRecords collection
  //     final userDocs = await FirebaseFirestore.instance.collection('loginRecords').get();

  //     for (var userDoc in userDocs.docs) {
  //       // Get the UID
  //       String uid = userDoc.id;

  //       // List all subcollections under the user's UID
  //       final subcollections =
  //           await  FirebaseFirestore.instance.collection('loginRecords').doc(uid).listCollections();

  //       for (var subcollection in subcollections) {
  //         // Fetch all documents in each subcollection
  //         final records = await subcollection.get();

  //         for (var record in records.docs) {
  //           loadedRecords.add(LoginRecord.fromFirestore(record.data()));
  //         }
  //       }
  //     }

  //     _loginRecords = loadedRecords;
  //     notifyListeners();
    
  //  }catch(e){
  //   print(e);
  //  } 
   
  // }


  //  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // List<LoginRecord> _loginRecords = [];

  // List<LoginRecord> get loginRecords => _loginRecords;

  // Future<void> fetchAllLoginRecords() async {
  //   try {
  //     List<LoginRecord> loadedRecords = [];

  //     // Fetch all user documents in the loginRecords collection
  //     final userDocs = await _firestore.collection('loginRecords').get();

  //     for (var userDoc in userDocs.docs) {
  //       // Get the UID
  //       String uid = userDoc.id;

  //       // List all subcollections under the user's UID
  //       final subcollections =
  //           await _firestore.collection('loginRecords').doc(uid).listCollections();

  //       for (var subcollection in subcollections) {
  //         // Fetch all documents in each subcollection
  //         final records = await subcollection.get();

  //         for (var record in records.docs) {
  //           loadedRecords.add(LoginRecord.fromFirestore(record.data()));
  //         }
  //       }
  //     }

  //     _loginRecords = loadedRecords;
  //     notifyListeners();
  //   } catch (error) {
  //     print('Error fetching login records: $error');
  //   }
  // }
// ?
//   try {
//     // Fetch all users from 'loginRecords' collection
//     QuerySnapshot userSnapshot = await _firestore.collection('loginRecords').get();

//     for (var userDoc in userSnapshot.docs) {
//       String uid = userDoc.id;

//       // Get the document reference for the user
//       DocumentReference userDocRef = _firestore.collection('loginRecords').doc(uid);

//       // List all subcollections under the user's document
//       List<CollectionReference> subcollections = await userDocRef.listCollections();

//       for (var subcollection in subcollections) {
//         // Fetch documents in each subcollection (e.g., dateKey)
//         QuerySnapshot snapshot = await subcollection.get();

//         // Process documents in the subcollection
//         snapshot.docs.forEach((doc) {
//           print('Document ID: ${doc.id}');
//           print('Document Data: ${doc.data()}');
//         });
//       }
//     }
//   } catch (e) {
//     print('Error fetching subcollections: $e');
//   }



}
