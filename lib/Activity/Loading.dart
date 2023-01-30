import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_forcast_app/Activity/HomeForcast.dart';
import 'package:weather_forcast_app/Activity/Location.dart';
import 'package:weather_forcast_app/data_template.dart';
import 'package:weather_forcast_app/worker/forcastWorker.dart';
import 'package:weather_forcast_app/worker/worker.dart';

import 'Home.dart';
// import 'package:weather_app/Activity/Home.dart';
// import 'package:weather_app/worker/worker.dart';

class Loading extends StatefulWidget {
  // const Loading({Key? key}) : super(key: key);
  String? searchText;

  Loading({this.searchText});

  // Loading({});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  // String Temperature = "Loading";

  String? temp;
  String? hum;
  String? air_speed;
  String? des;
  String? main;
  String? icon;
  String? city;

  Location cityLocation = Location();

  void startApp(String city_) async {
    forcastWorker instance = forcastWorker(location: city_);
    var weatherData = [];
    weatherData = await instance.getData();

    // temp = instance.temp.toString();
    // hum = instance.humidity.toString();
    // air_speed = instance.air_speed.toString();
    // des = instance.description.toString();
    // main = instance.main.toString();
    // icon = instance.icon.toString();

    // Future.delayed(Duration(seconds: 2), () {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    //     return Home(
    //       temp: temp,
    //       humidity: hum,
    //       air_speed: air_speed,
    //       description: des,
    //       main: main,
    //       getcity: city_,
    //       icon: icon,
    //     );
    //   }));
    // });

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomeForcast(
        weatherData: weatherData,
        // temp: temp,
        // humidity: hum,
        // air_speed: air_speed,
        // description: des,
        // main: main,
        // getcity: city_,
        // icon: icon,
      );
    }));

    // Navigator.pushReplacementNamed(context, "/home", arguments: {
    //   "temp_value": temp,
    //   "hum_value": hum,
    //   "air_speed_value": air_speed,
    //   "des_value": des,
    //   "main_value": main,
    // });

    print(instance.air_speed);
    print(instance.description);

    // setState(() {
    //   Temperature = instance.temp.toString();
    // });
  }

  getLocation() async {
    city = await cityLocation.getCurrentPosition();
    print(
        "city form location :- "); //await cityLocation.getCurrentPosition(); //"jaipur";
    print(city);
    startApp(city.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("Loading");
    // print(instance.air_speed);
    if (widget.searchText != null) {
      setState(() {
        city = widget.searchText.toString();
        startApp(city.toString());
      });
    } else {
      setState(() {
        // city = "Jaipur"; // getLocation().toString();
        // getLocation();
        // print(
        //     "city form location :- "); //await cityLocation.getCurrentPosition(); //"jaipur";
        // print(city);
        startApp("jaipur");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[400],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/weatherlogo2.png",
                height: 180,
                width: 180,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Weather Forecasting",
                style: TextStyle(
                  fontSize: 37,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "App",
                style: TextStyle(
                  fontSize: 37,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SpinKitWave(
                color: Colors.white,
                size: 50.0,
              ),
            ],
          ),
        ));
  }
}
