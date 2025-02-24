import 'package:flutter/material.dart';
import 'package:surveyist/userFireStoreService/userFireStore.dart';

class UserProjectProviderClass extends ChangeNotifier
{



    FireStoreServiceClass fireStoreService=FireStoreServiceClass();
    List<Map<String,dynamic>> projectData=[];

     void allAssignProject()
     {

      fireStoreService.getAllAssignProject().listen((data){

        projectData=data;
        notifyListeners();
        print(projectData);
      });
     }


}