import 'package:flutter/material.dart';
import 'package:surveyist/utils/appFont.dart';
import 'package:surveyist/utils/appImage.dart';

class ViewUserDetailsOnlyadmin extends StatefulWidget {
  const ViewUserDetailsOnlyadmin({super.key});

  @override
  State<ViewUserDetailsOnlyadmin> createState() => _ViewUserDetailsOnlyadminState();
}

class _ViewUserDetailsOnlyadminState extends State<ViewUserDetailsOnlyadmin> {
  void _showAlertDialog(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit/UpName"),
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
    return Scaffold(
      
      appBar: AppBar(
        
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
           
            SizedBox(
              height: MediaQuery.of(context).size.height * 10 / 100,
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
                        Text("jack_charlie")
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
                        Text("jack1@gmail.com")
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
                          "Mobile",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: AppFont.fontFamily,
                              fontWeight: FontWeight.w800),
                        ),
                        Text("7978675900")
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
                        Text("Bhopal Isbt Road")
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
                          "Designation",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: AppFont.fontFamily,
                              fontWeight: FontWeight.w800),
                        ),
                        Text("Site Engineer")
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
          ],
        ),
      ),
    );
  }
}
