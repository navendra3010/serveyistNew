import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/userProviders/locationProvider.dart';

class Locationpage extends StatefulWidget {
  @override
  State<Locationpage> createState() => _myLocationPage();
}

class _myLocationPage extends State<Locationpage> {
  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProviderr>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Location Access')),
      body: Center(
        child: locationProvider.isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    locationProvider.currentPosition != null
                        ? 'Location: ${locationProvider.currentPosition!.latitude}, ${locationProvider.currentPosition!.longitude},${locationProvider.address}'
                        : 'Tap to Get Location',
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await locationProvider.determinePosition();
                      if (locationProvider.currentPosition != null) {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => NextScreen()),
                        // );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Location not available!')),
                        );
                      }
                    },
                    child: Text('Get Location & Proceed'),
                  ),
                ],
              ),
      ),
    );
  }
}
