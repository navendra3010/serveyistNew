import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/userProviders/userProjectProvider.dart';
import 'package:surveyist/utils/appConstant.dart';
import 'package:surveyist/utils/appFont.dart';
import 'package:surveyist/utils/footerForUsers.dart';

class UserWorkHistory extends StatefulWidget {
  UserWorkHistory({super.key});

  @override
  State<UserWorkHistory> createState() => _UserWorkHistoryState();
}

class _UserWorkHistoryState extends State<UserWorkHistory> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProjectProviderClass>(context, listen: false)
        .allProjectTask();
  }

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<UserProjectProviderClass>(context,listen: false);

    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 6 / 100,
            ),
           
            Container(
              child: Center(
                child: Text(
                  "Work_History",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromARGB(255, 206, 140, 140)),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 6 / 100,
            ),
            historyProvider.historyOfTask.isEmpty
                ? Center(
                    child:Text("Not Have Any History"),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: historyProvider.historyOfTask.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data =
                            historyProvider.historyOfTask[index]["data"];
                        Timestamp timestamp = data["taskStartDate"];
                        DateTime date = timestamp.toDate();
                        String formattedDate =
                            "${date.day}/${date.month}/${date.year}";
                        //-----------------------//--------------------------

                        Timestamp timestamp2 = data["taskEndDate"];
                        DateTime date2 = timestamp2.toDate();
                        String formattedDate2 =
                            "${date2.day}/${date2.month}/${date2.year}";
                        print(formattedDate2);
                        // print(data);

                        return Column(
                          children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 17 / 100,
                              width:
                                  MediaQuery.of(context).size.width * 80 / 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.8 /
                                        100,
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          80 /
                                          100,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              3 /
                                              100,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 228, 153, 41),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Text(
                                          "${data["taskName"]}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontFamily: AppFont.fontFamily,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        3 /
                                        100,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          child: Center(
                                            child: Text(
                                              "TaskAssignDate:-",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // width: MediaQuery.of(context).size.width *
                                          //     50 /
                                          //     100,
                                          // color: const Color.fromARGB(255, 151, 223, 223),
                                          child: Text(
                                            "${formattedDate}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.8 /
                                        100,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          child: Center(
                                            child: Text(
                                              "TasksdueDate:-",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // width: MediaQuery.of(context).size.width *
                                          //     50 /
                                          //     100,
                                          // color:Colors.amber,
                                          child: Text(
                                            "${formattedDate2}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.8 /
                                        100,
                                  ),
                                  // Container(
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceAround,
                                  //     children: [
                                  //       Container(
                                  //         child: Center(
                                  //           child: Text(
                                  //             "TaskSubmitDate-",
                                  //             style: TextStyle(
                                  //                 fontSize: 12,
                                  //                 fontWeight: FontWeight.w600,
                                  //                 color: Colors.grey),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       Container(
                                  //         // width: MediaQuery.of(context).size.width *
                                  //         //     50 /
                                  //         //     100,
                                  //         // color:Colors.amber,
                                  //         child: Text(
                                  //           "${worklist[index]["TaskSubmitDate"]}",
                                  //           style: TextStyle(
                                  //               fontSize: 12,
                                  //               fontWeight: FontWeight.w600,
                                  //               color: Colors.grey),
                                  //           overflow: TextOverflow.ellipsis,
                                  //           maxLines: 3,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: MediaQuery.of(context).size.height *
                                  //       0.8 /
                                  //       100,
                                  // ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          child: Center(
                                            child: Text(
                                              "TaskStatus-",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // width: MediaQuery.of(context).size.width *
                                          //     50 /
                                          //     100,
                                          // color:Colors.amber,
                                          child: Text(
                                            "${data["status"]}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: data["status"] ==
                                                        "completed"
                                                    ? Colors.green
                                                    : Colors.red),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 1 / 100,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: footerUiForUsers(
          notificationCount: 0, selectMenu2: ButtomMenu2.UserWorkHistory),
    );
  }
}
