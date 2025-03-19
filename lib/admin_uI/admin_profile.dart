import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/adminProvider/comman_provider_for_admin.dart';
import 'package:surveyist/userModel/user_profile_model.dart';
import 'package:surveyist/utils/app_constant.dart';
import 'package:surveyist/utils/app_font.dart';
import 'package:surveyist/utils/app_footer.dart';
import 'package:surveyist/utils/app_image.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final adminProviderProfile =
        Provider.of<CommanproviderAdmin>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            FutureBuilder<Userprofilemodel?>(
              future: adminProviderProfile
                  .getAdminInfo(), // Use the Future from the provider
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 1 / 100,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 1 / 100,
                        ),
                        Center(
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 10 / 100,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(Appimage.splashScreen),
                                ),
                                shape: BoxShape.circle),
                          ),
                        ),
                        const Center(
                            child: Card(
                          child: Text(
                            "Admin_Profile",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: AppFont.fontFamily,
                                fontWeight: FontWeight.w800),
                          ),
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 1 / 100,
                        ),
                        // Container(
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       // Container(
                        //       //   height: MediaQuery.of(context).size.height *
                        //       //       6 /
                        //       //       100,
                        //       //   width: MediaQuery.of(context).size.width *
                        //       //       20 /
                        //       //       100,
                        //       //   decoration: BoxDecoration(
                        //       //       shape: BoxShape.circle,
                        //       //       image: DecorationImage(
                        //       //         image: AssetImage(Appimage.profileImage),
                        //       //         fit: BoxFit.fill,
                        //       //       )),
                        //       // ),
                        //       // Container(
                        //       //   child: Row(
                        //       //     mainAxisAlignment:
                        //       //         MainAxisAlignment.spaceAround,
                        //       //     children: [
                        //       //       Card(child: Icon(Icons.delete)),
                        //       //       Card(
                        //       //         child: Icon(Icons.upload),
                        //       //       ),
                        //       //     ],
                        //       //   ),
                        //       // ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 2 / 100,
                        ),
                        Container(
                          height: 0.5,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 1 / 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Name",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppFont.fontFamily,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text("${userProfile.userName}")
                              ],
                            ),
                          ],
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Email",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: AppFont.fontFamily,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text("${userProfile.userEmail}")
                                ],
                              ),
                            
                          ],
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Gender",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: AppFont.fontFamily,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text("${userProfile.userGender}")
                                ],
                              
                            ),
                          ],
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Address",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppFont.fontFamily,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text("${userProfile.userAddress}")
                              ],
                            ),
                          ],
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
                         Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Date_Of_Birth",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: AppFont.fontFamily,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text("${userProfile.userDateOfBirth}")
                                ],
                              ),
                            ],
                          
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Login_Id",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: AppFont.fontFamily,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text("${userProfile.userLoginId}")
                              ],
                            ),
                          ],
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
                         Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "EmployeID",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: AppFont.fontFamily,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text("${userProfile.userEmployeId}")
                                ],
                              ),
                            ],
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
                         Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Address",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: AppFont.fontFamily,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text("${userProfile.userAddress}")
                                ],
                              ),
                            ],
                          
                        ),
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
      bottomNavigationBar: const AppFooterUi(
          notificationCount: 0, selectMenu: ButtomMenu.profile),
    );
  }
}
