import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


import 'package:surveyist/userProviders/login_provider2.dart';

import 'package:surveyist/utils/app_font.dart';
import 'package:surveyist/utils/app_image.dart';

import 'package:surveyist/utils/app_language.dart';
import 'package:surveyist/utils/app_button.dart';

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
    // Provider.of<LoginProviderForUser>(context, listen: false);
    final loginAuth = Provider.of<LoginProvider2>(context, listen: false);
    // final locationProvider = Provider.of<LocationProviderr>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            // padding: const EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom)),
            child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 4 / 100,
              ),
              //this column for login logo image and login name
              Column(
                children: [
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 30 / 100,
                      //  width: MediaQuery.of(context).size.width * 50 / 100,
                      // child:Image.asset(Appimage.SplashScreen,fit: BoxFit.fill,),
                      decoration: const BoxDecoration(
                          // color: const Color.fromARGB(255, 228, 153, 41),
                          image: DecorationImage(
                            image: AssetImage(Appimage.splashScreen),
                            //  fit: BoxFit.fill
                          ),
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
                  TextField(
                    controller: userEmailController,
                    decoration: const InputDecoration(
                        hintText: "Login_Id",

                        // icon:Icon(Icons.person)
                        prefixIcon: Icon(
                          Icons.person,
                          size: 30,
                        )),
                    maxLength: 25,
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  TextField(
                    controller: userPasswordController,
                    // keyboardType:,
                    decoration: const InputDecoration(
                        hintText: "password",

                        // icon:Icon(Icons.person)
                        prefixIcon: Icon(
                          Icons.person,
                          size: 30,
                        ),
                        suffixIcon: Icon(Icons.password_sharp)),
                    maxLength: 10,
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 3 / 100,
                  // ),
                  // Row(
                  //   children: [
                  //     TextButton(
                  //         onPressed: () {

                  //         },
                  //         child: Text("Forgot_password")),
                  //   ],
                  // ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 7 / 100,
                  ),
                  //date 8-4-2025................................... comment for new provider
                  // Consumer<LoginProviderForUser>(
                  //     builder: (context, loginProvider, child) {
                  //   return loginProvider.isloading == true
                  //       ? const CircularProgressIndicator()
                  //       :  MyButton(
                  //               text: 'Login',
                  //               // color: const Color.fromARGB(255, 34, 137, 221),
                  //               color: const Color.fromARGB(255, 231, 128, 44),
                  //               onPressed: () async {
                  //                 loginProvider.login(
                  //                     context,
                  //                     userEmailController.text
                  //                         .toString()
                  //                         .trim(),
                  //                     userPasswordController.text
                  //                       ..toString()
                  //                       ..trim());
                  //               });

                  // }),
                  //date 8-4-2025................................... comment for new provider
                Consumer<LoginProvider2>(builder: (context, loginAuth, child) {
                  return loginAuth.isLoginTrue==true?const CircularProgressIndicator():
                
                  MyButton(
                      text: 'Login',
                      // color: const Color.fromARGB(255, 34, 137, 221),
                      color: const Color.fromARGB(255, 231, 128, 44),
                      onPressed: () {
                        loginAuth.userLogin(userEmailController.text+"@gmail.com".trim(),
                            userPasswordController.text.trim(), context);
                      });
                })

                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 4 / 100,
                  // ),
                  // Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 4 / 100,
                  // ),
                  // Container(
                  //   child: Text("Dont have account yet?"),
                  // ),
                  // Container(
                  //   child: TextButton(
                  //       onPressed: () {
                  //         print("sigh_up_screen");
                  //         //SignUpScreenForAll
                  //         // Navigator.push(
                  //         //     context,
                  //         //     MaterialPageRoute(
                  //         //       builder: (context) => SignUpScreenForAll(),
                  //         //     ));
                  //       },
                  //       child: Text(Applanguage
                  //           .signupButtonText[Applanguage.language])),
                  // ),
                  // ],
                  // ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
