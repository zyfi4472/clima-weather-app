import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  late double Longitude, Latitude;

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    try {
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        print('Permisions denied');
        // Asking for location permission
        LocationPermission askForPermission =
            await Geolocator.requestPermission();
      } else {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);

        Longitude = position.longitude;
        Latitude = position.latitude;
        // print(position);
      }
    } catch (e) {
      print(e);
    }
  }
}
