import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:surveyist/userProviders/commanProvider.dart';
import 'package:surveyist/userProviders/loginProvider.dart';
import 'package:surveyist/userProviders/userProjectProvider.dart';
import 'package:surveyist/users_UI/taskDetail.dart';
import 'package:surveyist/users_UI/userAllProjectUi.dart';

import 'package:surveyist/utils/appConstant.dart';
import 'package:surveyist/utils/appFont.dart';

import 'package:surveyist/utils/appImage.dart';

import 'package:surveyist/utils/footerForUsers.dart';

class UserDashBoardScreen extends StatefulWidget {
  final String? userId;
  UserDashBoardScreen({super.key, this.userId});

  @override
  State<UserDashBoardScreen> createState() => _UserDashBoardScreenState();
}

class _UserDashBoardScreenState extends State<UserDashBoardScreen> {
  List<dynamic> taskList = <dynamic>[
    {
      "TaskName": "complete all measurment and submit distance with elecation",
      "TaskAssignDate": "1-12-2024",
      "tasksdueDate": "12-12-2014",
      "status": "pending",
      "time": "9.40"
    },
    {
      "TaskName": "Complete Map",
      "TaskAssignDate": "1-12-2024",
      "tasksdueDate": "12-12-2014",
      "status": "pending",
      "time": "9.40"
    },
    {
      "TaskName": "Complete  Excel sheet",
      "TaskAssignDate": "1-12-2024",
      "tasksdueDate": "12-12-2014",
      "status": "pending",
      "time": "9.40"
    },
    {
      "TaskName": "submit Distance",
      "TaskAssignDate": "1-12-2024",
      "tasksdueDate": "12-12-2014",
      "status": "pending",
      "time": "9.40"
    },
    {
      "TaskName": "Complete Metrow work",
      "TaskAssignDate": "1-12-2024",
      "tasksdueDate": "12-12-2014",
      "status": "pending",
      "time": "9.40"
    },
  ];
//   Timer? _rootTimer;

//   @override
//  void initState()
//  {
//   super.initState();
//   getPrin();
//  }
//   void getPrin()
//   {

//     const time=const Duration(seconds:1);
//     _rootTimer=Timer(time,(){
//       printHello();
//     });

//   }

  // void printHello()
  // {
  //   print("hello");
  // }

  @override
  Widget build(BuildContext context) {
    final providerComman =
        Provider.of<CommanProviderForUser>(context, listen: false);
    final loginpro = Provider.of<LoginProviderForUser>(context, listen: false);
      final userProjectPro = Provider.of<UserProjectProviderClass>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 6 / 100,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 4 / 100,
              width: MediaQuery.of(context).size.width * 20 / 100,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 228, 153, 41),
                  borderRadius: BorderRadius.all(Radius.circular(80))),
              child: TextButton(
                  onPressed: () {
                    loginpro.userLogOut();
                  },
                  child: Center(child: Text("Log_out"))),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 3 / 100,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 42 / 100,
                width: MediaQuery.of(context).size.width * 95 / 100,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 228, 153, 41),
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 3 / 100,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell( onTap:() {
                            print("notification working");
                          },
                            child: Container(
                            
                              child: Image.asset(
                                Appimage.Notification,
                                fit: BoxFit.fill,
                                cacheHeight: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 1 / 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        child: Text("Categories",
                            style: TextStyle(
                                fontFamily: AppFont.fontFamily,
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 1 / 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            print("tap on attenafce");
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 13 / 100,
                            width: MediaQuery.of(context).size.width * 40 / 100,
                            // color:Colors.amberAccent,
                            decoration: BoxDecoration(
                                //border:Border.all(width: 0.5)
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                // color:
                                //     const Color.fromARGB(255, 193, 204, 192)
                                color: Colors.white),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        5 /
                                        100,
                                    width: MediaQuery.of(context).size.width *
                                        10 /
                                        100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage(Appimage.attendance),
                                            fit: BoxFit.fill)),
                                  ),
                                  Text("Attendance",
                                      style: TextStyle(
                                          fontFamily: AppFont.fontFamily,
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserAllProject(),
                                ));
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 13 / 100,
                            width: MediaQuery.of(context).size.width * 40 / 100,
                            // color:Colors.amberAccent,
                            decoration: BoxDecoration(
                                //border:Border.all(width: 0.5)
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.white),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        5 /
                                        100,
                                    width: MediaQuery.of(context).size.width *
                                        10 /
                                        100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(Appimage.task),
                                            fit: BoxFit.fill)),
                                  ),
                                  Text("All_Project",
                                      style: TextStyle(
                                          fontFamily: AppFont.fontFamily,
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            print("tap on attenafce");
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 13 / 100,
                            width: MediaQuery.of(context).size.width * 40 / 100,
                            // color:Colors.amberAccent,
                            decoration: BoxDecoration(
                                //border:Border.all(width: 0.5)
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.white),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        5 /
                                        100,
                                    width: MediaQuery.of(context).size.width *
                                        10 /
                                        100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(Appimage.leave),
                                            fit: BoxFit.fill)),
                                  ),
                                  Text("Leave_Request",
                                      style: TextStyle(
                                          fontFamily: AppFont.fontFamily,
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print("tap on  task");
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 13 / 100,
                            width: MediaQuery.of(context).size.width * 40 / 100,
                            // color:Colors.amberAccent,
                            decoration: BoxDecoration(
                                //border:Border.all(width: 0.5)
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: const Color.fromRGBO(255, 255, 255, 1)),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        5 /
                                        100,
                                    width: MediaQuery.of(context).size.width *
                                        10 /
                                        100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(Appimage.time),
                                            fit: BoxFit.fill)),
                                  ),
                                  Text("Time_Tracking",
                                      style: TextStyle(
                                          fontFamily: AppFont.fontFamily,
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                child: Text("All_Projects",
                    style: TextStyle(
                        fontFamily: AppFont.fontFamily,
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 100,
            ),
            ElevatedButton(onPressed: () {
              userProjectPro.taskUpdatePerProject();
              
            }, child:Text("get value"))
            

            // date hide code 24-2-2025--------------------------------------------------------------hide---------------------------------------

            // Container(
            //   height: MediaQuery.of(context).size.height *
            //       8 /
            //       100, // Set the height directly
            //   width: MediaQuery.of(context)
            //       .size
            //       .width, // Set the width to full width

            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: taskList.length,
            //     itemBuilder: (context, index) {
            //       return Column(
            //         children: [
            //           Container(
            //             height: MediaQuery.of(context).size.height *
            //                 7 /
            //                 100, // Height for each item
            //             width: MediaQuery.of(context).size.width *
            //                 38 /
            //                 100, // Width for each item
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.all(Radius.circular(15)),
            //               color: const Color.fromARGB(255, 228, 153, 41),
            //             ),
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Container(
            //                   child: Text(
            //                     "${taskList[index]["TaskName"]}",
            //                     maxLines: 1,
            //                     overflow: TextOverflow.ellipsis,
            //                     style: TextStyle(
            //                         fontSize: 12,
            //                         color: Colors.white,
            //                         fontFamily: AppFont.fontFamily,
            //                         fontWeight: FontWeight.w600),
            //                   ),
            //                 ),
            //                 Container(
            //                   child: Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceEvenly,
            //                     children: [
            //                       Text(
            //                         "${taskList[index]["TaskAssignDate"]}",
            //                         style: TextStyle(
            //                           fontSize: 12,
            //                           fontWeight: FontWeight.w600,
            //                           color: Colors.white,
            //                         ),
            //                       ),
            //                       Text(
            //                         "${taskList[index]["status"]}",
            //                         style: TextStyle(
            //                           fontSize: 12,
            //                           fontWeight: FontWeight.w600,
            //                           color: Colors.red,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           SizedBox(
            //             width: MediaQuery.of(context).size.width *
            //                 40 /
            //                 100, // Spacing between items
            //           ),
            //         ],
            //       );
            //     },
            //   ),
            // ),

            // TextButton(
            //     onPressed: () {
            //       loginpro.autoLogin(context);
            //     },
            //     child: Text("check funtion current  time"))

            //date hide code 24-2-2025--------------------------------------------------------------hide--- end ------------------------------------
          ],
        ),
      ),
      bottomNavigationBar: footerUiForUsers(
          notificationCount: 0, selectMenu2: ButtomMenu2.userHome),
    );
  }
}
