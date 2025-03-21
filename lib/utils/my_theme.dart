import 'package:flutter/material.dart';
import 'package:surveyist/utils/theme_color.dart';

class MyAppTheme {
  static final lightTheme = ThemeData(
    primaryColor: MyAppColor.lightBlue,
    brightness: Brightness.light,
  );

   static final darkTheme=ThemeData(
    primaryColor:MyAppColor.darkBlue,
    brightness:Brightness.dark
   );
}
