import 'dart:convert';
// import 'dart:html';

import 'package:http/http.dart';
import 'package:weather_forcast_app/data_template.dart';

class forcastWorker {
  String? location;
  forcastWorker({this.location}) {
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

  List<dynamic> futureDaysData = [];

  Future<List<dynamic>> getData() async {
    // List<data_template> futureDaysData =
    //     List.generate(5, (index) => data_template());
    // List<data_template> futureDaysData =
    //     new List.filled(5, data_template(), growable: true);
    // var futureDaysData = [];
    // data_template newData = data_template();
    // List<dynamic> futureDaysData = ["", 0];
    try {
      Response response = await get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=jaipur&appid=*appid*"));

      print("response :- ");
      print(response.body);
      // List<data_template> futureDaysData = [];

      Map data = jsonDecode(response.body);
      int todayDate = DateTime.now().day;
      // String weekDate = DateTime.now().add(Duration(days: 7)).toString();
      int date = todayDate;
      Map subData;
      int i = 0;

      print("futureDaysData :- ");
      print(futureDaysData);
      while (date <= todayDate + 5) {
        subData = data['list'][i];
        print(date);
        print("subData :- ");
        print(subData);

        data_template newData = data_template();

        Map sub_temp_data = subData['main'];
        print("sub_temp_data :- ");
        print(sub_temp_data);

        String currentDate = subData['dt_txt'].toString().substring(8, 10);
        newData.date = subData['dt_txt'].toString().substring(0, 10);
        print("currentDate :- ");
        print(newData.date);

        if (currentDate == date.toString()) {
          double getSubTemp = sub_temp_data['temp'] - 273.15;
          if (getSubTemp.toString().length > 4) {
            newData.temp = getSubTemp.toString().substring(0, 4);
          } else {
            newData.temp = getSubTemp.toString();
          }

          newData.city = location;

          print(getSubTemp);

          Map sub_wind = subData['wind'];
          String getSubAir_speed =
              (sub_wind['speed'] / 0.27777777777778).toString();
          if (getSubAir_speed.toString().length > 4) {
            newData.air_speed = getSubAir_speed.toString().substring(0, 4);
          } else {
            newData.air_speed = getSubAir_speed.toString();
          }
          // newData.air_speed = getSubAir_speed.toString();
          print(getSubAir_speed);

          String getSubHumidity = sub_temp_data['humidity'].toString();
          newData.humidity = getSubHumidity.toString();

          List sub_weather_data = subData['weather'];
          Map sub_weather_main_data = sub_weather_data[0];
          String getSubMain_des = sub_weather_main_data['main'];
          String getSubDesc = sub_weather_main_data['description'];

          icon = sub_weather_main_data["icon"];
          print(icon);

          newData.main = getSubMain_des.toString();
          newData.description = getSubDesc.toString();
          newData.icon = icon;
          // futureDaysData.insert(0, newData);
          futureDaysData.add(newData);
          // return futureDaysData;

          // futureDaysData.insert(2, newData);
          // futureDaysData[2] = newData;
          print("futureDaysData");

          print(futureDaysData);
          date++;
        }
        // if (currentDate > date) {
        //   date++;
        // }

        i++;
      }
      print("futureDaysData");
      print(futureDaysData);
      return futureDaysData;

      // Map temp_data = data['main'];
      // double getTemp = temp_data['temp'] - 273.15;

      // Map wind = data['wind'];
      // String getAir_speed = (wind['speed'] / 0.27777777777778).toString();

      // String getHumidity = temp_data['humidity'].toString();

      // // print(temp);
      // List weather_data = data['weather'];
      // Map weather_main_data = weather_data[0];
      // print(weather_data);
      // print(weather_main_data);
      // String getMain_des = weather_main_data['main'];
      // String getDesc = weather_main_data['description'];

      // icon = weather_main_data["icon"];
      // print(icon);

      // Map temp_data = futureDaysData[0].temp; //data['main'];
      // double getTemp = //temp_data['temp'] - 273.15;

      // Map wind = data['wind'];
      // String getAir_speed = (wind['speed'] / 0.27777777777778).toString();

      // String getHumidity = temp_data['humidity'].toString();

      // print(temp);
      // List weather_data = data['weather'];
      // Map weather_main_data = weather_data[0];
      // print(weather_data);
      // print(weather_main_data);
      // String getMain_des = weather_main_data['main'];
      // String getDesc = weather_main_data['description'];

      // icon = weather_main_data["icon"];
      // print(icon);

      temp = futureDaysData[0].temp; //getTemp.toString();
      humidity = futureDaysData[0].humidity.toString();
      air_speed = futureDaysData[0].air_speed.toString();
      description = futureDaysData[0].description;
      main = futureDaysData[0].main;
      icon = futureDaysData[0].icon;
    } catch (e) {
      temp = "Can't find data";
      humidity = "Can't find data";
      air_speed = "Can't find data";
      description = "Can't find data";
      main = "Can't find data";
      icon = "03n";
    }
    print("futureDaysData");
    print(futureDaysData);
    print("newdata");
    // print(newData);
    // print(newData.humidity);
    return futureDaysData;
  }
}

forcastWorker instance = forcastWorker(location: "Mumbai");
// instance.temp;
