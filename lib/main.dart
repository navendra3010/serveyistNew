import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:provider/provider.dart';
import 'package:surveyist/UI_for_all/splashUI.dart';
import 'package:surveyist/adminProvider/accountCreateprovider.dart';
import 'package:surveyist/adminProvider/adminHomeProvider.dart';
import 'package:surveyist/adminProvider/adminoperationProvider.dart';
import 'package:surveyist/adminProvider/commanproviderforAdmin.dart';
import 'package:surveyist/userProviders/commanProvider.dart';
import 'package:surveyist/userProviders/locationProvider.dart';
import 'package:surveyist/userProviders/loginProvider.dart';
import 'package:surveyist/utils/appFont.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      //Provider(create: (context) =>(),),

      ChangeNotifierProvider(create: (context) => LoginProviderForUser()),
      ChangeNotifierProvider(create: (context) => LocationProviderr()),
      ChangeNotifierProvider(create: (context) => Adminhomeprovider()),
      ChangeNotifierProvider(create: (context) => AllOpeationAndUpdate()),
      ChangeNotifierProvider(create: (context) => Accountcreate()),
      ChangeNotifierProvider(create: (context) => CommanProviderForUser()),
      ChangeNotifierProvider(create: (context) => CommanproviderAdmin()),
    ],
    child: MyApp(),
  ));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: AppFont.fontFamily,
      ),
      home: const Splash(),
    );
  }
}
