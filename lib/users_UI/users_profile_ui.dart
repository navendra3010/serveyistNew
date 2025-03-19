import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/userModel/user_profile_model.dart';
import 'package:surveyist/userProviders/comman_provider.dart';

import 'package:surveyist/utils/app_constant.dart';
import 'package:surveyist/utils/app_font.dart';

import 'package:surveyist/utils/app_image.dart';
import 'package:surveyist/utils/footer_for_users.dart';

class UsersprofilePage extends StatefulWidget {
  const UsersprofilePage({super.key});

  @override
  State<UsersprofilePage> createState() => _UsersprofilePageState();
}

class _UsersprofilePageState extends State<UsersprofilePage> {

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<CommanProviderForUser>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            FutureBuilder<Userprofilemodel?>(
              future: profileProvider
                  .getUserInfo(), // Use the Future from the provider
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  final userProfile = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text('Name: ${userProfile!.userName}', style: TextStyle(fontSize: 18)),
                        // Text('Email: ${userProfile.userEmail}', style: TextStyle(fontSize: 18)),
                        // Text('Phone: ${userProfile.userMobileNumber}', style: TextStyle(fontSize: 18)),
                        // // Text('Name: ${userProfile.userMobileNumber}', style: TextStyle(fontSize: 18)),
                        // Text('emplpye_ID: ${userProfile.userEmployeId}', style: TextStyle(fontSize: 18)),
                        // Text('Date_Of_Birth: ${userProfile.userDateOfBirth}', style: TextStyle(fontSize: 18)),
                        //    Text('address: ${userProfile.userAddress}', style: TextStyle(fontSize: 18)),
                        // Text('Login_ID: ${userProfile.userLoginId}', style: TextStyle(fontSize: 18)),
                        // Text('role: ${userProfile.role}', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 1 / 100,
                        ),
                        const Center(
                            child: Card(
                          child: Text(
                            "My_Profile",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: AppFont.fontFamily,
                                fontWeight: FontWeight.w800),
                          ),
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 3 / 100,
                        ),

                        Center(
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 10 / 100,
                            width: MediaQuery.of(context).size.width * 30 / 100,
                            // child:Image.asset(Appimage.SplashScreen,fit:BoxFit.fill,),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(Appimage.splashScreen),
                                  //fit: BoxFit.fill,
                                )),
                          ),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 3 / 100,
                        ),
                        buildTextField(userProfile),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text("No data available"));
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const FooterUiForUsers(
          notificationCount: 0, selectMenu2: ButtomMenu2.userprofile),
    );
  }

  //  will call the function
  Widget buildTextField(Userprofilemodel userProfile) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      buildViewDetails("Name", userProfile.userName),
      buildViewDetails("Email", userProfile.userEmail),
      buildViewDetails("EmployeId", userProfile.userEmployeId),
      buildViewDetails("LoginId", userProfile.userLoginId),
      buildViewDetails("Date-of-Birth", userProfile.userEmail),
      buildViewDetails("Mobile-number", userProfile.userMobileNumber),
      buildViewDetails("Gender", userProfile.userGender),
    ]);
  }

  Widget buildViewDetails(String s, String? details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 0.5,
          color: Colors.grey,
        ),
        const SizedBox(height: 10),
        Text(
          s,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: AppFont.fontFamily,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text("$details"),
        const SizedBox(height: 10),
        Container(
          height: 0.5,
          color: Colors.grey,
        ),
      ],
    );
  }
}
