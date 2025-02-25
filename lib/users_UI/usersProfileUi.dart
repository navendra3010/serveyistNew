
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/userModel/userProfilemodel.dart';
import 'package:surveyist/userProviders/commanProvider.dart';

import 'package:surveyist/utils/appConstant.dart';
import 'package:surveyist/utils/appFont.dart';

import 'package:surveyist/utils/appImage.dart';
import 'package:surveyist/utils/footerForUsers.dart';

class UsersprofilePage extends StatefulWidget {
  const UsersprofilePage({super.key});

  @override
  State<UsersprofilePage> createState() => _UsersprofilePageState();
}

class _UsersprofilePageState extends State<UsersprofilePage> {
  late Future<Userprofilemodel?> _userProfileFuture;

  

  void _showAlertDialog(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit/UpDate"),
          content: Text('This is the alert content.'),
          actions: [
            TextField(
              decoration: InputDecoration(
                hintText: name,
              ),
            ),
            Card(
              child: Text(
                "update",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
            )
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<CommanProviderForUser>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            FutureBuilder<Userprofilemodel?>(
              future: profileProvider
                  .getUserInfo(), // Use the Future from the provider
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
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
                        Center(
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
                          height: MediaQuery.of(context).size.height * 5 / 100,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height *
                                    6 /
                                    100,
                                width: MediaQuery.of(context).size.width *
                                    20 /
                                    100,
                                // child:Image.asset(Appimage.SplashScreen,fit:BoxFit.fill,),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(Appimage.profileImage),
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Card(child: Icon(Icons.delete)),
                                    Card(
                                      child: Icon(Icons.upload),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 5 / 100,
                        ),
                        Container(
                          height: 0.5,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 1 / 100,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: AppFont.fontFamily,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text("${userProfile!.userName}")
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showAlertDialog(context, "jack_charlie");
                                },
                                child: Container(
                                  child: Card(
                                    child: Text("Edit"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Container(
                          height: 0.5,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: AppFont.fontFamily,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text("${userProfile.userEmail}")
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showAlertDialog(context, "jack1@gmail.com");
                                },
                                child: Container(
                                  child: Card(
                                    child: Text("Edit"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Container(
                          height: 0.5,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Gender",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: AppFont.fontFamily,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text("${userProfile.userGender}")
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showAlertDialog(context, "7978675900");
                                },
                                child: Container(
                                  child: Card(
                                    child: Text("Edit"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Container(
                          height: 0.5,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Address",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: AppFont.fontFamily,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text("${userProfile.userAddress}")
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showAlertDialog(context, "Bhopal Isbt Road");
                                },
                                child: Container(
                                  child: Card(
                                    child: Text("Edit"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Container(
                          height: 0.5,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date_Of_Birth",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: AppFont.fontFamily,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text("${userProfile.userDateOfBirth}")
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showAlertDialog(context, "site Engineer");
                                },
                                child: Container(
                                  child: Card(
                                    child: Text("Edit"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Container(
                          height: 0.5,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Login_Id",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: AppFont.fontFamily,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text("${userProfile.userLoginId}")
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showAlertDialog(context, "site Engineer");
                                },
                                child: Container(
                                  child: Card(
                                    child: Text("Edit"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Container(
                          height: 0.5,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "EmployeID",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: AppFont.fontFamily,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text("${userProfile.userEmployeId}")
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showAlertDialog(context, "site Engineer");
                                },
                                child: Container(
                                  child: Card(
                                    child: Text("Edit"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Container(
                          height: 0.5,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Address",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: AppFont.fontFamily,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text("${userProfile.userAddress}")
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showAlertDialog(context, "site Engineer");
                                },
                                child: Container(
                                  child: Card(
                                    child: Text("Edit"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(child: Text("No data available"));
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: footerUiForUsers(
          notificationCount: 0, selectMenu2: ButtomMenu2.userprofile),
    );
  }
}
