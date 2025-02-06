import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:surveyist/adminModel/allUsersModel.dart';
import 'package:surveyist/userModel/userlogin.dart';

class FireStoreServiceForAdmin {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DateTime now = DateTime.now();

  Stream<List<ViewAllUsers>> getAllUsers() {
    return _firestore.collection("allusers").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        for (var element in snapshot.docs) {
          // print(element.data());
        }
        return ViewAllUsers.FromFireStore(doc);
      }).toList();
    });
  }

  Stream<List<QuerySnapshot<Map<String,dynamic>>>> getAllLoginUser() {
    String dateKey = DateFormat('dd-MM-yyyy').format(now);

    try {
     

      // Fetch all user documents from the root collection
    return _firestore.collection("userLoginRecordPerDay").snapshots().asyncMap((snapshot) async {
      // Fetch all login records for the given date for each user
      final loginStreams = await Future.wait(
        snapshot.docs.map((userDoc) async {
          return await _firestore
              .collection("userLoginRecordPerDay")
              .doc(userDoc.id)
              .collection('loginDates')
              .doc(dateKey)
              .collection('logins')
              .get();
        }).toList(),
      );
      return loginStreams; // Return the list of QuerySnapshot
    });
    
    } catch (e) {
      print(e);
      return  Stream.empty();
    }
    
  }
}
