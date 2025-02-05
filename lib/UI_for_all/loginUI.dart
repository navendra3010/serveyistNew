import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/UI_for_all/signUp_Ui.dart';
import 'package:surveyist/admin_uI/adminDashboard.dart';
import 'package:surveyist/localization/location.dart';
import 'package:surveyist/managerUI/managerDashboard.dart';
import 'package:surveyist/userProviders/locationProvider.dart';
import 'package:surveyist/userProviders/loginProvider.dart';
import 'package:surveyist/repositry/firebaseAuthentication.dart';
import 'package:surveyist/users_UI/userDashboard.dart';

import 'package:surveyist/utils/appButton.dart';
import 'package:surveyist/utils/appConstant.dart';
import 'package:surveyist/utils/appFont.dart';
import 'package:surveyist/utils/appImage.dart';

import 'package:surveyist/utils/app_Language.dart';

class LoginScreenForAll extends StatefulWidget {
  const LoginScreenForAll({super.key});

  @override
  State<LoginScreenForAll> createState() => _LoginScreenForAllState();
}

class _LoginScreenForAllState extends State<LoginScreenForAll> {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProviderForUser>(context);
    final locationProvider = Provider.of<LocationProviderr>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          //child: ChangeNotifierProvider<LoginProviderForUser>(
          //create: (context) => LoginProviderForUser(),
          //child: Consumer<LoginProviderForUser>(
          //  builder: (context, provider, child) {
          //return
          // child:MultiProvider(providers: [

          //child:Consumer<LoginProviderForUser>(builder: (context, value, child) {} ,)),
          //],

          child: Column(children: [
            //this column for login logo image and login name
            Column(
              children: [
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 30 / 100,
                    width: MediaQuery.of(context).size.width * 50 / 100,
                    // child:Image.asset(Appimage.SplashScreen,fit: BoxFit.fill,),
                    decoration: BoxDecoration(
                        // color: const Color.fromARGB(255, 228, 153, 41),
                        image: DecorationImage(
                            image: AssetImage(Appimage.SplashScreen),
                            fit: BoxFit.fill),
                        shape: BoxShape.circle),
                  ),
                ),
                Center(
                  child: Text(
                    Applanguage.signIn[Applanguage.language],
                    style: const TextStyle(
                        fontFamily: AppFont.fontFamily,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                ),
                Container(
                  child: TextField(
                    controller: userEmailController,
                    decoration: InputDecoration(
                        hintText: "Email",

                        // icon:Icon(Icons.person)
                        prefixIcon: Icon(
                          Icons.person,
                          size: 30,
                        )),
                    maxLength: 25,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 100,
                ),
                Container(
                  child: TextField(
                    controller: userPasswordController,
                    // keyboardType:,
                    decoration: InputDecoration(
                        hintText: "password",

                        // icon:Icon(Icons.person)
                        prefixIcon: Icon(
                          Icons.person,
                          size: 30,
                        ),
                        suffixIcon: Icon(Icons.password_sharp)),
                    maxLength: 10,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 3 / 100,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          print("this is forgor password scren will be ");
                        },
                        child: Text("Forgot_password")),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 100,
                ),
                loginProvider.isloading == true
                    ? CircularProgressIndicator()
                    : Container(
                        child: MyButton(
                            text: 'Login',
                            // color: const Color.fromARGB(255, 34, 137, 221),
                            color: const Color.fromARGB(255, 228, 153, 41),
                            onPressed: () async {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const SignUpScreenForAll()));
                              // ShowTaostMessage.toastMessage(context, "SuccesfullLogin");

                              // loginEmailWithPassword(

                              //    );
                              //  _currentPosition =
                              //     await Locations.getCurrentPosition();
                              // if (_currentPosition != null) {
                              //   _currentAddress =
                              //       await Locations.getAddressFromLatLng(
                              //           _currentPosition!);
                              //   setState(() {});
                              // } else {
                              //   print("Failed to get location.");
                              // }

                              // loginProvider.userLoginAuthantication(
                              //    context,
                              //    userEmailController.text.toString().trim(),
                              //     userPasswordController.text
                              //         .toString()
                              //         .trim());

                              // login(String email, String password, BuildContext context)async {
                              //  monitorLocationService(context);

                              // FirebaseAuth? user =
                              //     await loginProvider.userLoginAuthantication(
                              //         context,
                              //         userEmailController.text
                              //             .toString()
                              //             .trim(),
                              //         userPasswordController.text
                              //           ..toString()
                              //           ..trim());

                              // if (user!=null) {
                               

                              //   Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             UserDashBoardScreen()),
                              //   );
                              // }
                              loginProvider.login(
                                      context,
                                      userEmailController.text
                                          .toString()
                                          .trim(),
                                      userPasswordController.text
                                        ..toString()
                                        ..trim());

                            }),
                      ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 4 / 100,
                ),
                Container(
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 4 / 100,
                      ),
                      Container(
                        child: Text("Dont have account yet?"),
                      ),
                      Container(
                        child: TextButton(
                            onPressed: () {
                              print("sigh_up_screen");
                              //SignUpScreenForAll
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreenForAll(),
                                  ));
                            },
                            child: Text(Applanguage
                                .signupButtonText[Applanguage.language])),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
