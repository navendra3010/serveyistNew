import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:surveyist/userProviders/comman_provider.dart';
import 'package:surveyist/userProviders/login_provider.dart';
import 'package:surveyist/userProviders/user_project_provider.dart';

import 'package:surveyist/users_UI/user_all_project_ui.dart';

import 'package:surveyist/utils/app_constant.dart';
import 'package:surveyist/utils/app_font.dart';

import 'package:surveyist/utils/app_image.dart';

import 'package:surveyist/utils/footer_for_users.dart';

class UserDashBoardScreen extends StatefulWidget {
  final String? userId;
 const UserDashBoardScreen({super.key, this.userId});

  @override
  State<UserDashBoardScreen> createState() => _UserDashBoardScreenState();
}

class _UserDashBoardScreenState extends State<UserDashBoardScreen> {
  
  @override
  void initState() {
    super.initState();
    Provider.of<UserProjectProviderClass>(context, listen: false)
        .taskUpdatePerProject();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CommanProviderForUser>(context, listen: false);
    final loginpro = Provider.of<LoginProviderForUser>(context, listen: false);
    Provider.of<UserProjectProviderClass>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(1),
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
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 228, 153, 41),
                  borderRadius: BorderRadius.all(Radius.circular(80))),
              child: TextButton(
                  onPressed: () {
                    loginpro.userLogOut();
                  },
                  child: const Center(child: Text("Log_out"))),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 3 / 100,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 42 / 100,
                width: MediaQuery.of(context).size.width * 95 / 100,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 228, 153, 41),
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 3 / 100,
                    ),
                     Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                            //  print("notification working");
                            },
                            child:  Image.asset(
                                Appimage.notification,
                                fit: BoxFit.fill,
                                cacheHeight: 25,
                              
                            ),
                          ),
                        ],
                      ),
                    
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 1 / 100,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Categories",
                            style: TextStyle(
                                fontFamily: AppFont.fontFamily,
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600)),
                      
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 1 / 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            //print("tap on attenafce");
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 13 / 100,
                            width: MediaQuery.of(context).size.width * 40 / 100,
                            // color:Colors.amberAccent,
                            decoration: const BoxDecoration(
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
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage(Appimage.attendance),
                                            fit: BoxFit.fill)),
                                  ),
                                  const Text("Attendance",
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
                                  builder: (context) => const UserAllProject(),
                                ));
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 13 / 100,
                            width: MediaQuery.of(context).size.width * 40 / 100,
                            // color:Colors.amberAccent,
                            decoration: const BoxDecoration(
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
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(Appimage.task),
                                            fit: BoxFit.fill)),
                                  ),
                                  const Text("All_Project",
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
                            //print("tap on attenafce");
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 13 / 100,
                            width: MediaQuery.of(context).size.width * 40 / 100,
                            // color:Colors.amberAccent,
                            decoration: const BoxDecoration(
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
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(Appimage.leave),
                                            fit: BoxFit.fill)),
                                  ),
                                  const Text("Leave_Request",
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
                            //print("tap on  task");
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 13 / 100,
                            width: MediaQuery.of(context).size.width * 40 / 100,
                            // color:Colors.amberAccent,
                            decoration: const BoxDecoration(
                                //border:Border.all(width: 0.5)
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color.fromRGBO(255, 255, 255, 1)),
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
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(Appimage.time),
                                            fit: BoxFit.fill)),
                                  ),
                                  const Text("Time_Tracking",
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
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 1 / 100,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20),
            //   child: Container(
            //     child: Text("All_Task",
            //         style: TextStyle(
            //             fontFamily: AppFont.fontFamily,
            //             fontSize: 15,
            //             color: Colors.black87,
            //             fontWeight: FontWeight.w600)),
            //   ),
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 1 / 100,
            // ),
            // ElevatedButton(onPressed: () {
            //   userProjectPro.taskUpdatePerProject();

            // }, child:Text("get value")),

          //  date hide code 24-2-2025--------------------------------------------------------------hide---------------------------------------

            // userProjectPro.tolist.isEmpty
            //     ? Center(
            //         child: Text("not have task"),
            //       )
            //     : Container(
            //         height: MediaQuery.of(context).size.height * 8 / 100,
            //         width: MediaQuery.of(context).size.width,
            //         child: ListView.builder(
            //           scrollDirection: Axis.horizontal,
            //           itemCount: userProjectPro.finalList.length,
            //           itemBuilder: (context, index) {
            //             List<Map<String, dynamic>>? team =
            //                 userProjectPro.tolist;

            //             return Column(
            //               children: [
            //                 Container(
            //                   height:
            //                       MediaQuery.of(context).size.height * 7 / 100,
            //                   width:
            //                       MediaQuery.of(context).size.width * 38 / 100,
            //                   decoration: BoxDecoration(
            //                     borderRadius:
            //                         BorderRadius.all(Radius.circular(15)),
            //                     color: const Color.fromARGB(255, 228, 153, 41),
            //                   ),
            //                   child: Column(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Container(
            //                         child: Text(
            //                           "${team[index]["data"]["taskName"]}",
            //                           maxLines: 1,
            //                           overflow: TextOverflow.ellipsis,
            //                           style: TextStyle(
            //                               fontSize: 12,
            //                               color: Colors.white,
            //                               fontFamily: AppFont.fontFamily,
            //                               fontWeight: FontWeight.w600),
            //                         ),
            //                       ),
            //                       Container(
            //                         child: Row(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.spaceEvenly,
            //                           children: [
            //                             Text(
            //                               "${taskList[index]["TaskAssignDate"]}",
            //                               style: TextStyle(
            //                                 fontSize: 12,
            //                                 fontWeight: FontWeight.w600,
            //                                 color: Colors.white,
            //                               ),
            //                             ),
            //                             Text(
            //                               "${taskList[index]["status"]}",
            //                               style: TextStyle(
            //                                 fontSize: 12,
            //                                 fontWeight: FontWeight.w600,
            //                                 color: Colors.red,
            //                               ),
            //                             ),
            //                           ],
            //                        ),
            //                      ),
            //                   ],
            //                 ),
            //                ),
            //                  SizedBox(
            //                   width: MediaQuery.of(context).size.width *
            //                       40 /
            //                       100, // Spacing between items
            //                 ),
            //               ],
            //             );
            //           },
            //         ),
            //       ),
                
                 
            // TextButton(
            //     onPressed: () {
            //       loginpro.autoLogin(context);
            //     },
            //     child: Text("check funtion current  time"))

            //date hide code 24-2-2025--------------------------------------------------------------hide--- end ------------------------------------
          ],
        ),
      ),
      bottomNavigationBar: const FooterUiForUsers(
          notificationCount: 0, selectMenu2: ButtomMenu2.userHome),
    );
  }
}
