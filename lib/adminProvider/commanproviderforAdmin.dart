import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyist/UI_for_all/loginUI.dart';
import 'package:surveyist/adminModel/allUsersModel.dart';
import 'package:surveyist/adminProvider/fireStoreServiceforAdmin/fireStoreserAdmin.dart';
import 'package:surveyist/userModel/userProfilemodel.dart';
import 'package:surveyist/userModel/userlogin.dart';

class CommanproviderAdmin extends ChangeNotifier {
  ViewAllUsers? viewuser;
  UserLoginModel? userLoginModel;
  FireStoreServiceForAdmin frstr = FireStoreServiceForAdmin();


Future<Userprofilemodel?> getAdminInfo() async {
    SharedPreferences sff = await SharedPreferences.getInstance();
    String? profileID = await sff.getString('userId');
    if (profileID != null) {
      // print("got profile id      ${profileID}");
      return await frstr.getAdminProfile(profileID);
    } else {
      print("not getting profile id");
    }
    return null;
  }




  Stream<List<ViewAllUsers>> get allUsersStream {
    return frstr.getAllUsers();
  }
// all users yet login per day -------------------------------------------------------------------------------------
DateTime now=DateTime.now();
String? dateKey;
notifyListeners();




  Stream<List<QuerySnapshot<Map<String, dynamic>>>> allLoginUser(String s) {
      //dateKey = DateFormat('dd-MM-yyyy').format(now);
    return frstr.getAllLoginUser(s);
  }

  // admin logout------------------------------------------------------------------------------------
  Future<void> adminLogOut(context) async {
    final sf = await SharedPreferences.getInstance();
    sf.remove("role");
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreenForAll()));
  }
  // select image from gallery and camera....................................
  //date 19-2-2025.............................................................

  File? image;
  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickfile = await picker.pickImage(source: ImageSource.gallery);
    if (pickfile != null) {
      image = File(pickfile.path);
      print("imagae path is ----------------------${image!.path}");
      notifyListeners();
    }
  }

  //pick imaage from camera...............................................
  Future getImageFromCamera() async {
    final picImageCamera = await picker.pickImage(source: ImageSource.camera);
    if (picImageCamera != null) {
      image = File(picImageCamera.path);

      notifyListeners();
    }
  }

  // date 19-2-2025 select multiple images from galttery
  List<XFile> imageFileList = [];
  Future selectMultipleImage() async {
    final List<XFile>? selectImage = await picker.pickMultiImage();
    if (selectImage!.isNotEmpty) {
      imageFileList!.addAll(selectImage);
    }
    print(" image length -------------${imageFileList.length}");
    notifyListeners();
  }
      int ? selecNumber;
   void setDateForSelect( int value)
   {
    selecNumber=value;
    notifyListeners();
   }



     //date 12-3-2025..........................................................
  // this function select date for filtering  login record any time.....................................

  String? selectPickedDate;
  DateTime selectDate = DateTime.now();
  TextEditingController selectfilterDateController = TextEditingController();
  
  void selectDateforLoginFiltering(BuildContext context) async {
    DateTime? select = await showDatePicker(
        initialDate: DateTime.now(),
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (select != null) {
      selectfilterDateController.text = formateDate(select);
    }
     notifyListeners();
  }

  String formateDate(DateTime date) {
    //return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
     return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }
}
