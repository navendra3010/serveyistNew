import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/adminProvider/accountCreateprovider.dart';

import 'package:surveyist/utils/appFont.dart';
import 'package:surveyist/utils/appImage.dart';

class ViewUserDetailsOnlyadmin extends StatefulWidget {
  String? userID;
   ViewUserDetailsOnlyadmin({super.key,  required this. userID,});

  @override
  State<ViewUserDetailsOnlyadmin> createState() =>
      _ViewUserDetailsOnlyadminState();
}

class _ViewUserDetailsOnlyadminState extends State<ViewUserDetailsOnlyadmin> {
  @override
  void initState() {
    super.initState();
    Provider.of<Accountcreate>(context, listen: false)
        .fatchUserAccountDetails(widget.userID);
  }

  // void _showAlertDialog(BuildContext context, String name) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Edit/UpName"),
  //         content: Text('This is the alert content.'),
  //         actions: [
  //           TextField(
  //             decoration: InputDecoration(
  //               hintText: name,
  //             ),
  //           ),
  //           Card(
  //             child: Text(
  //               "update",
  //               style:
  //                   TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
  //             ),
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final detailsProvider=Provider.of<Accountcreate>(context).model;
     if(detailsProvider==null)
     {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
     }
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 100,
//               onPressed: () {
//         Navigator.pop(context);
// }
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 6 / 100,
                    width: MediaQuery.of(context).size.width * 20 / 100,
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              height: MediaQuery.of(context).size.height * 2 / 100,
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
                        Text("${detailsProvider!.userName}")
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     _showAlertDialog(context, "jack_charlie");
                  //   },
                  //   child: Container(
                  //     child: Card(
                  //       child: Text("Edit"),
                  //     ),
                  //   ),
                  // ),
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
                        Text("${detailsProvider!.userEmail}")
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     _showAlertDialog(context, "jack1@gmail.com");
                  //   },
                  //   child: Container(
                  //     child: Card(
                  //       child: Text("Edit"),
                  //     ),
                  //   ),
                  // ),
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
                          "Employe_Id",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: AppFont.fontFamily,
                              fontWeight: FontWeight.w800),
                        ),
                        Text("${detailsProvider!.userEmployeId}")
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     _showAlertDialog(context, "7978675900");
                  //   },
                  //   child: Container(
                  //     child: Card(
                  //       child: Text("Edit"),
                  //     ),
                  //   ),
                  // ),
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
                       Text("${detailsProvider!.userLoginId}")
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     _showAlertDialog(context, "Bhopal Isbt Road");
                  //   },
                  //   child: Container(
                  //     child: Card(
                  //       child: Text("Edit"),
                  //     ),
                  //   ),
                  // ),
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
                          "Login_password",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: AppFont.fontFamily,
                              fontWeight: FontWeight.w800),
                        ),
                         Text("${detailsProvider!.loginPassword}")
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     _showAlertDialog(context, "site Engineer");
                  //   },
                  //   child: Container(
                  //     child: Card(
                  //       child: Text("Edit"),
                  //     ),
                  //   ),
                  // ),
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
                          "Mobile_Number",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: AppFont.fontFamily,
                              fontWeight: FontWeight.w800),
                        ),
                         Text("${detailsProvider!.userMobileNumber}")
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     _showAlertDialog(context, "site Engineer");
                  //   },
                  //   child: Container(
                  //     child: Card(
                  //       child: Text("Edit"),
                  //     ),
                  //   ),
                  // ),
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
            //----------------------------------//------------------
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
                         Text("${detailsProvider!.userDateOfBirth}")
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     _showAlertDialog(context, "site Engineer");
                  //   },
                  //   child: Container(
                  //     child: Card(
                  //       child: Text("Edit"),
                  //     ),
                  //   ),
                  // ),
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
                         Text("${detailsProvider!.userGender}")
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     _showAlertDialog(context, "site Engineer");
                  //   },
                  //   child: Container(
                  //     child: Card(
                  //       child: Text("Edit"),
                  //     ),
                  //   ),
                  // ),
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
                         Text("${detailsProvider!.userAddress}")
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     _showAlertDialog(context, "site Engineer");
                  //   },
                  //   child: Container(
                  //     child: Card(
                  //       child: Text("Edit"),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            
            
          ],
        ),
      ),
    );
  }
}
