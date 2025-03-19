// ignore_for_file: prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveyist/userProviders/location_provider.dart';

class Locationpage extends StatefulWidget {
  Locationpage({super.key});
  @override
  State<Locationpage> createState() => _MyLocationPage();
}

class _MyLocationPage extends State<Locationpage> {
  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProviderr>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Location Access')),
      body: Center(
        child: locationProvider.isLoading
            ? const CircularProgressIndicator()
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
                          const SnackBar(content: Text('Location not available!')),
                        );
                      }
                    },
                    child: const Text('Get Location & Proceed'),
                  ),
                ],
              ),
      ),
    );
  }
}
