import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:surveyist/userModel/user_profile_model.dart';

class FireStoreSerivcesForUser {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime now = DateTime.now();

//this code for specific user for from fire store..................
  Future<Userprofilemodel?> getUserProfile(String userid) async {
    try {
      DocumentSnapshot snapshot =
          await firestore.collection("allusers").doc(userid).get();
      if (snapshot.exists) {
        // print(snapshot.data());
        return Userprofilemodel.fromFireStore(snapshot);
      }
      return null;
    } catch (e) {
     // print("Error fetching user profile: $e");
      return null;
    }
  }

  //userLog Out firestore service.....................\
  Future<void> logOutService() async {
    DateTime now = DateTime.now();

    DateFormat('dd/MM/yyyy a').format(now);
    String formattedTime = DateFormat(' hh:mm:ss a').format(now);
    String dateKey = DateFormat('dd-MM-yyyy').format(now);
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? uId =  sf.getString("userId");
    try {
      // QuerySnapshot snapshot = await _firestore
      //     .collection("userLoginRecordPerDay")
      //     .doc(uId)
      //     .collection("loginDates")
      //     .doc("24-01-2025")
      //     .collection("logins")
      //     .get();

      //     //print(snapshot.docs);
      //   for (var element in snapshot.docs) {
      //     print(element.data());

      //   }
        FirebaseAuth.instance.signOut();


      final cr = await firestore
          .collection("userLoginRecordPerDay")
          .doc(uId)
          .collection("loginDates")
          .doc(dateKey)
          .collection("logins")
          .where("LogOut_status", isNull: true)
          //.orderBy('')
          .limit(1)
          .get();

      if (cr.docs.isNotEmpty) {
        // print(cr.docs);
        final loginDoc = cr.docs.first;
        //print(loginDoc);
        await firestore
            .collection("userLoginRecordPerDay")
            .doc(uId)
            .collection("loginDates")

            .doc(dateKey)
            .collection("logins")
            .doc(loginDoc.id)
             
            .update({
          'LogOut_time': formattedTime,
          'LogOut_status': true,
        });
        // await _firestore.collection("Logins").doc(loginDoc.id).update({'LogOut_time': formattedTime,
        //    'LogOut_status': true,});


       // print("logout status hans been updated${loginDoc.id}");
      } else {
        //print("data laoded fail");
      }
    } catch (e) {
     // print(e);
    }
  }
}
