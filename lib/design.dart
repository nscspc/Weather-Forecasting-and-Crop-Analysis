import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:weather_forcast_app/data_template.dart';

class design extends StatefulWidget {
  // const design({Key? key}) : super(key: key);

  data_template weatherData;

  design({required this.weatherData});

  @override
  State<design> createState() => _DesignState();
}

class _DesignState extends State<design> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue[900],
          ),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          child: Center(
            child: Text(widget.weatherData.date.toString(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),

        Row(
          children: [
            Expanded(
              //to take all the space present in the parent widget.
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 26),
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withOpacity(0.5)),
                  child: Row(
                    children: [
                      Image.network(
                          "http://openweathermap.org/img/wn/${widget.weatherData.icon}@2x.png"),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          Text(
                            "${widget.weatherData.description}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "In ${widget.weatherData.city}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              //to take all the space present in the parent widget.
              child: Container(
                height: 300,
                margin: EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.5)),
                child: //Text("Text"),
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(WeatherIcons.wiThermometer),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.weatherData.temp.toString(),
                          style: TextStyle(fontSize: 90),
                        ),
                        Text(
                          "C",
                          style: TextStyle(fontSize: 30),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              //to take all the space present in the parent widget.
              child: Container(
                  height: 190,
                  margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withOpacity(0.5)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(WeatherIcons.wiDayWindy),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.weatherData.air_speed.toString(),
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text("km/hr")
                    ],
                  ) //Text("Text"),
                  ),
            ),
            Expanded(
              child: Container(
                height: 190,
                margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.5)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(WeatherIcons.wiHumidity),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${widget.weatherData.humidity}",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    Text("Percent")
                  ],
                ),
              ),
            ),
          ],
        ),
        // Container(
        //   padding: EdgeInsets.all(20),
        //   child: Text("Data Provided By Openweathermap.org"),
        //   // ),
        // )
      ],
    );
  }
}
