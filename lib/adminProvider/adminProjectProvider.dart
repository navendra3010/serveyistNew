import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:surveyist/adminProvider/fireStoreServiceforAdmin/fireStoreserAdmin.dart';

class Projectprovider extends ChangeNotifier {
  TextEditingController dateStartcontroller = TextEditingController();
   TextEditingController dateEndcontroller = TextEditingController();
   FireStoreServiceForAdmin fireser=FireStoreServiceForAdmin();
  DateTime startDate = DateTime.now();

  DateTime endDate = DateTime.now();
 
   //set project start date provider start---------------------------------------------------
  void setDate(context) async {
    DateTime now = await selectprojectStartDate(context);
    String selectDate = DateFormat('dd-MM-yyyy').format(now);
    print(selectDate);
    dateStartcontroller.text = selectDate;
    notifyListeners();
  }

  Future selectprojectStartDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2027));

    startDate = picked!;
    return startDate;
    // print(picked);
  }

  //end----------------------------
  //set project starend date provider end---------------------------------------------------
   void setEndDate(context) async {
    DateTime now = await selectprojectStartDate(context);
    String selectDate = DateFormat('dd-MM-yyyy').format(now);
    print(selectDate);
    dateEndcontroller.text = selectDate;
    notifyListeners();
  }

  Future selectprojectEndDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: endDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2027));

    endDate = picked!;
    return endDate;
    
  }
  // provider for all team
  Future<void> getTeam()async
  {
    print("working------------");
    await fireser.createTeam();
  }



}
