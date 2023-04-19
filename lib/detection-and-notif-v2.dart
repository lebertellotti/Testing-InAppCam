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
  UdpSocketHomePageState createState() => UdpSocketHomePageState();
}

class UdpSocketHomePageState extends State<UdpSocketHomePage> {
  String _messagedata = '';
  List<String> _filteredData = [];
  Timer? _timer;

  Future<void> startSocket() async {
    final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 5005);
    socket.listen((event) {
      final datagram = socket.receive();
      if (datagram != null) {
        final data = utf8.decode(datagram.data);
        setState(() {
          _messagedata = data;
        });

        if (_timer == null || !_timer!.isActive) {
          _timer = Timer.periodic(Duration(seconds: 15), (timer) {
            setState(() {
              _filteredData = filterData(_messagedata);
            });
          });
        }
      }
    });
  }

  List<String> filterData(String data) {
    final now = DateTime.now();
    final filtered = _filteredData.where((data) {
      final parsedData = DateTime.parse(data.split(":")[0]);
      final difference = now.difference(parsedData);
      return difference.inSeconds >= 15;
    }).toList();
    filtered.add("$now: $_messagedata");
    filtered.sort((a, b) {
      final parsedA = DateTime.parse(a.split(":")[0]);
      final parsedB = DateTime.parse(b.split(":")[0]);
      return parsedB.compareTo(parsedA);
    });
    return filtered.reversed.toList();
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
      body: _filteredData.isEmpty
          ? Center(child: Text('No message'))
          : ListView.builder(
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
