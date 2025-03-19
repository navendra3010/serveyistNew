import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/adminModel/create_user_account_model.dart';
import 'package:surveyist/adminProvider/account_create_provider.dart';


import 'package:surveyist/utils/app_font.dart';
import 'package:surveyist/utils/app_image.dart';
import 'package:surveyist/utils/app_language.dart';
import 'package:surveyist/utils/app_button.dart';

class CreateNewUs extends StatefulWidget {
  const CreateNewUs({super.key});

  @override
  State<CreateNewUs> createState() => _CreateNewUsState();
}

class _CreateNewUsState extends State<CreateNewUs> {
  TextEditingController createFullName = TextEditingController();
  TextEditingController createDataOfBirth = TextEditingController();
  TextEditingController createGender = TextEditingController();
  TextEditingController createEmail = TextEditingController();
  TextEditingController createPhoneNumber = TextEditingController();
  TextEditingController createAddres = TextEditingController();
  TextEditingController createEmployeId = TextEditingController();
  TextEditingController cratePassword = TextEditingController();
  TextEditingController crateLoginID = TextEditingController();
  TextEditingController crateLoginPassword = TextEditingController();
  var items = [
    'Male',
    'Female',
    'other',
  ];

  @override
  Widget build(BuildContext context) {
    Provider.of<Accountcreate>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 5 / 100,
              ),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 10 / 100,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Appimage.splashScreen),
                      ),
                      shape: BoxShape.circle),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              Center(
                child: Text(
                  Applanguage.createNewUser[Applanguage.language],
                  style: const TextStyle(
                      fontFamily: AppFont.fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 100.0, // Fixed width for the label
                    child: Text('Full_Name:',
                        style: TextStyle(
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: 200.0, // Fixed width
                      height: 45.0, // Fixed height
                      child: TextField(
                        controller: createFullName,
                        decoration: const InputDecoration(
                          hintText: 'Enter Full_Name',
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 100.0, // Fixed width for the label
                    child: Text('Date Of Birth:',
                        style: TextStyle(
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: 200.0, // Fixed width
                      height: 45.0, // Fixed height
                      child: TextField(
                        controller: createDataOfBirth,
                        decoration: const InputDecoration(
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(15)
                          // ),
                          hintText: 'Date Of Birth',
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 100.0, // Fixed width for the label
                    child: Text('Gender:',
                        style: TextStyle(
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                  ),
                  Flexible(
                    child: SizedBox(
                        width: 200.0, // Fixed width
                        height: 45.0, // Fixed height
                        child: TextField(
                          controller: createGender,
                          decoration: InputDecoration(
                            suffixIcon: PopupMenuButton<String>(
                              icon: const Icon(Icons.arrow_drop_down),
                              onSelected: (String value) {
                                createGender.text = value;
                              },
                              itemBuilder: (BuildContext context) {
                                return items
                                    .map<PopupMenuItem<String>>((String value) {
                                  return  PopupMenuItem(
                                      value: value,
                                      child:  Text(value));
                                }).toList();
                              },
                            ),
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 100.0, // Fixed width for the label
                    child: Text('Email:',
                        style: TextStyle(
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: 200.0, // Fixed width
                      height: 45.0, // Fixed height
                      child: TextField(
                        controller: createEmail,
                        decoration: const InputDecoration(
                          hintText: 'Enter Email',
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 100.0, // Fixed width for the label
                    child: Text('user address:',
                        style: TextStyle(
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: 200.0, // Fixed width
                      height: 45.0, // Fixed height
                      child: TextField(
                        controller: createAddres,
                        decoration: const InputDecoration(
                          hintText: 'Enter Address',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 100.0, // Fixed width for the label
                    child: Text('EmployeId:',
                        style: TextStyle(
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: 200.0, // Fixed width
                      height: 45.0, // Fixed height
                      child: TextField(
                        controller: createEmployeId,
                        decoration: const InputDecoration(
                          hintText: 'Enter Employe Id',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 100.0, // Fixed width for the label
                    child: Text('user mobile:',
                        style: TextStyle(
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: 200.0, // Fixed width
                      height: 45.0, // Fixed height
                      child: TextField(
                        controller: createPhoneNumber,
                        decoration: const InputDecoration(
                          hintText: 'Enter Mobile number',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 100.0, // Fixed width for the label
                    child: Text('LoginID:',
                        style: TextStyle(
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: 200.0, // Fixed width
                      height: 45.0, // Fixed height
                      child: TextField(
                        controller: crateLoginID,
                        decoration: const InputDecoration(
                          hintText: 'Enter Login Id',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 100.0, // Fixed width for the label
                    child: Text('Password:',
                        style: TextStyle(
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: 200.0, // Fixed width
                      height: 45.0, // Fixed height
                      child: TextField(
                        controller: crateLoginPassword,
                        decoration: const InputDecoration(
                          hintText: 'Enter Login password',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 4 / 100,
              ),
              Consumer<Accountcreate>(
                  builder: (context, createProvider, child) {
                return createProvider.isAccountCreate == true
                    ? const CircularProgressIndicator()
                    : MyButton(
                        text: "Create_Account",
                        color: Colors.black,
                        onPressed: () {
                          UserAccount obj = UserAccount();
                          obj.fullName = createFullName.text.toString().trim();
                          obj.dob = createDataOfBirth.text.toString().trim();
                          obj.gender = createGender.text.toString().trim();
                          obj.email = createEmail.text.toString().trim();
                          obj.address = createAddres.text.toString().trim();
                          obj.employeId =
                              createEmployeId.text.toString().trim();
                          obj.mobileNumber =
                              createPhoneNumber.text.toString().trim();
                          obj.loginId = crateLoginID.text.toString().trim();
                          obj.loginPassword =
                              crateLoginPassword.text.toString().trim();
                          obj.isAdmin = true;
                          createProvider.userNewAccount(obj, context);
                        

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => AdminDashboardPage()),
                          // );
                        },
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
