import 'package:flutter/material.dart';
import 'package:surveyist/users_UI/task_submit_ui.dart';

import 'package:surveyist/utils/app_font.dart';

import 'package:surveyist/utils/app_language.dart';
import 'package:surveyist/utils/app_button.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Card(
                color: Colors.black,
                child: Text(
                  " Today_task ",
                  style: TextStyle(
                      fontFamily: AppFont.fontFamily,
                      fontSize: 15,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5 / 100,
            ),
            Container(
              decoration: BoxDecoration( 
                  color: const Color.fromARGB(255, 211, 204, 204),
                  border: Border.all(width: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Text(
                Applanguage.todayTask[Applanguage.language],
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                    fontFamily: AppFont.fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                    //color: const Color.fromARGB(255, 117, 119, 117),
                    ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 100,
            ),
            const Center(
              child: Card(
                color: Colors.black,
                child: Text(
                  " Task_date ",
                  style: TextStyle(
                      fontFamily: AppFont.fontFamily,
                      fontSize: 15,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5 / 100,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 4 / 100,
              width: MediaQuery.of(context).size.height * 100 / 100,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 211, 204, 204),
                  border: Border.all(width: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: Text(
                  Applanguage.todayTaskDate[Applanguage.language],
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                      fontFamily: AppFont.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                      //color: const Color.fromARGB(255, 117, 119, 117),
                      ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 100,
            ),
            const Center(
              child: Card(
                color: Colors.black,
                child: Text(
                  " Task_Due_Date",
                  style: TextStyle(
                      fontFamily: AppFont.fontFamily,
                      fontSize: 15,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5 / 100,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 4 / 100,
              width: MediaQuery.of(context).size.height * 100 / 100,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 211, 204, 204),
                  border: Border.all(width: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: Text(
                  Applanguage.taskDueDate[Applanguage.language],
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                      fontFamily: AppFont.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                      //color: const Color.fromARGB(255, 117, 119, 117),
                      ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 100,
            ),
            const Center(
              child: Card(
                color: Colors.black,
                child: Text(
                  " Task_location",
                  style: TextStyle(
                      fontFamily: AppFont.fontFamily,
                      fontSize: 15,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5 / 100,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 4 / 100,
              width: MediaQuery.of(context).size.height * 100 / 100,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 211, 204, 204),
                  border: Border.all(width: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: Text(
                  Applanguage.taskLocation[Applanguage.language],
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                      fontFamily: AppFont.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                      //color: const Color.fromARGB(255, 117, 119, 117),
                      ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 100,
            ),
            const Center(
              child: Card(
                color: Colors.black,
                child: Text(
                  " Task_Discription",
                  style: TextStyle(
                      fontFamily: AppFont.fontFamily,
                      fontSize: 15,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5 / 100,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 20 / 100,
              width: MediaQuery.of(context).size.height * 100 / 100,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 211, 204, 204),
                  border: Border.all(width: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: Text(
                  Applanguage.todayDescription[Applanguage.language],
                  maxLines: 20,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                      fontFamily: AppFont.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                      //color: const Color.fromARGB(255, 117, 119, 117),
                      ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 10 / 100,
            ),
            MyButton(
                text: "Submit_Report",
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TasksubmitPage()));
                })
          ],
        ),
      ),
    );
  }
}
