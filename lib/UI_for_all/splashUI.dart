import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:surveyist/userProviders/loginProvider.dart';

import 'package:surveyist/utils/appImage.dart';

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
