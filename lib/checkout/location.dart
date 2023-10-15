// ignore_for_file: unused_element

import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as d;

class Location {
  static Future<String> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'Location services are disabled. Please enable the services';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Location permissions are denied';
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return 'Location permissions are permanently denied, we cannot request permissions.';
    }
    return "success";
  }

  static Future<List<String>> getCurrentPosition() async {
    String permission = await _handleLocationPermission();
    if (permission != "success") {
      return [permission];
    }

    try {
      var response = await http.get(Uri.parse('http://ip-api.com/json'));

      final double latitude = jsonDecode(response.body)['lat'];
      final double longitude = jsonDecode(response.body)['lon'];
      d.log('$latitude, $longitude');

      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      d.log(placemarks.toString());

      List<String> locationInfoList = [];

      for (Placemark place in placemarks) {
        locationInfoList.add(
          "${place.street} ${place.subLocality} ${place.locality}, ${place.country}",
        );
      }

      return locationInfoList;
    } catch (err) {
      return [err.toString()];
    }
  }
}
