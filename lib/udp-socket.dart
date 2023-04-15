import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'In App Camera Notification UDP Socket Demo',
      home: UdpSocketHomePage(),
    );
  }
}

class UdpSocketHomePage extends StatefulWidget {
  @override
  _UdpSocketHomePageState createState() => _UdpSocketHomePageState();
}

class _UdpSocketHomePageState extends State<UdpSocketHomePage> {
  List<String> _dataList = [];

  Future<void> startSocket() async {
    final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 5005);
    socket.listen((event) {
      final datagram = socket.receive();
      if (datagram != null) {
        final data = utf8.decode(datagram.data);
        setState(() {
          _dataList.add(data);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startSocket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: ListView.builder(
        //this will allow us to see all the notifications that are being outputed by the UDP
        itemCount: _dataList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_dataList[index]),
          );
        },
      ),
    );
  }
}
