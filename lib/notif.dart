import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../pages/location_page.dart';
import 'package:flutter/scheduler.dart' show WidgetsBinding;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:modernlogintute/new_page.dart';
import 'package:modernlogintute/notif.dart';
//import '../notif.dart';
import '../responsive/constants.dart';
import '../pages/login_or_register_page.dart';
import 'responsive/desktop_body.dart';
import 'responsive/mobile_body.dart';
import 'responsive/responsive_layout.dart';
import 'responsive/tablet_body.dart';
import '../util/my_box.dart';
import '../udp-socket.dart';
import '../responsive/constants.dart';
import '../pages/home_page.dart';

class NotifPage extends StatefulWidget {
  @override
  NotifPageState createState() => NotifPageState();
}

class NotifPageState extends State<NotifPage> {
  String udpMessage = '';
  bool isDialogDisplayed = false; // added

  // here we would add the widget dashboard
  Widget buildDashboard() {
    String currentAddress = 'Palm Beach County';

    return GridView.count(
      crossAxisCount: 1, // set the number of columns to 1
      childAspectRatio: 3 / 1, // set the aspect ratio to 4:1
      children: <Widget>[
        // first container
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 78,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200]),
            child: Center(
              child: Text(
                'Welcome to the In-Car Safety Monitoring Application!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        // second container
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: Center(
              child: Text(
                'Today\'s date and time: ${DateTime.now().toString()}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        //third
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: Center(
              child: Text(
                currentAddress ?? 'Unknown address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    // Listen for UDP messages
    // Replace 'udpPort' with the port number you are listening on
    // Replace 'udpAddress' with the IP address you are listening on
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 5005)
        .then((RawDatagramSocket socket) {
      socket.listen((RawSocketEvent event) {
        if (event == RawSocketEvent.read) {
          Datagram? datagram = socket.receive();
          if (datagram != null) {
            setState(() {
              // Update the _udpMessage variable with the received message
              udpMessage = String.fromCharCodes(datagram.data).trim();
            });

            // Display the message as a print statement
            print('UDP Message Received: $udpMessage');
            // Display an in-app banner
            Fluttertoast.showToast(
              msg: 'New message received: $udpMessage',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            if (udpMessage.contains('Alert: \'Person Detected\'')) {
              if (!isDialogDisplayed) {
                isDialogDisplayed = true; // added
                // added
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(Duration(seconds: 5), () {
                        Navigator.of(context).pop(true);
                      });
                      return AlertDialog(
                        title: Text('Person Detected'),
                        content:
                            Text('A person has been detected in the area.'),
                        actions: [
                          ElevatedButton(
                              child: Text('Check temperature (redirect)'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LocationPage()),
                                );
                              }),
                          ElevatedButton(
                              //onPressed: () => Navigator.pop(context),
                              child: Text(
                                  'please note that someone might be in danger '),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                              }),
                        ],
                      );
                    },
                  ).then((value) {
                    setState(() {
                      isDialogDisplayed = false;
                    });
                  });
                });
              }
            }
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildDashboard(),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UDP Notification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'This page receives the notification from the raspeberyy pi .'),
            ElevatedButton(
              child: Text('Go to Temperature check '),
              onPressed: () {
                // Navigate to the second page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Check'),
      ),
      body: Center(
        child: Text('This is where the temperature check happens.'),
      ),
    );
  }
}

/// HERES THE DRAWER:
///
Widget myDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.grey[300],
    elevation: 0,
    child: Column(
      children: [
        DrawerHeader(
          child: Icon(
            Icons.menu,
            size: 64,
          ),
        ),
        Padding(
          padding: tilePadding,
          child: ListTile(
            leading: Icon(Icons.home),
            title: Text(
              'D A S H B O A R D',
              style: drawerTextColor,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotifPage()),
              );
            },
          ),
        ),
        Padding(
          padding: tilePadding,
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'L O C A T I O N ',
              style: drawerTextColor,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LocationPage()),
              );
            },
          ),
        ),
        Padding(
          padding: tilePadding,
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'P A S T  N O T I F I C A T I O N S',
              style: drawerTextColor,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UdpSocketHomePage()),
              );
            },
          ),
        ),
        Padding(
          padding: tilePadding,
          child: ListTile(
            leading: Icon(Icons.info),
            title: Text(
              'A B O U T',
              style: drawerTextColor,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ),
        Padding(
          padding: tilePadding,
          child: ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'L O G O U T',
              style: drawerTextColor,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogoutPage()),
              );
            },
          ),
        ),
      ],
    ),
  );
}
/*
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../pages/location_page.dart';
import 'package:flutter/scheduler.dart' show WidgetsBinding;

class NotifPage extends StatefulWidget {
  @override
  NotifPageState createState() => NotifPageState();
}

class NotifPageState extends State<NotifPage> {
  String udpMessage = '';
  bool isDialogDisplayed = false; // added
// here we would add the widget dashboard 
  @override
  void initState() {
    super.initState();
    // Listen for UDP messages
    // Replace 'udpPort' with the port number you are listening on
    // Replace 'udpAddress' with the IP address you are listening on
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 5005)
        .then((RawDatagramSocket socket) {
      socket.listen((RawSocketEvent event) {
        if (event == RawSocketEvent.read) {
          Datagram? datagram = socket.receive();
          if (datagram != null) {
            setState(() {
              // Update the _udpMessage variable with the received message
              udpMessage = String.fromCharCodes(datagram.data).trim();
            });

            // Display the message as a print statement
            print('UDP Message Received: $udpMessage');
            // Display an in-app banner
            Fluttertoast.showToast(
              msg: 'New message received: $udpMessage',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            if (udpMessage.contains('Alert: \'Person Detected\'')) {
              if (!isDialogDisplayed) {
                isDialogDisplayed = true; // added
                // added
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(Duration(seconds: 5), () {
                        Navigator.of(context).pop(true);
                      });
                      return AlertDialog(
                        title: Text('Person Detected'),
                        content:
                            Text('A person has been detected in the area.'),
                        actions: [
                          ElevatedButton(
                              child: Text('Check temperature (redirect)'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LocationPage()),
                                );
                              }),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                                'please note that someone might be in danger '),
                          ),
                        ],
                      );
                    },
                  ).then((value) {
                    setState(() {
                      isDialogDisplayed = false;
                    });
                  });
                });
              }
            }
          }
        }
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('used for testing purposes'),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UDP Notification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'This page receives the notification from the raspeberyy pi .'),
            ElevatedButton(
              child: Text('Go to Temperature check '),
              onPressed: () {
                // Navigate to the second page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Check'),
      ),
      body: Center(
        child: Text('This is where the temperature check happens.'),
      ),
    );
  }
}
*/

/*
THIS IS THE CODE THAT TURNS ON THE BLUE NOTIFICATION AND THE DIALOG BOX. IT ALSO IS LINKING TO THE LOCATION PAGE 

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../pages/location_page.dart';
import 'package:flutter/scheduler.dart' show WidgetsBinding;

class NotifPage extends StatefulWidget {
  @override
  NotifPageState createState() => NotifPageState();
}

class NotifPageState extends State<NotifPage> {
  String udpMessage = '';
  bool isDialogDisplayed = false; // added

  @override
  void initState() {
    super.initState();
    // Listen for UDP messages
    // Replace 'udpPort' with the port number you are listening on
    // Replace 'udpAddress' with the IP address you are listening on
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 5005)
        .then((RawDatagramSocket socket) {
      socket.listen((RawSocketEvent event) {
        if (event == RawSocketEvent.read) {
          Datagram? datagram = socket.receive();
          if (datagram != null) {
            setState(() {
              // Update the _udpMessage variable with the received message
              udpMessage = String.fromCharCodes(datagram.data).trim();
            });

            // Display the message as a print statement
            print('UDP Message Received: $udpMessage');
            // Display an in-app banner
            Fluttertoast.showToast(
              msg: 'New message received: $udpMessage',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            // Navigate to the first page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FirstPage()),
            ); /*.then((_) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocationPage()),
              );
            });*/
          }
        }
      });
    });
  }

  Widget build(BuildContext context) {
    if (udpMessage.contains('Alert: \'Person Detected\'')) {
      if (!isDialogDisplayed) {
        isDialogDisplayed = true; // added
        // added
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Person Detected'),
              content: Text('A person has been detected in the area.'),
              actions: [
                ElevatedButton(
                    child: Text('Check temperature (redirect)'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LocationPage()),
                      );
                    }),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('please note that someone might be in danger '),
                ),
              ],
            ),
          ).then((value) {
            setState(() {
              isDialogDisplayed = false;
            });
          });
          //setState(() {
          //isDialogDisplayed = true;
          //});
        });
      } //else if (isDialogDisplayed) {
      //Navigator.of(context).pop();
      //setState(() {
      //  isDialogDisplayed = false;
      //});
      // }

      // old code stops here
    }
    return Scaffold(
      body: Center(
        child: Text('used for testing puposes'),
      ),
      /*body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FirstPage()),
          );
        },
        child: Center(
          child: Text('Click here to go to the first page'),
        ),
      ),*/
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UDP Notification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'This page receives the notification from the raspeberyy pi .'),
            ElevatedButton(
              child: Text('Go to Temperature check '),
              onPressed: () {
                // Navigate to the second page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Check'),
      ),
      body: Center(
        child: Text('This is where the temperature check happens.'),
      ),
    );
  }
}

THIS IS WHERE THE CODE EN
*/
