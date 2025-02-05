import 'package:cloud_firestore/cloud_firestore.dart';

class Deviceinformation {
  String? deviceId;
  String? deviceBrand;
  String? device;
  String? model;
  String? board;

  Deviceinformation(
      {this.deviceBrand, this.model, this.board, this.device, this.deviceId});

  Map<String, dynamic> toFireStore() {
    return {
      "device": device ,
      "device_Id": deviceId ,
      "device_brand": deviceBrand ,
      "board": board ,
      "model": model,
    };
  }

   factory Deviceinformation.fromFireStore(Map<String,dynamic> data)
   {

    // Map<String,dynamic>data=doc.data() as Map<String, dynamic>;
     return Deviceinformation(

      device:data['device'],
      deviceBrand: data['device_brand'],
      deviceId: data['device_Id'],
      model: data['model'],
      board: data['board'],

     );
   }
  //   String toString() {
  //   return "Board: $board, device_Id: $deviceId, Device: $device, Model: $model, Brand: $deviceBrand";
  // }
}
