import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:http/http.dart';
import 'package:weather_forcast_app/Activity/npk.dart';
import 'package:weather_forcast_app/crop_condtions.dart';
import 'package:weather_forcast_app/data_template.dart';
import 'package:weather_forcast_app/design.dart';

import 'Loading.dart';
// import 'package:weather_app/Activity/Loading.dart';

class HomeForcast extends StatefulWidget {
  // const HomeForcast({Key? key}) : super(key: key);
  // String? temp;
  // String? humidity;
  // String? air_speed;
  // String? description;
  // String? main;
  // String? icon;
  // String? getcity;

  var weatherData;

  HomeForcast(
      {
      // this.temp,
      // this.humidity,
      // this.air_speed,
      // this.description,
      // this.main,
      // this.icon,
      // this.getcity,
      required this.weatherData});

  @override
  State<HomeForcast> createState() => _HomeForcastState();
}

class _HomeForcastState extends State<HomeForcast> {
  // void timer() {
  //   print("Alarm is ringing");
  // }

  crop rice = crop(
      name: "Rice",
      temperature1: 27,
      temperature2: 32,
      humidity1: 60,
      humidity2: 80,
      suitabilityCount: 0);

  crop grams = crop(
      name: "Grams",
      temperature1: 20,
      temperature2: 25,
      humidity1: 30,
      humidity2: 35,
      suitabilityCount: 0);

  crop carrot = crop(
      name: "Carrot",
      temperature1: 16,
      temperature2: 20,
      humidity1: 90,
      humidity2: 95,
      suitabilityCount: 0);

  crop cotton = crop(
      name: "Cotton",
      temperature1: 23.5,
      temperature2: 35,
      humidity1: 43,
      humidity2: 76,
      suitabilityCount: 0);

  crop wheat = crop(
      name: "Wheat",
      temperature1: 10,
      temperature2: 15,
      humidity1: 50,
      humidity2: 60,
      suitabilityCount: 0);

  bool check = true;

  crop? mostSuitableCrop;

  void cityChecker() {
    // if (widget.description.toString() == "Can't find data") {
    //   setState(() {
    //     check = false;
    //   });
    // }
    if (
        //widget.weatherData[0].description == "Can't find data" ||
        widget.weatherData.isEmpty) {
      setState(() {
        check = true;
      });
    }
  }

  List<crop> cropList = [];
  bool display = false;

  void analyzeCropConditions(crop crop) {
    for (int i = 0; i < widget.weatherData.length; i++) {
      if (double.parse(widget.weatherData[i].temp.toString()) >
              crop.temperature1 &&
          double.parse(widget.weatherData[i].temp.toString()) <
              crop.temperature2) {
        crop.tempSuitable = true;
        setState(() {
          crop.suitabilityCount = crop.suitabilityCount + 1;
        });
      }
      if (double.parse(widget.weatherData[i].humidity.toString()) >
              crop.temperature1 &&
          double.parse(widget.weatherData[i].humidity.toString()) <
              crop.temperature2) {
        crop.humiditySuitable = true;
        setState(() {
          crop.suitabilityCount = crop.suitabilityCount + 1;
        });
      }
    }
  }

  crop mostSuitable(List<crop> crops) {
    crop max = crops[0];
    for (int i = 0; i < 5; i++) {
      if (max.suitabilityCount < crops[i].suitabilityCount) {
        max = crops[i];
      }
    }
    setState(() {
      display = true;
    });
    return max;
  }

  @override
  void initState() {
    super.initState();

    cityChecker();

    print("You  can do other stuff too");
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Widget Destroyed");
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = new TextEditingController();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.blue,
        ),
      ),
      body: SafeArea(
        child: check //|| widget.weatherData.isNotEmpty
            ? SingleChildScrollView(
                child: Container(
                  // height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          // Colors.blue[900],
                          // Colors.blue[200]
                          Colors.blue,
                          Colors.blueAccent
                          // Colors.pinkAccent,
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [
                          0.1, // 10% of the screen is occupied by the blue color.
                          0.5, // if both are equal then there will be no transition in the colors.
                        ]),
                  ),
                  child:
                      // Column(
                      //   children: [
                      Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.all(19),
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // print(searchController.text);
                                searchController.text.isNotEmpty
                                    ? Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                        return Loading(
                                            searchText: searchController.text);
                                      }))
                                    : null;
                              },
                              child: Container(
                                child: Icon(Icons.search),
                                margin: EdgeInsets.fromLTRB(2, 0, 5, 0),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                onEditingComplete: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Loading(
                                        searchText: searchController.text);
                                  }));
                                },
                                decoration: InputDecoration(
                                  hintText: "Search any City....",
                                  border: InputBorder.none,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // Text(widget.weatherData[0].date.toString()),
                      widget.weatherData.length < 4
                          ? Container()
                          : widget.weatherData[0].main != "Can't find data"
                              ? design(weatherData: widget.weatherData[0])
                              : Container(),
                      widget.weatherData[1].main != "Can't find data"
                          ? design(weatherData: widget.weatherData[1])
                          : Container(),
                      widget.weatherData[2].main != "Can't find data"
                          ? design(weatherData: widget.weatherData[2])
                          : Container(),
                      widget.weatherData[3].main != "Can't find data"
                          ? design(weatherData: widget.weatherData[3])
                          : Container(),
                      widget.weatherData[4].main != "Can't find data"
                          ? design(weatherData: widget.weatherData[4])
                          : Container(),
                      // widget.weatherData[5].main != "Can't find data"
                      //     ? design(weatherData: widget.weatherData[5])
                      //     : Container(),

                      ElevatedButton(
                          onPressed: () {
                            print(widget.weatherData);
                            analyzeCropConditions(rice);
                            analyzeCropConditions(grams);
                            analyzeCropConditions(wheat);
                            analyzeCropConditions(cotton);
                            analyzeCropConditions(carrot);

                            cropList.add(rice);
                            cropList.add(grams);
                            cropList.add(wheat);
                            cropList.add(cotton);
                            cropList.add(carrot);

                            mostSuitableCrop = mostSuitable(cropList);
                          },
                          child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              color: Colors.blue[900],
                              child: Text(
                                  "Analyze suitable crops according to Weather Forcasting",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)))),

                      // rice.suitabilityCount != 0 && grams.suitabilityCount != 0
                      //     ? ((rice.suitabilityCount > grams.suitabilityCount)
                      //         ? Container(
                      //             margin: EdgeInsets.all(10),
                      //             padding: EdgeInsets.all(10),
                      //             color: Colors.blue[900],
                      //             child: Text("Rice is more suitable",
                      //                 style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontSize: 20,
                      //                     fontWeight: FontWeight.bold)))
                      //         : (rice.suitabilityCount ==
                      //                 grams.suitabilityCount)
                      //             ? Container(
                      //                 margin: EdgeInsets.all(10),
                      //                 padding: EdgeInsets.all(10),
                      //                 color: Colors.blue[900],
                      //                 child: Text("Both are equally suitable",
                      //                     style: TextStyle(
                      //                         color: Colors.white,
                      //                         fontSize: 20,
                      //                         fontWeight: FontWeight.bold)))
                      //             : Container(
                      //                 margin: EdgeInsets.all(10),
                      //                 padding: EdgeInsets.all(10),
                      //                 color: Colors.blue[900],
                      //                 child: Text("Grams is more suitable",
                      //                     style: TextStyle(
                      //                         color: Colors.white,
                      //                         fontSize: 20,
                      //                         fontWeight: FontWeight.bold))))
                      //     : Container(),

                      display
                          ? Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              color: Colors.blue[900],
                              child: Text(
                                  "${mostSuitableCrop!.name} is more suitable",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)))
                          : Container(),

                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return npk(weatherdata: widget.weatherData);
                            }));
                            // analyzeCropConditions(rice);
                            // analyzeCropConditions(grams);
                            // analyzeCropConditions(wheat);
                            // analyzeCropConditions(cotton);
                            // analyzeCropConditions(carrot);

                            // cropList.add(rice);
                            // cropList.add(grams);
                            // cropList.add(wheat);
                            // cropList.add(cotton);
                            // cropList.add(carrot);

                            // mostSuitableCrop = mostSuitable(cropList);
                          },
                          child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              color: Colors.blue[900],
                              child: Text(
                                  "Analyze amount of N,P,K needed in soil",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)))),
                    ],
                  ),
                ),
              )
            : Center(
                child: Text(
                  "Unable to find the entered City !!",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }
}

/*
  Column(
                      children: [
                        // Text(widget.weatherData[2].date.toString()),
                        Container(
                          margin: EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue[900],
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(widget.weatherData[2].date.toString(),
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
                                          "http://openweathermap.org/img/wn/${widget.weatherData[2].icon}@2x.png"),
                                      SizedBox(width: 20),
                                      Column(
                                        children: [
                                          Text(
                                            "${widget.weatherData[2].description}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "In ${widget.weatherData[2].city}",
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
                                margin: EdgeInsets.symmetric(
                                    horizontal: 26, vertical: 10),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.weatherData[0].temp.toString(),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(WeatherIcons.wiDayWindy),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        widget.weatherData[2].air_speed
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(WeatherIcons.wiHumidity),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "${widget.weatherData[2].humidity}",
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("Percent")
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),*/

/*

   Container(
                      margin: EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[900],
                      ),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(widget.weatherData[0].date.toString(),
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
                                      "http://openweathermap.org/img/wn/${widget.weatherData[0].icon}@2x.png"),
                                  SizedBox(width: 20),
                                  Column(
                                    children: [
                                      Text(
                                        "${widget.weatherData[0].description}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "In ${widget.weatherData[0].city}",
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
                            margin: EdgeInsets.symmetric(
                                horizontal: 26, vertical: 10),
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
                                      widget.weatherData[2].temp.toString(),
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
                                    widget.weatherData[0].air_speed.toString(),
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
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
                                  "${widget.weatherData[0].humidity}",
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("Percent")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  
*/                

