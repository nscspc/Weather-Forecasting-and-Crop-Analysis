import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class Location {
// extends StatefulWidget {
//   const Location({Key? key}) : super(key: key);

//   @override
//   State<Location> createState() => _LocationState();
// }

// class _LocationState extends State<Location> {
  Position? position;

  permis() async {
    LocationPermission permission = await Geolocator.requestPermission();
  }

  Future<String> getCurrentPosition() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("position :- ");
    print(position);
    var address = await Geocoder.local
        .findAddressesFromCoordinates(//position!.latitude,position.longitude);
            Coordinates(
                // 48.8566, 2.3522));
                position!.latitude,
                position!.longitude));
    String yourCityName = address.first.locality;
    print(yourCityName);
    // return position;
    return yourCityName;
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   permis();
  //   getCurrentPosition();
  // }

  // @override
  // Widget build(BuildContext context) {
  // return Scaffold();
  // }
}
