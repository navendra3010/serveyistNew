// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/adminProvider/account_create_provider.dart';
import 'package:surveyist/adminProvider/admin_project_provider.dart';
import 'package:surveyist/userModel/user_profile_model.dart';

import 'package:surveyist/utils/app_font.dart';
import 'package:surveyist/utils/app_snack_bar_or_toast_message.dart';

class ViewUserDetailsOnlyadmin extends StatefulWidget {
  final userID;
  const ViewUserDetailsOnlyadmin({
    super.key,
    required this.userID,
  });

  @override
  State<ViewUserDetailsOnlyadmin> createState() =>
      _ViewUserDetailsOnlyadminState();
}

class _ViewUserDetailsOnlyadminState extends State<ViewUserDetailsOnlyadmin> {
  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _employeeIdController = TextEditingController();
    _loginIdController = TextEditingController();
    _mobileNumberController = TextEditingController();
    _dobController = TextEditingController();
    _addressController = TextEditingController();
    _genderController = TextEditingController();
    Provider.of<Accountcreate>(context, listen: false)
        .fatchUserAccountDetails(widget.userID);
  }

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _employeeIdController;
  late TextEditingController _loginIdController;
  late TextEditingController _mobileNumberController;
  late TextEditingController _dobController;
  late TextEditingController _addressController;
  late TextEditingController _genderController;

  @override
  Widget build(BuildContext context) {
    final detailsProvider = Provider.of<Accountcreate>(context,listen: true).model;
    final operationProvider = Provider.of<Projectprovider>(context,listen: false);
    if (detailsProvider == null) {
      return  const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    _nameController.text = detailsProvider.userName ?? '';
    _emailController.text = detailsProvider.userEmail ?? '';
    _employeeIdController.text = detailsProvider.userEmployeId ?? '';
    _loginIdController.text = detailsProvider.userLoginId ?? '';
    _mobileNumberController.text = detailsProvider.userMobileNumber ?? '';
    _dobController.text = detailsProvider.userDateOfBirth ?? '';
    _genderController.text = detailsProvider.userGender ?? '';
    _addressController.text = detailsProvider.userAddress ?? '';

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const Center(
                child: Text("USER DETAILS"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 1 / 100,
              ),

              Consumer<Projectprovider>(builder: (context,operationProvider , child) {
                
              return
              operationProvider.isEdited == true
                  ? _buildEditableForm(detailsProvider)
                  : _buildDetailsView(detailsProvider);
              }
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 3 / 100,
              ),
              operationProvider.isEdited == true
                  ? Center(
                      child: ElevatedButton(
                          onPressed: () {
                            // print(_nameController.text);
                            // print(_emailController.text);
                            // print(_employeeIdController.text);
                            // print(_mobileNumberController.text);
                            // print(_dobController.text);
                            // print(_genderController.text);
                            // print(_addressController.text);

                            // here i will update user details
                            FirebaseFirestore.instance
                                .collection("allusers")
                                .doc(widget.userID)
                                .update({
                              "address": _addressController.text.trim(),
                              "full_name": _nameController.text.trim(),
                              "email": _emailController.text.trim(),
                              "mobile_number":
                                  _mobileNumberController.text.trim(),
                              "employeId": _employeeIdController.text.trim(),
                              "gender": _genderController.text.trim(),
                              "date_Of_Birth": _dobController.text.trim()
                            }).then((value) {
                              ShowTaostMessage.toastMessage(context,
                                  "user Details has been updated successfully");
                            });
                          },
                          child: const Text(
                            "Update",
                            style: TextStyle(color: Colors.blue),
                          )))
                  : const SizedBox(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          operationProvider.formEdit();
        },
        child:
            Icon(operationProvider.isEdited == true ? Icons.save : Icons.edit),
      ),
    );
  }

  Widget _buildDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 0.5,
          color: Colors.grey,
        ),
        const SizedBox(height: 16),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: AppFont.fontFamily,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(value),
        const SizedBox(height: 16),
        Container(
          height: 0.5,
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: AppFont.fontFamily,
            fontWeight: FontWeight.w800,
          ),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDetailsView(detailsProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetail("Name", detailsProvider.userName),
        _buildDetail("Email", detailsProvider.userEmail),
        _buildDetail("Employee ID", detailsProvider.userEmployeId),
        _buildDetail("Login ID", detailsProvider.userLoginId),
        _buildDetail("Password", detailsProvider.loginPassword),
        _buildDetail("Mobile Number", detailsProvider.userMobileNumber),
        _buildDetail("Date of Birth", detailsProvider.userDateOfBirth),
        _buildDetail("Gender", detailsProvider.userGender),
        _buildDetail("Address", detailsProvider.userAddress),
      ],
    );
  }

  Widget _buildEditableForm(Userprofilemodel detailsProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField("Name", _nameController),
        _buildTextField("Email", _emailController),
        _buildTextField("Employee ID", _employeeIdController),
        _buildTextField("Login ID", _loginIdController),
        _buildTextField("Mobile Number", _mobileNumberController),
        _buildTextField("Date of Birth", _dobController),
        _buildTextField("Gender", _genderController),
        _buildTextField("Address", _addressController),
      ],
    );
  }
}
