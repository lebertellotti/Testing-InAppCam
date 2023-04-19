import 'package:flutter/material.dart';
//change path?
import 'package:firebase_core/firebase_core.dart';
import 'package:modernlogintute/responsive/desktop_body.dart';
import 'package:modernlogintute/responsive/mobile_body.dart';
import 'package:modernlogintute/responsive/tablet_body.dart';
import 'firebase_options.dart';
import 'pages/auth_page.dart';
import 'responsive/responsive_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

//class MyApp extends StatelessWidget {
//const MyApp({super.key});

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      //home: ResponsiveLayout(
      //mobileBody: const MobileScaffold(),
      //tabletBody: const TabletScaffold(),
      //desktopBody: const DesktopScaffold(),
      //),
      home: const AuthPage(),
    );
  }
}

/*
//test1
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthPage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
*/
//THIS IS THE CORRECT CODE TO CALL THE IN-APP BANNER
/*
import 'package:flutter/material.dart';
import '../udp-notif.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
        ),
        body: Center(
          child: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                child: Text('Show Banner'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('this is a test of an alert'),
                    duration: Duration(seconds: 15),
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: 'close',
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  ));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
*/
// THIS IS WHERE THE CODE THAT CONTROLS THE IN-APP BANNER ENDS

//this is me trying to get the UDP socket to pop up as an in-app alert rather than a print statement on the screen
/*
import '../udp-socket.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: UdpSocketHomePage(),
    );
  }
}*/

//// this is testing out the location notif
/*
import '../pages/detection-and-temp-notif.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Combined(),
    );
  }
}
*/
/*
import '../detection-and-notif-v2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: UdpSocketHomePage(),
    );
  }
}
*/

//// UDP NOTIF IN A BANNER FORMAT MAIN FUNCTION STARTS HERE
/*
import '../notif.dart'; //location_page.dart';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import '../pages/location_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: NotifPage(),
    );
  }
}
*/
//// UDP NOTIF IN A BANNER FORMAT MAIN FUNCTION ENDS HERE
