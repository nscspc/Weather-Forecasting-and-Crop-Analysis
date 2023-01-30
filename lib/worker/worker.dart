import 'dart:convert';

import 'package:http/http.dart';

class worker {
  String? location;
  worker({this.location}) {
    // curly brackets is for named parameters.
    location = this.location;
  }

  // String location;
  String? temp;
  String? humidity;
  String? air_speed;
  String? description;
  String? main;
  String? icon;

  Future<void> getData() async {
    try {
      Response response = await get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=d1404974d83e877d8396ed640b18991e"));
      // "https://api.openweathermap.org/data/2.5/weather?q=jaipur&appid=b8de3211a0c2de15cd1d1f541f9396cc"));

      print("response :- ");
      print(response.body);

      Map data = jsonDecode(response.body);
      Map temp_data = data['main'];
      double getTemp = temp_data['temp'] - 273.15;

      Map wind = data['wind'];
      String getAir_speed = (wind['speed'] / 0.27777777777778).toString();

      String getHumidity = temp_data['humidity'].toString();

      // print(temp);
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      print(weather_data);
      print(weather_main_data);
      String getMain_des = weather_main_data['main'];
      String getDesc = weather_main_data['description'];

      icon = weather_main_data["icon"];
      print(icon);

      temp = getTemp.toString();
      humidity = getHumidity.toString();
      air_speed = getAir_speed.toString();
      description = getDesc;
      main = getMain_des;
      icon = weather_main_data["icon"].toString();
    } catch (e) {
      temp = "Can't find data";
      humidity = "Can't find data";
      air_speed = "Can't find data";
      description = "Can't find data";
      main = "Can't find data";
      icon = "03n";
    }
  }
}

// worker instance = worker(location: "Mumbai");
// instance.temp;
