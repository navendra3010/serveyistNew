import 'package:flutter/material.dart';

class AgeCheckStatusProvider with ChangeNotifier {
  bool? isEligible;
  int? age;
  String? message="";

  void check(int age) {
    if (age >= 18) {
      isEligible = true;
      message = "you are eligible for vote";
      notifyListeners();
    } 
    else {
      isEligible = false;
      message = "you are  not eligible for vote";
      notifyListeners();
    }
  }
}
