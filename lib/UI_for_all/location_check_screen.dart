import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:surveyist/UI_for_all/login_ui.dart';


class LocationCheckScreen extends StatefulWidget {
  @override
  _LocationCheckScreenState createState() => _LocationCheckScreenState();
}

class _LocationCheckScreenState extends State<LocationCheckScreen> {
  bool _checking = true;

  @override
  void initState() {
    super.initState();
    _checkLocationAndNavigate();
  }

  Future<void> _checkLocationAndNavigate() async {
    Position? position = await _determinePosition(context);

    if (position != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreenForAll()),
      );
    } else {
      setState(() {
        _checking = false;
      });
    }
  }

  Future<Position?> _determinePosition(BuildContext context) async {
    bool permissionGranted = false;

    while (!permissionGranted) {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showLocationDialog(context, true);
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showLocationDialog(context, false);
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showLocationDialog(context, false);
        return null;
      }

      permissionGranted = true;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  void _showLocationDialog(BuildContext context, bool isServiceDialog) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Text(isServiceDialog
            ? 'Location Services Required'
            : 'Location Permission Required'),
        content: Text(isServiceDialog
            ? 'Please enable location services to continue.'
            : 'Please grant location permission to use this app.'),
        actions: [
          TextButton(
            onPressed: () async {
              await Geolocator.openAppSettings();
              Navigator.pop(context);
            },
            child: const Text('Open Settings'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _checking
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_off, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Location access is required to continue.'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _checkLocationAndNavigate,
                    child: Text('Retry'),
                  ),
                ],
              ),
      ),
    );
  }
}
