///THIS WORKS
///Purpose: this code's purpose is to create a page that will show all past notifications from the Rasp Pi Camera
///The notifications will be shown in chronological order, with the conditon that the most recent notification will be on top.
///This page will be called in the dashboard as a shortcut for the user
///The page will also be called in the sidebar
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

//main function to run the app
void main() {
  runApp(MyApp());
}

//main app widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification',
      home: UdpSocketHomePage(),
    );
  }
}

//home page widget
class UdpSocketHomePage extends StatefulWidget {
  @override
  _UdpSocketHomePageState createState() => _UdpSocketHomePageState();
}

//state for the home page widget
class _UdpSocketHomePageState extends State<UdpSocketHomePage> {
  //variables that hold data and state of the alert banner
  String _data = '';
  List<String> _filteredData = [];
  Timer? _timer;
  bool _showAlert = false;

//function to start the UDP socket
  Future<void> startSocket() async {
    final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 5005);
    socket.listen((event) {
      _onReceive(event, socket);
    });
  }

// function that handles the recevied informatin from the socket
  void _onReceive(RawSocketEvent event, RawDatagramSocket socket) {
    if (event == RawSocketEvent.read) {
      final datagram = socket.receive();
      if (datagram != null) {
        final data = utf8.decode(datagram.data);
        //update the data, filter it, and then update the filtered data and show the alert banner
        setState(() {
          _data = data;
          _filterDataAndUpdateState(data);
          _showAlert = true;
        });
      }
    }
    socket.receive(); // add this line to receive the next packet
  }

//function to filter the data received by the socket
  List<String> _filterData(String data) {
    final now = DateTime.now();
    final filtered = _filteredData.where((data) {
      final parsedData = DateTime.parse(data.split(":")[0]);
      final difference = now.difference(parsedData);
      return difference.inSeconds >= 15;
    }).toList();
    filtered.add("$now: $_data");
    filtered.sort((a, b) {
      final parsedA = DateTime.parse(a.split(":")[0]);
      final parsedB = DateTime.parse(b.split(":")[0]);
      return parsedB.compareTo(parsedA);
    });
    return filtered.reversed.toList();
  }
//function to filter and update the data state

  void _filterDataAndUpdateState(String data) {
    final now = DateTime.now();
    final filtered = _filteredData.where((data) {
      final parsedData = DateTime.parse(data.split(":")[0]);
      final difference = now.difference(parsedData);
      return difference.inSeconds >= 15;
    }).toList();
    filtered.add("$now: $_data");
    setState(() {
      _filteredData = filtered;
    });
  }

//initializing the socket app startup
  @override
  void initState() {
    super.initState();
    startSocket();
  }

//canceling the timer on app exit
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

//commenting this part out to test out showing the notification as an banner
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Column(
        children: [
          if (_showAlert)
            Container(
              color: Colors.yellow,
              height: 50,
              child: Center(child: Text('Alert!')),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredData.length,
              itemBuilder: (context, index) {
                final data = _filteredData[index];
                return ListTile(
                  title: Text(data),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
