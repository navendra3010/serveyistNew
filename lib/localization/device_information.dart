// import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/services.dart';

// class DeviceInfo {
//    static Future <String, dynamic> loginDeviceInfo() async {
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     // Map<String, dynamic> deviceData = {
//     //   'model': androidInfo.model,
//     //   'device': androidInfo.device,
//     //   'id': androidInfo.id,
//     //   'brand': androidInfo.brand,
//     //   'board': androidInfo.board,
//     // };

//     //return deviceData;
//   }
// }
// //  print('Running on ${androidInfo.model}');
// //     print('Running on ${androidInfo.device}');
// //     print('Running on ${androidInfo.id}');
// //     print('Running on ${androidInfo.isLowRamDevice}');
// //     print('Running on ${androidInfo.brand}');
// //     print('Running on ${androidInfo.board}');

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  String? id;
  String? device;
  String? model;
  String? brand;
  String? board;

  DeviceInfo({this.id, this.device, this.model, this.brand, this.board});

  static Future<DeviceInfo> loginDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return DeviceInfo(
        id: androidInfo.id,
        device: androidInfo.device,
        model: androidInfo.model,
        brand: androidInfo.brand,
        board: androidInfo.board,
      );
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;

      return DeviceInfo(
        id: iosDeviceInfo.identifierForVendor ?? "unknow",
        device: iosDeviceInfo.name,
        model: iosDeviceInfo.model,
        brand: iosDeviceInfo.modelName,
        board: iosDeviceInfo.systemName,
      );
    } else {
      throw Exception("the device suppport only andriod");
    }
  }
}
