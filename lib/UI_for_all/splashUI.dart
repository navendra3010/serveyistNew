import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/UI_for_all/loginUI.dart';
import 'package:surveyist/UI_for_all/signUp_Ui.dart';
import 'package:surveyist/admin_uI/adminDashboard.dart';
import 'package:surveyist/userProviders/loginProvider.dart';
import 'package:surveyist/users_UI/userDashboard.dart';
import 'package:surveyist/utils/appImage.dart';
import 'package:surveyist/utils/app_Language.dart';
import 'package:surveyist/utils/footerForUsers.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // Timer(
    //     Duration(seconds: 3),
    //     () => Navigator.pushReplacement(context,
    //         MaterialPageRoute(builder: (context) => UserDashBoardScreen())));

     _autoLogin();
  }

  //future funtion for autologin...................
  Future<void> _autoLogin() async {
    Provider.of<LoginProviderForUser>(context, listen: false)
        .autoLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // color: const Color.fromARGB(255, 228, 153, 41),
          height: MediaQuery.of(context).size.height * 100 / 100,
          width: MediaQuery.of(context).size.width * 100 / 100,
          child: Image.asset(
            Appimage.SplashScreen,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
