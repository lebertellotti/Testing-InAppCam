import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'In App Camera Notification',
      home: UdpSocketHomePage(),
    );
  }
}

class UdpSocketHomePage extends StatefulWidget {
  @override
  _UdpSocketHomePageState createState() => _UdpSocketHomePageState();
}

class _UdpSocketHomePageState extends State<UdpSocketHomePage> {
  String _data = '';
  List<String> _filteredData = [];
  Timer? _timer;

  /////// adding a line so that detection-and-temp-notif.dart works need to be tested
  bool isPersonDetected = false;
  /////// this is the line added

  Future<void> startSocket() async {
    final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 5005);
    socket.listen((event) {
      final datagram = socket.receive();
      if (datagram != null) {
        final data = utf8.decode(datagram.data);
        setState(() {
          _data = data;
        });

        if (_timer == null || !_timer!.isActive) {
          _timer = Timer.periodic(Duration(seconds: 15), (timer) {
            setState(() {
              _filteredData = _filterData(_data);
              /////// adding this portion for detection-and-temp-notif.dart
              if (_data == 'person detected') {
                isPersonDetected = true;
              } else {
                isPersonDetected = false;
              }
              //// this is the portion where it stops
            });
          });
        }
      }
    });
  }

  List<String> _filterData(String data) {
    final now = DateTime.now();
    final filtered = _filteredData.where((data) {
      final parsedData = DateTime.parse(data.split(":")[0]);
      final difference = now.difference(parsedData);
      return difference.inSeconds >=
          15; //giving it 15 seconds in between each notificqation -> 30 seconds was too long
    }).toList();
    filtered.add("$now: $_data");
    filtered.sort((a, b) {
      final parsedA = DateTime.parse(a.split(":")[0]);
      final parsedB = DateTime.parse(b.split(":")[0]);
      return parsedB.compareTo(parsedA);
    });
    return filtered.reversed.toList();
  }

  void _filterDataAndUpdateState(String data) {
    final now = DateTime.now();
    final filtered = _filteredData.where((data) {
      final parsedData = DateTime.parse(data.split(":")[0]);
      final difference = now.difference(parsedData);
      return difference.inSeconds >=
          15; //giving it 30 seconds in between each notification
    }).toList();
    filtered.add("$now: $_data");
    setState(() {
      _filteredData = filtered;
    });
  }

  @override
  void initState() {
    super.initState();
    startSocket();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: ListView.builder(
        //this will allow us to see all the notifications that are being outputed by the UDP
        itemCount: _filteredData.length,
        itemBuilder: (context, index) {
          final data = _filteredData[index];
          return ListTile(
            title: Text(data),
          );
        },
      ),
    );
  }
}
