import 'package:flutter/material.dart';
import 'package:weather_forcast_app/Activity/HomeForcast.dart';
import 'package:weather_forcast_app/Activity/Location.dart';
// import 'package:weather_app/Activity/Loading.dart';

import 'Activity/Home.dart';
import 'Activity/Loading.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Loading(
      searchText: null,
    ),
    // Loading(
    //   searchText: null,
    // ),
    routes: {
      // "/": (context) => Loading(), //default route.
      "/home": (context) => HomeForcast(weatherData: []),
    },
  ));
}
