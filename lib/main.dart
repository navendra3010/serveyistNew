import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/UI_for_all/splash_ui.dart';
import 'package:surveyist/adminProvider/account_create_provider.dart';

import 'package:surveyist/adminProvider/admin_project_provider.dart';

import 'package:surveyist/adminProvider/comman_provider_for_admin.dart';
import 'package:surveyist/userProviders/comman_provider.dart';
import 'package:surveyist/userProviders/location_provider.dart';
import 'package:surveyist/userProviders/login_provider.dart';
import 'package:surveyist/userProviders/user_project_provider.dart';
import 'package:surveyist/utils/app_font.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LoginProviderForUser()),
      ChangeNotifierProvider(create: (context) => LocationProviderr()),
      ChangeNotifierProvider(create: (context) => Accountcreate()),
      ChangeNotifierProvider(create: (context) => CommanProviderForUser()),
      ChangeNotifierProvider(create: (context) => CommanproviderAdmin()),
      ChangeNotifierProvider(create: (context) => Projectprovider()),
      ChangeNotifierProvider(create: (context) => UserProjectProviderClass()),
    ],
    child: const MyApp(),
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
