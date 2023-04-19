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
