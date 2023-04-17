/*import 'package:flutter/material.dart';
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
      home: AuthPage(),
    );
  }
}
*/
//THIS IS THE CORRECT CODE TO CALL THE IN-APP BANNER
import 'package:flutter/material.dart';
import '../in-app-banner.dart';

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
// THIS IS WHERE THE CODE THAT CONTROLS THE IN-APP BANNER ENDS