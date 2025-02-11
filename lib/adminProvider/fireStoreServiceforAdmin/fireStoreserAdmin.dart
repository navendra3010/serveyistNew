import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';
import 'package:surveyist/adminModel/allUsersModel.dart';
import 'package:surveyist/adminModel/projectModel.dart';

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

  Stream<List<QuerySnapshot<Map<String, dynamic>>>> getAllLoginUser() {
    String dateKey = DateFormat('dd-MM-yyyy').format(now);

    try {
      // Fetch all user documents from the root collection
      return _firestore
          .collection("userLoginRecordPerDay")
          .snapshots()
          .asyncMap((snapshot) async {
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
      return Stream.empty();
    }
  }

// function for create team for project
  Future<List> createTeam() async {
    List ids = [];
    print("creeate team working");
    QuerySnapshot snapshot = await _firestore.collection('allusers').get();
    // print(snapshot.docs);
    for (var element in snapshot.docs) {
      //print(element.id);
      // ids.add(element.data());
      // print(element.data());
      ids.add(element.id);
    }
    // print("unqiue data-------------------------------------------------------------------------${ids[0]}");
    return ids;
  }

  Map<String, String> userIdToName = {};

  ///function for fatch user for team and display them........................................
  Stream<List<Map<String, dynamic>>> getTeam() {
    return _firestore.collection("allusers").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id!;
        //data[doc.id]=doc["full_name"];
                return data;
      }).toList();
    });
  }
}
