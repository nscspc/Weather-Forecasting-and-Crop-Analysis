import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:http/http.dart';

import 'Loading.dart';
// import 'package:weather_app/Activity/Loading.dart';

class Home extends StatefulWidget {
  // const Home({Key? key}) : super(key: key);
  String? temp;
  String? humidity;
  String? air_speed;
  String? description;
  String? main;
  String? icon;
  String? getcity;

  Home({
    this.temp,
    this.humidity,
    this.air_speed,
    this.description,
    this.main,
    this.icon,
    this.getcity,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // void timer() {
  //   print("Alarm is ringing");
  // }

  bool check = true;

  void cityChecker() {
    if (widget.description.toString() == "Can't find data") {
      setState(() {
        check = false;
      });
    }
  }

  // void getData() async {
  //   Response response = await get(Uri.parse(
  //       "https://api.openweathermap.org/data/2.5/weather?q=jaipur&appid=b8de3211a0c2de15cd1d1f541f9396cc"));
  //   // "https://api.openweathermap.org/data/2.5/weather?q=jaipur&appid=b8de3211a0c2de15cd1d1f541f9396cc");
  //   Map data = jsonDecode(response.body);
  //   // Map temp_data = data['main'];
  //   // double temp = temp_data['temp'];
  //   // print(temp);
  //   List weather_data = data['weather'];
  //   Map weather_main_data = weather_data[0];
  //   print(weather_data);
  //   print(weather_main_data);
  // }

  // int counter = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    cityChecker();
    // timer();
    // Future.delayed(Duration(seconds: 4), () {
    //   print("This is initState()");
    // });
    print("You  can do other stuff too");
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
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

    // var city_names = [
    //   "Mumbai",
    //   "Delhi",
    //   "Chennai",
    //   "Dhar",
    //   "Indore",
    //   "London",
    //   "Paris"
    // ];

    // final rndm = new Random();

    // var city = city_names[rndm.nextInt(city_names.length)];
    // String temp = widget.temp.toString();
    // String air = widget.air_speed.toString();
    String temp;
    String air;
    if (widget.temp.toString().length > 4)
      temp = ((widget.temp).toString()).substring(0, 4);
    else
      temp = ((widget.temp).toString());
    if (widget.air_speed.toString().length > 4)
      air = ((widget.air_speed).toString()).substring(0, 4);
    else
      air = ((widget.air_speed).toString());
    // Map info = (ModalRoute.of(context)!.settings.arguments).toMap();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.blue,
        ),
      ),
      body: SafeArea(
        child: check
            ? SingleChildScrollView(
                child: Container(
                height: MediaQuery.of(context).size.height,
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
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.all(8),
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // print(searchController.text);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Loading(
                                    searchText: searchController.text);
                              }));
                            },
                            child: Container(
                              child: Icon(Icons.search),
                              margin: EdgeInsets.fromLTRB(2, 0, 5, 0),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              // keyboardType: keybo,
                              // onChanged: (value) {
                              //   Navigator.push(context,
                              //       MaterialPageRoute(builder: (context) {
                              //     return Loading(searchText: searchController.text);
                              //   }));
                              // },
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
                                      "http://openweathermap.org/img/wn/${widget.icon}@2x.png"),
                                  SizedBox(width: 20),
                                  Column(
                                    children: [
                                      Text(
                                        "${widget.description}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "In ${widget.getcity}",
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
                                      "$temp",
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
                                    air,
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
                                  "${widget.humidity}",
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
                    // Container(
                    //   padding: EdgeInsets.all(20),
                    //   child: Text("Data Provided By Openweathermap.org"),
                    //   // ),
                    // )
                  ],
                ),
              ))
            : Center(
                child: Text(
                  "Unable to find the entered City !!",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),

        // appBar: AppBar(
        //   title: Text("Home Activity"),
        // ),
        // body: Column(
        //   children: [
        //     FloatingActionButton(
        //         onPressed: (() => setState(() {
        //               counter++;
        //             }))),
        //     Text(widget.temp.toString()),
        //   ],
        // ),
      ),
    );
  }
}
