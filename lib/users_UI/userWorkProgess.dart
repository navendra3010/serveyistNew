import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'package:surveyist/localization/location.dart';
import 'package:surveyist/userProviders/eligible.dart';
import 'package:surveyist/userProviders/locationProvider.dart';
import 'package:surveyist/users_UI/getuserLocation.dart';
import 'package:surveyist/utils/TextSyle.dart';
import 'package:surveyist/utils/appConstant.dart';
import 'package:surveyist/utils/appLoader.dart';
import 'package:surveyist/utils/footerForUsers.dart';

class WorkProgess extends StatefulWidget {
  WorkProgess({super.key});

  @override
  State<WorkProgess> createState() => _WorkProgessState();
}

class _WorkProgessState extends State<WorkProgess> {
  TextEditingController agecontroller = TextEditingController();

  Position? _currentPosition;
  String? _currentAddress;

  void showLoader() {
    Loader();
  }

  @override
  Widget build(BuildContext context) {
       final lc = Provider.of<LocationProviderr>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ChangeNotifierProvider<AgeCheckStatusProvider>(
          create: (context) => AgeCheckStatusProvider(),
          child: Consumer<AgeCheckStatusProvider>(
              builder: (context, provider, child) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text('LAT: ${_currentPosition?.latitude ?? ""}'),
                Text('LNG: ${_currentPosition?.longitude ?? ""}'),
                Text('ADDRESS: ${_currentAddress ?? ""}'),

                Text("${provider.message}",
                    style: TextStyle(
                        color: (provider.isEligible == true)
                            ? Colors.green
                            : Colors.red)),
                TextField(
                  controller: agecontroller,
                  decoration: const InputDecoration(
                      hintText: "Enter age......",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                TextButton(
                    onPressed: () {
                      int num = int.parse(agecontroller.text.toString());
                      provider.check(num);
                    },
                    child: Text(
                      "check",
                      style: CustomText.nameOfTextStyle,
                    )),
                // CircularProgressIndicator(),
                TextButton(
                  onPressed: () {
                    // DeviceInfo().LoginDeviceInfo();
                  },
                  child: Text("Device info"),
                ),
                //  TextButton(onPressed: ()async{
                //   if(_currentPosition!=null)
                //   {
                //   _currentPosition = await Locations.getCurrentPosition();
                //  _currentAddress = await Locations.getAddressFromLatLng(_currentAddress);
                // setState(() {});

                //   }

                //  }, child:Text("Location"),),
                TextButton(
                  onPressed: () async {
                    // _currentPosition = await Locations.getCurrentPosition();
                    // if (_currentPosition != null) {
                    //   _currentAddress = await Locations.getAddressFromLatLng(
                    //       _currentPosition!);
                    //   setState(() {});
                    // } else {
                    //   print("Failed to get location.");
                    // }
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Locationpage()));
                  



                  },
                  child: Text("Get Location"),
                ),
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar:  footerUiForUsers(
          notificationCount: 0, selectMenu2: ButtomMenu2.progess),
    );
  }
}
