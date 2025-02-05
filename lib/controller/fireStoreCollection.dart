import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

class CollectionData {
  static Future<void> sendUserLoginActivity(
      String? currentUserId,
      String formattedDate,
      String dateKey,
      String? model,
      String? brand,
      String? device,
      String? id,
      String? board) async {
    //FirebaseFirestore collect=FirebaseFirestore.instance.doc(userActivity).set({}) as FirebaseFirestore;

    //DateTime now=DateTime.now();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy hh:mm:ss a').format(now);
    String dateKey = DateFormat('dd-MM-yyyy').format(now); // Date as key

    await FirebaseFirestore.instance
        .collection('loginRecords')
        .doc(currentUserId)
        .collection(dateKey)
        .add({
      "login_date": formattedDate,
      "Login_time": Timestamp.now(),
      "brand": brand,
      "device": device,
      "id": id,
      "board": board,
    });
  }
}
