// ignore_for_file: prefer_final_fields, unused_local_variable, use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';

import 'package:geolocator/geolocator.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyist/UI_for_all/login_ui.dart';
import 'package:surveyist/admin_uI/admin_dashboard.dart';
import 'package:surveyist/localization/device_information.dart';
import 'package:surveyist/userModel/device_info_model.dart';
import 'package:surveyist/userModel/device_location_model.dart';
import 'package:surveyist/userModel/userlogin.dart';
import 'package:surveyist/users_UI/user_dashboard.dart';
import 'package:surveyist/utils/app_snack_bar_or_toast_message.dart';

class LoginProvider2 extends ChangeNotifier {
  String? userName;
  String? employeId;
  String? uniqueId;
  String? address;
  double? lat = 0.0;
  double? long = 0.0;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  DateTime now = DateTime.now();

  bool isLoginTrue = false;
  bool checking = true;

  Future<void> userLogin(
      String loginId, String loginPassword, BuildContext context) async {
    //  before login  this function  excitue   network status

    if (loginId.isEmpty && loginPassword.isEmpty) {
      ShowTaostMessage.toastMessage(
          context, "please enter your eamil and password");
      return;
    } else if ((loginId.isEmpty)) {
      ShowTaostMessage.toastMessage(context, "please enter your eamil ");
      return;
    } 
    else if (((!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(loginId)))) {
      ShowTaostMessage.toastMessage(
          context, "please enter your valid login id ");
      return;
    } else if ((loginPassword.isEmpty)) {
      ShowTaostMessage.toastMessage(context, "please enter your password ");
      return;
    } else if (loginPassword.length < 5) {
      ShowTaostMessage.toastMessage(
          context, "password must be more than 5 character ");
      return;
    } else {
      bool connectionStatus = await checkNwtworkStatus();

      if (connectionStatus == false) {
        isLoginTrue = false;
        notifyListeners();
        ShowTaostMessage.toastMessage(context, "No internet connection ");
        return;
      } else {
        try {
          isLoginTrue = true;
          notifyListeners();

          await firebaseAuth.signInWithEmailAndPassword(
              email: loginId, password: loginPassword);
          final user = firebaseAuth.currentUser;
          if (user == null) {
            ShowTaostMessage.toastMessage(context, "Login failed. Try again.");
            return;
          }

          String userId = user.uid;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("userId", userId);

          //fatch user role from firestore
          String role = await getRole(userId);
          prefs.setString("role", role);

          if (role == "admin") {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminDashboardPage(),
                ));
            return;
          }

          // if (role == "guest") {
          //   ShowTaostMessage.toastMessage(context, "You are guest user ");
          //   return;
          // }

          if (role == "user") {
            bool logStatus = await checkUserLoginSession( userId);
            print("-----------------------------------logOutStatus $logStatus");
            if (logStatus == true) {
              ShowTaostMessage.toastMessage(
                  context, "You are already logged in another device ");
              return;
            }

            // if (!logStatus) {
            //   // Show confirmation dialog
            //   bool shouldLogoutPrevious =
            //       await showLogoutConfirmationDialog(context);

            //   if (shouldLogoutPrevious) {
            //     // Call your API or Firebase function to invalidate previous session
            //     await forceLogoutPreviousDeviceSession(context);

            //     // Continue with login
            //     // await performLogin(context, userId);
            //     // Navigator.pushReplacement(
            //     //     context,
            //     //     MaterialPageRoute(
            //     //       builder: (context) => const LoginScreenForAll(),
            //     //     ));

            //     // Replace with your login logic
            //   } else {
            //     // User chose not to log in
            //     ShowTaostMessage.toastMessage(context,
            //         "Login cancelled. Please logout from other device first.");
            //     return;
            //   }
            // }

            else {
              // Safe to login
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const LoginScreenForAll(),
              //     ));
              // await performLogin(context, userId);
            }
            await deviceInfo();
            Position? position = await _determinePosition(context);
            if (position != null) {
              address = await _getAddressFromLatLng(
                  position.latitude, position.longitude);
              lat = position.latitude;
              long = position.longitude;
              DateTime now = DateTime.now();

              String formattedTime = DateFormat('hh:mm:ss').format(now);

              prefs.setString("loginTime", formattedTime);
              String? id = prefs.getString("userId");
               storeLoginDetailAsperUserRecord(id);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserDashBoardScreen()),

              );
              ShowTaostMessage.toastMessage(context, "You are successfully logged in ");
              return;
            } else {
              firebaseAuth.signOut();
              prefs.clear();
              //      Navigator.pushReplacement(
              // context,
              // MaterialPageRoute(
              //   builder: (context) => const LoginScreenForAll(),
              // ));
              ShowTaostMessage.toastMessage(
                  context, "Location permission denied. Please allow it.");
              checking = false;
              notifyListeners();
            }
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            ShowTaostMessage.toastMessage(
                context, "No user found for that email.");
          } else if (e.code == 'wrong-password') {
            ShowTaostMessage.toastMessage(
                context, "Wrong password provided for that user.");
          } else if (e.code == 'invalid-email') {
            ShowTaostMessage.toastMessage(context, "Invalid email address.");
          } else if (e.code == 'user-disabled') {
            ShowTaostMessage.toastMessage(context, "User has been disabled.");
          } else if (e.code == 'operation-not-allowed') {
            ShowTaostMessage.toastMessage(context, "Operation not allowed.");
          } else {
            ShowTaostMessage.toastMessage(context, "Login failed. Try again.");
          }
          ShowTaostMessage.toastMessage(context, "wrond password ");
          return;
        } on PlatformException catch (e) {
          print('PlatformException: ${e.code} - ${e.message}');

          ShowTaostMessage.toastMessage(context, "exception 1 ");
          return;
          // Handle general platform-level issues
        } catch (e) {
          print('General error: $e');
          ShowTaostMessage.toastMessage(context, "exception 2 ");
          return;
          // Catch anything else
        } finally {
          isLoginTrue = false;
          notifyListeners();
        }
      }
    }
  }

  //date 8-4-2025.....................checkNetworkStatusBeforeEnterin gin application
  bool isNetworkAvaiable = false;

  Future<bool> checkNwtworkStatus() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else {
      return false;
    }
  }

  //date 10-4-2025 thiss funcation cheeck user role is it admin or user.....................

  Future getRole(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firebaseFirestore.collection("allusers").doc(userId).get();
      if (snapshot.exists) {
        Map<dynamic, dynamic>? data = snapshot.data();
        userName = data?["full_name"];
        employeId = data?["employeId"];
        uniqueId = data?["unique_Id"];
        String role = data?['role'];
        return role;
      }
    } catch (e) {
      "error in  getr  role $e}";
    }
    return "";
  }
  //date 10-4-2025  this function check user login  prevoius session or not

  Future<bool> checkUserLoginSession(String userId) async {
   // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? docId = prefs.getString("userId");
    String? docId = userId;
    String datekey = DateFormat('dd/MM/yyyy').format(now);
    if (docId != null) {
      final data = await firebaseFirestore
          .collection("userLoginRecordPerDay")
          .doc(docId)
          .collection("loginDates")
          .doc(datekey)
          .collection("logins")
          .where("LogOut_status", isEqualTo: false ??null)
          .get();

      // if (data.docs.isNotEmpty) {
      //   for (var element in data.docs) {
      //     if (element['LogOut_status'] == false) {
      //       return false;
      //     }
      //   }
      // }
      return  false;
    }
    return true;
  }

  //date 11-4-2025 this function is used to ge=t device infromation and save in firestore
  String? deviceId;
  String? device;
  String? model;
  String? brand;
  String? board;
  Future<String> deviceInfo() async {
    DeviceInfo deviceInfo = await DeviceInfo.loginDeviceInfo();

    model = deviceInfo.model;
    brand = deviceInfo.brand;
    board = deviceInfo.board;

    device = deviceInfo.device;
    deviceId = deviceInfo.id;
    brand = deviceInfo.brand;

    return '$board,$deviceId,$board,$model,$brand';
  }

  //date 11-2-4-2025 this funcation i used to  atuologin admin and user............................
  Future autoLoginForBoth(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? role = prefs.getString("role");
    print("Role found in SharedPreferences: $role");

    if (role == "admin") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminDashboardPage(),
          ));
      isLoginTrue = false;
      notifyListeners();
      return;
    } else if (role == "user") {


      
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const UserDashBoardScreen(),
          ));
      isLoginTrue = false;
      notifyListeners();
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreenForAll(),
          ));
      isLoginTrue = false;
      notifyListeners();
    }
  }

  //date 11-4-205 this function is useed tp logout use and admin both...................
  void logOutUserAndAdmin(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.remove("userId");
    // await prefs.remove("role");
    String? idForLogOut = prefs.getString("userId");
    if (idForLogOut == null) {
      //print("User ID not found. Skipping logout process.");
      return;
    }
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    String formattedTime = DateFormat('hh:mm:ss a').format(now);
    String dateKey = DateFormat('dd-MM-yyyy').format(now);

    try {
      final QuerySnapshot querySnapshot = await firebaseFirestore
          .collection("userLoginRecordPerDay")
          .doc(idForLogOut)
          .collection("loginDates")
          .doc(dateKey)
          .collection("logins")
          .where("LogOut_status", isEqualTo: false)
          // .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final loginDocs = querySnapshot.docs.first;

        await firebaseFirestore
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
      }
    } catch (e) {
      "{$e}";
    }

    await prefs.clear();
    await firebaseAuth.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreenForAll()),
      (route) => false,
    );

    notifyListeners();
  }

  // Future<Position?> _determinePosition(BuildContext context) async {
  //   bool permissionGranted = false;

  //   // Loop until permission is granted or denied forever
  //   while (!permissionGranted) {
  //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       _showLocationDialog(context, true); // Ask user to enable services
  //       return null; // Don't proceed further if location service is off
  //     }

  //     LocationPermission permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         _showLocationDialog(context, false); // Ask user to allow permission
  //         return null; // Don't proceed further if permission is denied
  //       }
  //     }

  //     if (permission == LocationPermission.deniedForever) {
  //       _showLocationDialog(context, false); // Notify user to enable permission
  //       return null; // Don't proceed further if permission is denied forever
  //     }

  //     // If permission is granted, exit the loop and return the location
  //     permissionGranted = true;
  //   }

  //   // After location is granted, proceed to get the current position
  //   return await Geolocator.getCurrentPosition(
  //     // ignore: deprecated_member_use
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  // }

  // Future<String> _getAddressFromLatLng(double lat, double lng) async {
  //   List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
  //   Placemark place = placemarks[0];

  //   return "${place.street}, ${place.locality}, ${place.country}";
  // }

  // void _showLocationDialog(BuildContext context, bool isServiceDialog) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false, // Prevent dismissing dialog
  //     builder: (BuildContext context) => AlertDialog(
  //       title: Text(isServiceDialog
  //           ? 'Location Services Required'
  //           : 'Location Permission Required'),
  //       content: Text(isServiceDialog
  //           ? 'Location services are turned off. Please enable them in settings.'
  //           : 'Location access is required to proceed. Please enable it in settings.'),
  //       actions: [
  //         TextButton(
  //           onPressed: () async {
  //             await Geolocator.openAppSettings();
  //             Navigator.pop(context); // Close dialog after opening settings
  //           },
  //           child: const Text('Open App Settings'),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context); // Close dialog if user cancels
  //           },
  //           child: const Text('Cancel'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Future<Position?> _determinePosition(BuildContext context) async {
    bool permissionGranted = false;

    while (!permissionGranted) {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showLocationDialog(context, true);
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showLocationDialog(context, false);
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showLocationDialog(context, false);
        return null;
      }

      permissionGranted = true;
    }

    return await Geolocator.getCurrentPosition(
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
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Text(isServiceDialog
            ? 'Location Services Required'
            : 'Location Permission Required'),
        content: Text(isServiceDialog
            ? 'Please enable location services to continue.'
            : 'Please grant location permission to use this app.'),
        actions: [
          TextButton(
            onPressed: () async {
              await Geolocator.openAppSettings();
              Navigator.pop(context);
            },
            child: const Text('Open Settings'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
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
      logOutStatus: false,
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

  Future<bool> showLogoutConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text("Already Logged In"),
            content: const Text(
                "You are already logged in. Do you want to log out and log in again?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Yes"),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> forceLogoutPreviousDeviceSession(context) async {
    // Example if using Firebase Firestore
    // await FirebaseFirestore.instance

    //     .collection('users')
    //     .doc(userId)
    //     .update({'isLoggedIn': false});
    logOutUserAndAdmin(context);
  }
}
