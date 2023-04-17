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
