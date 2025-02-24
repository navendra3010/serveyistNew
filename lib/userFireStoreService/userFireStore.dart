import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyist/adminModel/projectModel.dart';

class FireStoreServiceClass {
  final _store = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getAllAssignProject() {
    return _store.collection("Project").snapshots().asyncMap((sanp) async {
      List<Map<String, dynamic>> allpro = [];
      for (var projectDoc in sanp.docs) {
        var taskcollection =
            await projectDoc.reference.collection("P_Name").get();
        for (var pNameDoc in taskcollection.docs) {
          Map<String,dynamic> data=pNameDoc.data();
          List team=data["team"]??[];
          SharedPreferences pref=await SharedPreferences.getInstance();
           String? userID =pref.getString("userId");
             bool isuserLoggedIn=team.any((member)=>member["userId"]==userID);
              if(isuserLoggedIn)
              {
                allpro.add(
                  {
                    "project":pNameDoc.id,
                    "document":projectDoc.id,
                    "data":ProjectModel.fromJson(pNameDoc),
                  }
                  
                  
                );
                
              }
         
         
           
         
        }
      }
      return allpro;
    });
  }
}
