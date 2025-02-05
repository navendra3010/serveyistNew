import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationProviderr extends ChangeNotifier {
  Position? _currentPosition;
  String? _address;
  bool _isLoading = false;

  Position? get currentPosition => _currentPosition;
  String? get address => _address;
  bool get isLoading => _isLoading;

  Future<void> determinePosition() async {
    _isLoading = true;
    notifyListeners();

    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _isLoading = false;
        notifyListeners();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _isLoading = false;
      notifyListeners();
      return;
    }
    _currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    Future<String> _getAddressFromLatLng(double lat, double lng) async {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
        Placemark place = placemarks[0];

        return "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      } catch (e) {
        return "Unknown Location";
      }
    }

    _address = await _getAddressFromLatLng(
        _currentPosition!.latitude, _currentPosition!.longitude);

    // Get current location

    // Save to Firestore
    //await _saveLocationToFirestore(_currentPosition!);
    _isLoading = false;
    notifyListeners();
  }

  // Future<void> _saveLocationToFirestore(Position position) async {
  //   FirebaseFirestore.instance.collection('locations').add({
  //     'latitude': position.latitude,
  //     'longitude': position.longitude,
  //     'timestamp': Timestamp.now(),
  //   });
  // }
}
