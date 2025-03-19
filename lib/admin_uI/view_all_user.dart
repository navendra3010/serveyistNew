import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/adminModel/all_users_model.dart';

import 'package:surveyist/adminProvider/comman_provider_for_admin.dart';
import 'package:surveyist/admin_uI/users_details.dart';
import 'package:surveyist/utils/app_constant.dart';
import 'package:surveyist/utils/app_font.dart';
import 'package:surveyist/utils/app_footer.dart';


class ViewAllUserPage extends StatefulWidget {
 const ViewAllUserPage({super.key});

  @override
  State<ViewAllUserPage> createState() => _ViewAllUserPageState();
}

class _ViewAllUserPageState extends State<ViewAllUserPage> {
  @override
  Widget build(BuildContext context) {
    final adminCommanprovider =
        Provider.of<CommanproviderAdmin>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 5 / 100,
            ),
            const Center(
              child: Card(
                color: Colors.black,
                child: Text(
                  "All_users......",
                  style: TextStyle(
                      fontFamily: AppFont.fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
            const Center(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "search users......",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
            StreamBuilder<List<ViewAllUsers?>>(
                stream: adminCommanprovider.allUsersStream,
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
                  var users = snapshot.data;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: users!.length,
                      itemBuilder: (context, index) {
                        final user = users[index];

                        ///print(user!.uniqueId);
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 6 / 100,
                          width: MediaQuery.of(context).size.width * 9 / 100,
                          child: InkWell(
                            onTap: () {
                              String? userId = user.uniqueId;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ViewUserDetailsOnlyadmin(
                                            userID: userId),
                                  ));
                            },
                            child: Card(
                              child: Column(
                                children: [
                                  Text(
                                      "Employe_ID:-${user!.userEmployeId ?? 'no name'}"),
                                  Text(
                                      "Email:-${user.userLoginId ?? 'no name'}"),
                                  // Text("${user['created_at'] ?? 'no name'}"),
                                  // Text("password:-${user.password?? 'no name'}"),
                                  // Text("user-Id: ${user.id ?? 'no name'}"),
                                  //  // Text("user_Email:-${user?? 'no name'}"),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
      bottomNavigationBar:
          const AppFooterUi(notificationCount: 0, selectMenu: ButtomMenu.users),
    );
  }
}
