import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:surveyist/userModel/userRegistrationModel.dart';
import 'package:surveyist/userProviders/sighUpProvider.dart';
import 'package:surveyist/utils/appButton.dart';
import 'package:surveyist/utils/appFont.dart';
import 'package:surveyist/utils/appImage.dart';

import '../utils/app_Language.dart';

class SignUpScreenForAll extends StatefulWidget {
  const SignUpScreenForAll({super.key});

  @override
  State<SignUpScreenForAll> createState() => _SignScreenForAllState();
}

class _SignScreenForAllState extends State<SignUpScreenForAll> {
  TextEditingController userEmailSignController = TextEditingController();
  TextEditingController userPasswordSignController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("sigh_in"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: ChangeNotifierProvider<Sighupprovider>(
            create: (context) => Sighupprovider(),
            child:
                Consumer<Sighupprovider>(builder: (context, sighUpProvider, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    //this column for login logo image and login name
                    Column(
                      children: [
                        Center(
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 15 / 100,
                            width: MediaQuery.of(context).size.width * 50 / 100,
                            // child:Image.asset(Appimage.SplashScreen,fit: BoxFit.fill,),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(Appimage.SplashScreen),
                                    fit: BoxFit.fill),
                                shape: BoxShape.circle),
                          ),
                        ),
                        Center(
                          child: Text(
                            Applanguage.signUP[Applanguage.language],
                            style: const TextStyle(
                                fontFamily: AppFont.fontFamily,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ),
                        ),
                        TextField(
                            controller: userEmailSignController,
                            decoration: const InputDecoration(
                                hintText: "Email",

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
                            controller: userPasswordSignController,
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 7 / 100,
                        ),
                        // Provider.isloading == true
                        //     ? CircularProgressIndicator()
                        //     : Container(
                        //         child: MyButton(
                        //           text: "Sigh_up",
                        //           color: const Color.fromARGB(255, 228, 153, 41),
                        //           onPressed: () {
                        //             Provider.sighupAthuntication(
                        //                 userEmailSignController.text
                        //                     .toString()
                        //                     .trim(),
                        //                 userPasswordSignController.text
                        //                     .toString()
                        //                     .trim(),
                        //                 context);
                        //           },
                        //         ),
                        //       ),
                        //here i will user registration with fire store also..
                        sighUpProvider.isloading == true
                            ? const CircularProgressIndicator()
                            :  MyButton(
                                  text: "Sigh_up",
                                  color:
                                      const Color.fromARGB(255, 228, 153, 41),
                                  onPressed: () {
                                    //  Provider.sighupAthuntication(
                                    //      userEmailSignController.text
                                    //          .toString()
                                    //          .trim(),
                                    //      userPasswordSignController.text
                                    //          .toString()
                                    //          .trim(),
                                    //      context);
                                    UserRegistrationmodel userReg =
                                        UserRegistrationmodel();

                                    userReg.email = userEmailSignController.text
                                        .toString()
                                        .trim();
                                    userReg.password =
                                        userPasswordSignController.text
                                            .toString()
                                            .trim();
                                    userReg.isAdmin = true;

                                    sighUpProvider.createNewUser(userReg, context);
                                  },
                                ),
                              

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 4 / 100,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
