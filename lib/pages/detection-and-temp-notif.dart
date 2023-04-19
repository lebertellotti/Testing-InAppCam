/*
/*
while True: 
    if message == "person detected":
        temperature = location_page_temp_check
        if temperature is not None: #temp >75
            message = f"Person detected and the car's temperature is {temperature}"
            data = json.dumps

        elif message == "no person detected":
            pass 

*/
/*
import 'package:flutter/material.dart';
import 'location_page.dart';
import '../udp-socket.dart';

// create an instance of the LocationPage class
final LocationPage locationPage = LocationPage();

class Combined extends StatefulWidget {
  @override
  CombinedState createState() => CombinedState();
}

class CombinedState extends State<Combined> {
  // defining the flag to be 0 or flase
  bool isPersonDetected = false;
// need to define temperature bc it varies
  //double? temperature;

  // defining the fucntion that will be called when the message is received from UDP
  void gotMessage(String message) async {
    setState(() {
      // need to update the variable 'isPersonDetected' to be changing depending on the message received
      isPersonDetected = message == 'person detected';
    });
    if (isPersonDetected) {
      // double temperature = await locationPage._getTemperature(); //add the get temp function
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // add the whole scafold portion
        );
  }
}
*/
/*
while True: 
    if message == "person detected":
        temperature = location_page_temp_check
        if temperature is not None: #temp >75
            message = f"Person detected and the car's temperature is {temperature}"
            data = json.dumps

        elif message == "no person detected":
            pass 

*/

import 'package:flutter/material.dart';
import '../pages/location_page.dart';
import '../udp-socket.dart';
import 'dart:math';

// create an instance of the LocationPage class
//final LocationPage locationPage = LocationPage(); //

class Combined extends StatefulWidget {
  @override
  CombinedState createState() => CombinedState();
}

class CombinedState extends State<Combined> {
  // defining the flag to be 0 or flase
  bool isPersonDetected = false;
// need to define temperature bc it varies
  double? temperature;

// create an instance of the LocationPage class
  final locationPage = LocationPageState();

  // defining the fucntion that will be called when the message is received from UDP
  void gotMessage(String message) async {
    setState(() {
      // need to update the variable 'isPersonDetected' to be changing depending on the message received
      isPersonDetected = message == 'person detected';
    });
    if (isPersonDetected) {
      temperature = await locationPage.getTemperature();
      setState(() {
        temperature = temperature;
      });
      //double temperature = await LocationPage._getTemperature(); //add the get temp function
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: const Text("Location Page")),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'Temperature: ${temperature != null ? "${temperature?.toStringAsFixed(1)}F" : ""}'),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
*/

/*
while True: 
    if message == "person detected":
        temperature = location_page_temp_check
        if temperature is not None: #temp >75
            message = f"Person detected and the car's temperature is {temperature}"
            data = json.dumps

        elif message == "no person detected":
            pass 

*/

import 'package:flutter/material.dart';
import '../pages/location_page.dart';
import '../udp-socket.dart';
import 'dart:math';

// create an instance of the LocationPage class
//final LocationPage locationPage = LocationPage(); //

class Combined extends StatefulWidget {
  @override
  CombinedState createState() => CombinedState();
}

class CombinedState extends State<Combined> {
  double? temperature;
  List<String> filteredData = [];
  final locationPage = LocationPageState();
  final upSoc = UdpSocketHomePageState();

  void gotMessage(String message) async {
    setState(() {
      // need to update the variable 'isPersonDetected' to be changing depending on the message received
      //upSoc.filterData() = message; //error: Undefined name '_filteredData'. Try correcting the name to one that is defined, or defining the name.
      filteredData = message.split(",");
      //isPersonDetected = message == 'person detected';
    });
    //String filteredString = filteredData.join();
    if (upSoc.filterData(filteredData.join(',')) != null) {
      // error: Undefined name 'data'. Try correcting the name to one that is defined, or defining the name.
      //temperature = await locationPage.getTemperature();
      locationPage.getCurrentPosition();
      /*locationPage.getTemperature().then((temperature) {
        setState(() => temperature = temperature);
      });*/
      //double temperature = await LocationPage._getTemperature(); //add the get temp function
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Temperature: ${temperature.toString()}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Filtered Data: ${upSoc.filterData(filteredData.join(','))}',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
