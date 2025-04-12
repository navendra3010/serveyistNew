import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyist/UI_for_all/login_ui.dart';

import 'package:surveyist/admin_uI/admin_dashboard.dart';

import 'package:surveyist/fireStoreServiceForUser.dart/firestore_service_user.dart';
import 'package:surveyist/localization/device_information.dart';
import 'package:surveyist/main.dart';

import 'package:surveyist/userModel/device_info_model.dart';
import 'package:surveyist/userModel/device_location_model.dart';

import 'package:surveyist/userModel/userlogin.dart';

import 'package:surveyist/users_UI/user_dashboard.dart';

import 'package:surveyist/utils/app_snack_bar_or_toast_message.dart';
import 'package:surveyist/utils/app_language.dart';
import 'package:intl/intl.dart';

class LoginProviderForUser extends ChangeNotifier {
  String? deviceId;
  String? device;
  String? model;
  String? brand;
  String? board;
  String? address;
  double? lat = 0.0;
  double? long = 0.0;
  String? userName;
  String? employeId;
  String? uniqueId;

  User? currentUser;
  String? userRole;

  bool isloading = false;
  String? userID;

  Future<void> login(
      BuildContext context, String email, String password) async {
    int len = password.length;
    if (email.isEmpty || password.isEmpty) {
      ShowTaostMessage.toastMessage(
          context, Applanguage.entterEmailText[Applanguage.language]);
    }
    // else if ((!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email))) {
    //   ShowTaostMessage.toastMessage(
    //       context, Applanguage.notValidEmail[Applanguage.language]);
    // }

    else if (password == "") {
      ShowTaostMessage.toastMessage(
          context, Applanguage.passwordNameessage[Applanguage.language]);
    } else if (len < 5) {
      ShowTaostMessage.toastMessage(
          context, Applanguage.passWordlength[Applanguage.language]);
    } else {
      isloading = true;
      notifyListeners();

      try {
        // bool result=checkNetwork();
        final Connectivity connectivity = Connectivity();

        Future<List<ConnectivityResult>> result =
            connectivity.checkConnectivity();

        if (result == ConnectivityResult.none) {
          //print('No internet connection');
          isloading = false;
          notifyListeners();
          ShowTaostMessage.toastMessage(
              context, 'No internet connection. Please check your network.');
          return;
        }

        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        String getcurrentUserId = FirebaseAuth.instance.currentUser!.uid;

        SharedPreferences sf = await SharedPreferences.getInstance();

        DateTime now = DateTime.now();

        String formattedTime = DateFormat('hh:mm:ss').format(now);

        sf.setString("loginTime", formattedTime);

        sf.setString("userId", getcurrentUserId);
        
        currentUser = userCredential.user;
        if (currentUser != null) {
          userRole = await fatchUserRole(currentUser!.uid);
          sf.setString("role", userRole!);

          if (userRole == "admin") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const AdminDashboardPage()),
            );
          } else if (userRole == "user") {
            // date 24-2-20225 hide----------------------------------start
            bool previousSessionLogOut =
                await checkAndLogOutPreviousSession(currentUser!.uid);
            if (!previousSessionLogOut) {
              // print("no active session found.proceding with login");
            } else {
              //print("previous session found active please logout");
            }

            await getDeviceinfo();
            Position? position = await _determinePosition(context);
            if (position != null) {
              address = await _getAddressFromLatLng(
                  position.latitude, position.longitude);
              lat = position.latitude;
              long = position.longitude;

              if (address != null) {
                SharedPreferences sf = await SharedPreferences.getInstance();
                String? id = sf.getString("userId");
                storeLoginDetailAsperUserRecord(id);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserDashBoardScreen()),
                );
              } else {
                const SnackBar(
                  content: Text(
                      "Please enable location services and grand permisson"),
                  duration: Duration(seconds: 2),
                );
              }
            } else {
              const SnackBar(
                content:
                    Text("Please enable location services and grand permisson"),
                duration: Duration(seconds: 2),
              );
            }

            isloading = false;
            notifyListeners();
          }
        }
      } on FirebaseAuthException catch (e) {
        String message;

        switch (e.code) {
          case 'invalid-credential':
          case 'wrong-password':
          case 'invalid-email':
            message = 'Invalid email or password. Please try again.';
            break;
          case 'user-not-found':
            message = 'No account found. Would you like to sign up?';
            break;
          case 'too-many-requests':
            message = 'Too many failed attempts. Try again later.';
            break;
          case 'user-disabled':
            message = 'This account has been disabled.';
            break;
          default:
            message = 'Login failed. Please check your details.';
        }
        isloading = false;
        notifyListeners();
        ShowTaostMessage.toastMessage(context, message);

        //return null;
        // print("FirebaseAuthException: ${e.code}");
      } on SocketException {
        // Handle network-related exceptions (like no internet)
        isloading = false;
        notifyListeners();
        ShowTaostMessage.toastMessage(
            context, 'Network error occurred. Please check your connection.');
      } catch (e) {
        ShowTaostMessage.toastMessage(
          context,
          'An unexpected error occurred. Please try again.',
        );
      }
    }
  }

  Future<bool> checkAndLogOutPreviousSession(id) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy a').format(now);
    String formattedTime = DateFormat('hh:mm:ss a').format(now);
    String dateKey = DateFormat('dd-MM-yyyy').format(now);
    try {
      FirebaseFirestore fb = FirebaseFirestore.instance;

      final querySnapshot = await fb
          .collection("userLoginRecordPerDay")
          .doc(id)
          .collection("loginDates")
          .doc(dateKey)
          .collection("logins")
          .where("LogOut_status", isNull: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final loginDocs = querySnapshot.docs.first;
        //print(loginDocs);
        await fb
            .collection("userLoginRecordPerDay")
            .doc(id)
            .collection("loginDates")
            .doc(dateKey)
            .collection("logins")
            .doc(loginDocs.id)
            .update({
          'LogOut_time': formattedTime,
          'logOut_date': formattedDate,
          'LogOut_status': true,
        });
        // print("prevoius session logout");
        return true;
      }
    } catch (e) {
      //print(e);
    }
    return false;
  }

  //future type string..................................
  Future<String> getDeviceinfo() async {
    //this class for physicall devic info

    DeviceInfo deviceInfo = await DeviceInfo.loginDeviceInfo();

    model = deviceInfo.model;
    brand = deviceInfo.brand;
    board = deviceInfo.board;

    device = deviceInfo.device;
    deviceId = deviceInfo.id;
    brand = deviceInfo.brand;
    // print(
    //     " the given device info{$device,$model,$board,$deviceId,$board,$brand}");
    notifyListeners();

    //ending----------------------------------------------------------------
    return '$board,$deviceId,$board,$model,$brand';
  }

//location object-----------------------------
// function for location and location is mandatory if permissin not alloow user not move futher......
  // Future<Position?> _determinePosition(BuildContext context) async {
  //   //-----------------------
  //   while (true) {
  //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       _showLocationDialog(context);
  //       // return null;
  //     }
  //     LocationPermission permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         _showLocationDialog(context);
  //         continue;
  //       }
  //     }
  //     if (permission == LocationPermission.deniedForever) {
  //       // _showLocationDialog(context);
  //       _showLocationDialog(context);

  //       continue;
  //     }
  //     return await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     );
  //   }
  // }

  // Future<String> _getAddressFromLatLng(double lat, double lng) async {
  //   List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
  //   Placemark place = placemarks[0];

  //   return "${place.street}, ${place.locality}, ${place.country}";
  // }

  // void _showLocationDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) => AlertDialog(
  //       title: const Text('Location Access Required'),
  //       content: const Text(
  //           'Location access is required to proceed. Please enable it in settings.'),
  //       actions: [
  //         TextButton(
  //           onPressed: () async {
  //             await Geolocator.openAppSettings();
  //             Navigator.pop(context);
  //           },
  //           child: const Text('Open App Settings'),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           child: const Text('Cancel'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Future<Position?> _determinePosition(BuildContext context) async {
    bool permissionGranted = false;

    // Loop until permission is granted or denied forever
    while (!permissionGranted) {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showLocationDialog(context, true); // Ask user to enable services
        return null; // Don't proceed further if location service is off
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showLocationDialog(context, false); // Ask user to allow permission
          return null; // Don't proceed further if permission is denied
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showLocationDialog(context, false); // Notify user to enable permission
        return null; // Don't proceed further if permission is denied forever
      }

      // If permission is granted, exit the loop and return the location
      permissionGranted = true;
    }

    // After location is granted, proceed to get the current position
    return await Geolocator.getCurrentPosition(
      // ignore: deprecated_member_use
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<String> _getAddressFromLatLng(double lat, double lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    Placemark place = placemarks[0];

    return "${place.street}, ${place.locality}, ${place.country}";
  }

  void _showLocationDialog(BuildContext context, bool isServiceDialog) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing dialog
      builder: (BuildContext context) => AlertDialog(
        title: Text(isServiceDialog
            ? 'Location Services Required'
            : 'Location Permission Required'),
        content: Text(isServiceDialog
            ? 'Location services are turned off. Please enable them in settings.'
            : 'Location access is required to proceed. Please enable it in settings.'),
        actions: [
          TextButton(
            onPressed: () async {
              await Geolocator.openAppSettings();
              Navigator.pop(context); // Close dialog after opening settings
            },
            child: const Text('Open App Settings'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog if user cancels
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> storeLoginDetailAsperUserRecord(id) async {
    //UserLoginModel ul=UserLoginModel();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    String formattedTime = DateFormat('hh:mm:ss a').format(now);
    String dateKey = DateFormat('dd-MM-yyyy').format(now);

    //  print("$model, $brand,$board,$address,$lat,$long");
    Devicelocation deviceData = Devicelocation();
    deviceData.address = address;
    deviceData.latitude = lat;
    deviceData.longitude = long;
    Deviceinformation infoData = Deviceinformation();
    infoData.board = board;
    infoData.device = device;
    infoData.deviceId = deviceId;
    infoData.model = model;
    infoData.deviceBrand = brand;
    UserLoginModel usermodeData = UserLoginModel(
      location: [deviceData],
      deviceinfo: [infoData],
      userName: userName,
      uniqueId: uniqueId,
      userEmpId: employeId,
      loginTime: formattedTime,
      loginDate: formattedDate,
      loginStatus: true,
    );
    Map<String, dynamic> readData = usermodeData.toFireStore();

    await createCollection(id: id, dateKey: dateKey, data: readData);
  }

  Future<void> createCollection(
      {required id,
      required String dateKey,
      required Map<String, dynamic> data}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      DocumentReference docRef =
          firestore.collection("userLoginRecordPerDay").doc(id);

      DocumentSnapshot userSnapshot = await docRef.get();

      if (!userSnapshot.exists) {
        await docRef.set({
          'createdAT': DateTime.now(),
        });
        //print("parent documnet created succesfully");
      }

      DocumentReference dateDoc = docRef.collection("loginDates").doc(dateKey);
      DocumentSnapshot userDateSnapshot = await dateDoc.get();
      if (!userDateSnapshot.exists) {
        await dateDoc.set({'createdAT': DateTime.now()});
        //print("another parent document");
      }
      await dateDoc.collection("logins").add(data);
    } catch (e) {
      //print("Error saving login details: $e");
    }
  }

  Future<bool?> checkLoginStatus(BuildContext context) async {
    DateTime now = DateTime.now();

    DateFormat('dd/MM/yyyy').format(now);
    DateFormat(' hh:mm:ss a').format(now);
    String dateKey = DateFormat('dd-MM-yyyy').format(now);
    SharedPreferences sf = await SharedPreferences.getInstance();
    String? checkId = sf.getString("userId");
    final checkStatus = await FirebaseFirestore.instance
        .collection("userLoginRecordPerDay")
        .doc(checkId)
        .collection("loginDates")
        .doc(dateKey)
        .collection('logins')
        .where("LogOut_status", isNull: true)
        .limit(1)
        .get();
    if (checkStatus.docs.isNotEmpty) {
      final lastLogin = checkStatus.docs.first.data();
      //print("this is your past login you have to log out first then login");
      //  print(lastLogin);
      // print(checkStatus.docs.first.data());
      if (lastLogin['LogOut_status'] == null) {
        // print("Log out frist then login next session");
        // print(lastLogin["LogOutStatus"]);

        showLogOutBox(context);

        // return false;
      } else {
        return false;
      }
    } else {
      return true;
    }
    return null;
  }

  ///this alert box for logout prompt
  showLogOutBox(BuildContext context) {
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text("no"),
    );

    Widget contineuButton = TextButton(
      onPressed: () {
        FireStoreSerivcesForUser f = FireStoreSerivcesForUser();
        f.logOutService();

        Navigator.of(context).pop();
      },
      child: const Text("yes"),
    );

    AlertDialog alert = AlertDialog(
      title: const Text("LOG_OUT"),
      content: const Text(
          "would you like  to log_out previous session or continue "),
      actions: [cancelButton, contineuButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  Timer? _logOutTimer;

  Future<void> autoLogin(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    String? role = prefs.getString("role");
    if (role == "admin") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AdminDashboardPage()),
      );
      return;
    }

    DateTime now = DateTime.now();

    String currentTime = DateFormat('hh:mm:ss').format(now);

    await Future.delayed(const Duration(seconds: 2));

    //------------------------end session management------------------------

    String? id = prefs.getString("userId");
    if (id != null) {
      String? dt1 = prefs.getString("loginTime");

      if (dt1 == null) {
        userLogOut();
        return;
      }

      // print("working to ------------------------------------------------");
      List<String> splited = dt1.split(":");

      if (splited.length < 3) {
        userLogOut();
        return;
      }

      // Convert login time to seconds
      int loginTimeInSecond = (int.parse(splited[0]) * 3600) +
          (int.parse(splited[1]) * 60) +
          (int.parse(splited[2]));
      // print(
      //     "====================================================== this is logi time in second${loginTimeInSecond}");
      // Get current time in seconds
      List<String> splittedCurrentTime = currentTime.split(":");
      int currentTimeInSecond = (int.parse(splittedCurrentTime[0]) * 3600) +
          (int.parse(splittedCurrentTime[1]) * 60) +
          (int.parse(splittedCurrentTime[2]));
      // print(
      //     "current time ------------------------------------------------ ${currentTimeInSecond}");

      // Calculate time difference
      int elapsedSecond = currentTimeInSecond - loginTimeInSecond;

      // Set session time to 9 hours in seconds
      int sessionTimeInSeconds = 10 * 3600;

      if (elapsedSecond < sessionTimeInSeconds) {
        int logOutTimeInSecond = sessionTimeInSeconds - elapsedSecond;
        _startAutoLogOutTimer(logOutTimeInSecond);
        // print("autologoutStrat--------------------------------");
      } else {
        userLogOut();
        return;
      }

      isloading = false;
      notifyListeners();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const UserDashBoardScreen()),
      );
    } else {
      // If no user ID is found, navigate to login screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreenForAll()),
      );
      notifyListeners();
    }
  }

  //---------------------------------------startLogOutTime-  funtion---------------------------------------------------------//

  void _startAutoLogOutTimer(
    int logOutTimeInSecond,
  ) {
    // print(logOutTimeInSecond);
    if (logOutTimeInSecond > 0) {
      //  print("session exprire");
      _logOutTimer?.cancel();
      _logOutTimer = Timer(Duration(seconds: logOutTimeInSecond), userLogOut);
    } else {
      userLogOut();
    }
    //print("startAutologout is working properly");
  }

  Future<void> userLogOut() async {
    final sf = await SharedPreferences.getInstance();

    String? idForLogOut = sf.getString("userId");

    if (idForLogOut == null) {
      //print("User ID not found. Skipping logout process.");
      return;
    }

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    String formattedTime = DateFormat('hh:mm:ss a').format(now);
    String dateKey = DateFormat('dd-MM-yyyy').format(now);

    try {
      FirebaseFirestore fb = FirebaseFirestore.instance;

      final QuerySnapshot querySnapshot = await fb
          .collection("userLoginRecordPerDay")
          .doc(idForLogOut)
          .collection("loginDates")
          .doc(dateKey)
          .collection("logins")
          .where("LogOut_status", isNull: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final loginDocs = querySnapshot.docs.first;

        await fb
            .collection("userLoginRecordPerDay")
            .doc(idForLogOut)
            .collection("loginDates")
            .doc(dateKey)
            .collection("logins")
            .doc(loginDocs.id)
            .update({
          'LogOut_time': formattedTime,
          'logOut_date': formattedDate,
          'LogOut_status': true,
        });
        //print("User logout details updated successfully in Firestore.");
      } else {
        // print("No active login record found.");
      }
    } catch (e) {
      // print("Error during logout process: $e");
    }

    // Clear SharedPreferences data
    await sf.remove("loginTime");
    await sf.remove("userId");

    _logOutTimer?.cancel();

    // Sign out from Firebase
    await FirebaseAuth.instance.signOut();

    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreenForAll()),
    );

    notifyListeners();
  }
  //------------------------------------------------------------end all functionality of autologin  and auto logout--------------------------------------

  Future<void> checkAuthstatus() async {
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      userRole = await fatchUserRole(currentUser!.uid);
      //here it will fatch role
    }
    isloading = true;
    notifyListeners();
  }

  Future<String?> fatchUserRole(String currentUserLoginId) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('allusers')
        .doc(currentUserLoginId)
        .get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      userName = data['full_name'];
      uniqueId = data['unique_Id'];
      employeId = data['employeId'];

      return documentSnapshot['role'];
    }
    //return null;
  } 

  boolcheckNetwork()
  {
    
  }
}
