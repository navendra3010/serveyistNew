

// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// class Locations {
//   // Handle location permissions
//   static Future<bool> handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Check if location service is enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Prompt user to enable location services
//       print("Location services are disabled.");
//       return false;
//     }

//     // Check current location permission
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       // Request permission if denied
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         print("Location permissions are denied.");
//         return false;
//       }
//     }

//     // Handle permanently denied permissions
//     if (permission == LocationPermission.deniedForever) {
//       print("Location permissions are permanently denied. Please enable them in settings.");
//       return false;
//     }
//     return true;
//   }

//   // Get the current position
//   static Future<Position?> getCurrentPosition() async {
//     try {
//       final hasPermission = await handleLocationPermission();
//       if (!hasPermission) return null;

//       // Fetch the current position
//       return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//     } catch (e) {
//       print("Failed to get current position: $e");
//       return null;
//     }
//   }

//   // Get address from latitude and longitude
//   static Future<String?> getAddressFromLatLng(Position position) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );

//       Placemark place = placemarks[0];
//       return "${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}";
//     } catch (e) {
//       print("Failed to get address from coordinates: $e");
//       return null;
//     }
//   }
// }
