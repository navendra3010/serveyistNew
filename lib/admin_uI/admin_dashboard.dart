// ignore_for_file: avoid_types_as_parameter_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:surveyist/adminProvider/comman_provider_for_admin.dart';
import 'package:surveyist/admin_uI/create_new_users_ui.dart';

import 'package:surveyist/utils/app_constant.dart';
import 'package:surveyist/utils/app_footer.dart';

import 'package:surveyist/utils/text_style.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  
  @override
  Widget build(BuildContext context) {

    final commanprovide =
        Provider.of<CommanproviderAdmin>(context, listen: false);
       // bool isDarkmode=Theme.of(context).brightness == Brightness.dark;
        bool isDarkMode = Provider.of<CommanproviderAdmin>(context,listen: true).themeMode == ThemeMode.dark;
       
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 5 / 100,
            ),
            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 4 / 100,
                  width: MediaQuery.of(context).size.width * 20 / 100,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 228, 153, 41),
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                  child: TextButton(
                      onPressed: () {
                        //  loginpro.userLogOut();
                
                        // Consumer<CommanproviderAdmin>(builder:(context,commanproviderAdmin,child){
                        //   return
                        // },);
                        commanprovide.adminLogOut(context);
                      },
                      child: const Center(child: Text("Log_out"))),
                ),
                Switch(value:isDarkMode, onChanged: (isOn) {
                
                 // isOn?commanprovide.themeSwitchMode(ThemeMode.dark):commanprovide.themeSwitchMode(ThemeMode.light);
                 commanprovide.themeSwitchMode(isOn?ThemeMode.dark:ThemeMode.light);
                },)
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 25 / 100,
              width: MediaQuery.of(context).size.width * 100 / 100,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 228, 153, 41),
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 3 / 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildBoxContainer(
                          context, "new_users", const CreateNewUs()),
                      buildBoxContainer(context, "B"),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 3 / 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildBoxContainer(context, "C"),
                      buildBoxContainer(context, "D")
                    ],
                  ),
                ],
              ),
            ),
            //decoration box container end here...................................................
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Active users",
                  style: CustomText.nameOfTextStyle,
                ),
                InkWell(
                    onTap: () {
                      commanprovide.selectDateforLoginFiltering(context);
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(Icons.calendar_month),
                          Text("Select Date"),
                        ],
                      ),
                    )),
                Flexible(
                  child: SizedBox(
                    width: 80.0, // Fixed width
                    height: 40.0, // Fixed height
                    child: TextField(
                        controller: commanprovide.selectfilterDateController),
                  ),
                ),
                // TextButton(
                //     onPressed: () {
                //       commanproviderAdmin.dateKey = commanproviderAdmin
                //           .selectfilterDateController.text
                //           .trim();
                //     },
                //     child: Text("Search"))
              ],
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 100,
            ),
            Consumer<CommanproviderAdmin>(
                builder: (context, commanprovide, child) {
              return StreamBuilder<List<QuerySnapshot<Map<String, dynamic>>>>(
                  stream: commanprovide.allLoginUser(commanprovide.dateKey =
                      commanprovide.selectfilterDateController.text.trim()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("no user Found"),
                      );
                    }
                    var users = snapshot.data!
                        // ignore: non_constant_identifier_names
                        .expand((QuerySnapshot) => QuerySnapshot.docs)
                        .toList();
                    if (users.isEmpty) {
                      return const Center(
                        child: Text(("no login found yet")),
                      );
                    }
                    // final userIdd=users.keys.toList();
                    return Expanded(
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final data = users[index].data();
                          // final loginTime = data['login_time'] ?? 'no data';
                          List<dynamic> loc = data["location"] ?? [];
                          String add = loc[0]["address"];
                          String addtrim = add.substring(5, 15);
                          // int len = (users.length);

                          String calculateWorkingHour(
                              String? logTime, String? outTime) {
                            if (logTime == null || outTime == null) {
                              return "invalid";
                            }
                            String? login = logTime.trim();
                            String logut = outTime.trim();
                            DateFormat format = DateFormat("hh:mm:ss a");

                            // var convertFormate=format.format(DateTime.now());

                            DateTime loginTime = format.parse(login);
                            DateTime logOutTime = format.parse(logut);
                            Duration difference =
                                logOutTime.difference(loginTime);
                            int hour = difference.inHours;
                            int minutes = difference.inMinutes.remainder(60);
                            int seconds = difference.inSeconds.remainder(60);
                            // print("total working hour${hour}-${minutes}-${seconds}");
                            return "${hour}H-${minutes}M-${seconds}S";
                          }

                          return Container(
                            height:
                                MediaQuery.of(context).size.height * 9 / 100,
                            width: MediaQuery.of(context).size.width * 9 / 100,
                            decoration: const BoxDecoration(

                                // color: Colors.amber

                                ),
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    // crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data['full_name']}",
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                5 /
                                                100,
                                      ),
                                      Text(
                                        "${data['employeId']}",
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      //starting-----------------------
                                      Column(
                                        children: [
                                          const Text(
                                            "Login_Time",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "${data["Login_time"]}",
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      //ending---------------------------
                                      Column(
                                        children: [
                                          const Text(
                                            "Location",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            addtrim,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Text(
                                            "Working_hour",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            calculateWorkingHour(
                                                data["Login_time"],
                                                data["LogOut_time"]),
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Card(
                                        shape: const LinearBorder(),
                                        //color: data["LogOut_status"]==true?Colors.red:Colors.green,
                                        child: Column(
                                          children: [
                                            Text(
                                              "LogOut_Time",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color:
                                                      data["LogOut_status"] ==
                                                              true
                                                          ? Colors.red
                                                          : Colors.green,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "${data["LogOut_time"]}",
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  });
            })

//------------------------ending login details fatch
          ],
        ),
      ),
      bottomNavigationBar:
          const AppFooterUi(notificationCount: 0, selectMenu: ButtomMenu.home),
    );
  }

  void navigateToScreen(BuildContext context, Widget? destination) {
    if (destination != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination),
      );
    } else {
      // Optional: Show a snackbar or log a message if no destination
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No destination set for this button.')),
      );
    }
  }

//this is for basically starting container--------------------------
  Widget buildBoxContainer(BuildContext context, text, [Widget? designation]) {
    return TextButton(
      onPressed: () {
        navigateToScreen(context, designation);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 7 / 100,
        width: MediaQuery.of(context).size.width * 30 / 100,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Center(
          child: Text(
            text,
            style: CustomText.nameOfTextStyle,
          ),
        ),
      ),
    );
  }
  //ending----------------------------
}
