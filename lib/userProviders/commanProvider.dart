import 'dart:async';


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyist/UI_for_all/loginUI.dart';
import 'package:surveyist/fireStoreServiceForUser.dart/firestoreServiceUser.dart';
import 'package:surveyist/userModel/userProfilemodel.dart';


class CommanProviderForUser extends ChangeNotifier {
  FireStoreSerivcesForUser fires = FireStoreSerivcesForUser();

  String? userID;
  bool isLogOut = false;
  bool isAutologin = false;
  String? getId;
  Timer? _logOutTimer;
  int sessointime = 10;

  Userprofilemodel? userProfile;
//get user unique id----------------------------
  void getUserId(id) {
    userID = id;
    notifyListeners();
    print("--------------get user id-${userID}--------------------------");
  }

  ///fatch user prfile using provider
  Future<Userprofilemodel?> getUserInfo() async {
    SharedPreferences sff = await SharedPreferences.getInstance();
    String? profileID = await sff.getString('userId');
    if (profileID != null) {
      // print("got profile id      ${profileID}");
      return await fires.getUserProfile(profileID);
    } else {
      print("not getting profile id");
    }
    return null;
  }

// autologin...................

  void autoLogin() async {
      // Ensure the widget is still mounted before navigating
        await Future.delayed(const Duration(seconds: 1));

    DateTime now = DateTime.now();

    String formattedDate = DateFormat('dd/MM/yyyy a').format(now);
    String formattedTime = DateFormat('hh:mm:ss').format(now);
    String dateKey = DateFormat('dd-MM-yyyy').format(now);
    
    //convert time into second......................
    // int? startTime = DateTime.parse(formattedTime).millisecond;
    // SharedPreferences getval = await SharedPreferences.getInstance();

    // FirebaseAuth auth = FirebaseAuth.instance;
    // isAutologin = true;
    // notifyListeners();
    // //SharedPreferences getval = await SharedPreferences.getInstance();

    // String? holdValue = getval.getString("userId");

    // if (holdValue != null) {
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => UserDashBoardScreen(
    //                 userId: getId,
    //               )));
    // } else {
    //   Future.delayed(
    //       Duration(seconds: 3),
    //       () => Navigator.pushReplacement(context,
    //           MaterialPageRoute(builder: (context) => LoginScreenForAll())));
    //   isAutologin = false;
    //   notifyListeners();
    // }
    //date 28-1-2025--------------------------------------------------------------------
    // isAutologin = true;
    // notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
   
    //here im performing autologin and autologout......................

    if (id != null) {
      print(
          "auotlogin with id--------------------------------------------------------------------------------------------------");
      String? dt1 = prefs.getString("loginTime");
      print(dt1);
      var splited = dt1?.split(":");
      int hour = int.parse(splited![0]);
      int minute = int.parse(splited![1]);
      int second = int.parse(splited![2]);
      int loginTimeInSecond = (hour * 3600) + minute * 60 + second;
      // int workingHour = totalSecond + sessointime;
      print(" the totao second into  hoour ${loginTimeInSecond}");

      String? time = dt1;
      String? myHour = time!.substring(0, 2);
      String? myMinute = time!.substring(2, 4);
      String? mySecond = time!.substring(4, 6);
      //print(formattedTime);
      var splitedCurrentime = formattedTime.split(":");
      int hour1 = int.parse(splitedCurrentime![0]);
      int minute1 = int.parse(splitedCurrentime![1]);
      int second1 = int.parse(splitedCurrentime![2]);
      int currentTimeInSecond1 = (hour1 * 3600) + minute1 * 60 + second1;
      print(currentTimeInSecond1);
      // now diffrent between current time and login time
      int elapsedSecond = currentTimeInSecond1 - loginTimeInSecond;
      print(" this id elapsed time${elapsedSecond}");

      if (elapsedSecond < sessointime) {
        // here autologin peform that means redirect the userhome page..........................
        int secondRemaningToLogOut = sessointime - elapsedSecond;
        print("logout scheuled is wokking");
        //logOutSchedule(secondRemaningToLogOut);
        // if (context.mounted) {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => UserDashBoardScreen()),
        // );
      }
        return;
      }
    } 
    // else {
    //   // Navigator.pushReplacement(
    //   //   context,
    //   //   MaterialPageRoute(
    //   //     builder: (context) => LoginScreenForAll()));
    // }
  }
  //autologin code

  //logoutSechedule
  // void logOutSchedule(int secondRemaningToLogOut,  context) {
     
  //    if (!context.mounted) {
  //   print("Context is no longer valid at the time of scheduling logout.");
  //   return; // Exit early if the context is invalid
  // }
  //   // _logOutTimer?.cancel();
  //   _logOutTimer?.cancel();
  // _logOutTimer = Timer(
  //   Duration(seconds: secondRemaningToLogOut),
  //   () => autologout(context),
  // );
  // }

  //autologout.................................
  void autologout( BuildContext context) async {
      await Future.delayed(const Duration(seconds: 1));
    if (!context.mounted) {
      print("Context is no longer valid, aborting logout.");
      return;
    }
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.remove("id");
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreenForAll()));
    }
  }


  //logout user per day...........................
  Future<void> userLogOut(context) async {
    // await FirebaseAuth.instance.signOut();

    SharedPreferences sf = await SharedPreferences.getInstance();

    // fires.logOutService();
    // notifyListeners();

    // bool? getvaluefromSf = await sf.remove("userId");
    // if (getvaluefromSf == true) {
    //   print("id has been removed complety");
    // } else {
    //   print("id cannot removed");
    // }
    //date 28-1-2028-----------------------------
    print(sf.getString("loginTime"));
    await sf.clear();

    //notifyListeners();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreenForAll()));
  }

  /// this function basically  can be user  to check user id exits in shaarred prefrenes or not
  Future<void> checkSharredprerence() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? getvalue = sf.getString('userId');
    if (getvalue != null) {
      print(
          " the user id form shrraed preferencses i got it=--------------${getvalue}");
    } else {
      print("not get value=======================");
    }
  }

//show on ui user login time and current time and working hour
  Future<void> showLoginTimeForUser() async {}

