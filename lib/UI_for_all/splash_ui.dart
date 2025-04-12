import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/UI_for_all/location_check_screen.dart';

import 'package:surveyist/userProviders/login_provider.dart';
import 'package:surveyist/userProviders/login_provider2.dart';
import 'package:surveyist/utils/app_image.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    //----------------------------------------------------------
    // Timer(
    //     const Duration(seconds: 3),
    //     () => Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) =>  LocationCheckScreen())));
    //-------------------------------------------------------------

    //_autoLogin();

    // Provider.of<LoginProvider2>(context, listen: false)
    //     .autoLoginForBoth(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
  Provider.of<LoginProvider2>(context, listen: false).autoLoginForBoth(context);
});
  }

  //future funtion for autologin...................
  // Future<void> _autoLogin() async {
  //   Provider.of<LoginProviderForUser>(context, listen: false)
  //       .autoLogin(context);
  // }

  // checkNwtworkStatus() {
  //   Provider.of<LoginProvider2>(context, listen: false).checkNwtworkStatus();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          // color: const Color.fromARGB(255, 228, 153, 41),
          height: MediaQuery.of(context).size.height * 50 / 100,
          width: MediaQuery.of(context).size.width * 100 / 100,
          child: Image.asset(
            Appimage.splashScreen,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
