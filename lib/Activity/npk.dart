import 'package:flutter/material.dart';
import 'package:weather_forcast_app/data_template.dart';

class npk extends StatefulWidget {
  // const npk({Key? key}) : super(key: key);

  List<data_template> weatherdata;

  npk({required this.weatherdata});

  @override
  State<npk> createState() => _npkState();
}

class _npkState extends State<npk> {
  final _npkKEY = GlobalKey<FormState>();

  double n = 0; //30-40
  double p = 0; //25-50
  double k = 0; //40-80

  double havg = 0.0;
  double tavg = 0.0;

  @override
  void initState() {
    super.initState();
    // avg();
  }

  avg() {
    for (int i = 0; i < widget.weatherdata.length; i++) {
      havg = havg + double.parse(widget.weatherdata[i].humidity.toString());
      tavg = tavg + double.parse(widget.weatherdata[i].temp.toString());
    }
    havg = havg / widget.weatherdata.length;
    tavg = tavg / widget.weatherdata.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("N P K in soil"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _npkKEY,
          child: Padding(
            padding: const EdgeInsets.only(top: 50, right: 25, left: 25),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Nitrogen value in soil",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      n = double.parse(value.toString());
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Phosphorous value in soil",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      p = double.parse(value.toString());
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Potassium value in soil",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      k = double.parse(value.toString()); // as double;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: MaterialButton(
                    height: 60,
                    minWidth: 200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.blue, //[900],
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_npkKEY.currentState!.validate()) {
                        _npkKEY.currentState!.save();
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
                Text(n.toString()),
                Text(p.toString()),
                Text(k.toString()),
                Text((n + p + k).toString()),
                Text(havg.toString()),
                Text(tavg.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
