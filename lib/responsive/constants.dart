import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../new_page.dart';
import '../pages/auth_page.dart';
import '../pages/login_or_register_page.dart';
import '../pages/login_page.dart';
import '../pages/home_page.dart';

var defaultBackgroundColor = Colors.grey[300];
var appBarColor = Colors.grey[900];
var myAppBar = AppBar(
  backgroundColor: appBarColor,
  title: Text(' '),
  centerTitle: false,
);
var drawerTextColor = TextStyle(
  color: Colors.grey[600],
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      drawer: myDrawer(context),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}


//class SettingsPage extends StatelessWidget {
  //@override
  //Widget build(BuildContext context) {
    //return Scaffold(
      //appBar: myAppBar,
      //drawer: myDrawer(context),
      //body: Center(
        //child: Text('Settings Page'),
      //),
    //);
  //}
//}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  double _fontSize = 16;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: myAppBar,
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.grey[900],
      ),
      drawer: myDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text(
              //'Settings',
              //textAlign: TextAlign.center,
              //style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            //),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Enable Notifications'),
                Switch(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Font Size'),
            Slider(
              value: _fontSize,
              min: 12,
              max: 24,
              divisions: 6,
              onChanged: (value) {
                setState(() {
                  _fontSize = value;
                });
              },
              label: _fontSize.round().toString(),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.grey[900],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'In-Car Safety Monitoring System',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.grey[700]),
              ),
            ),
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'The system can sense if a person or pet is alone in a vehicle and check if they are in distress due to extreme weather conditions. It will then send out alerts to notify the driver.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
  //@override
  //Widget build(BuildContext context) {
    //return Scaffold(
      //appBar: myAppBar,
      //drawer: myDrawer(context),
      //body: Center(
        //child: Text('About Page'),
      //),
    //);
  //}

  //Widget build(BuildContext context) {
    //return Scaffold(
      //appBar: myAppBar,
      //drawer: myDrawer(context),
      //body: Padding(
        //padding: const EdgeInsets.all(16.0),
        //child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          //children: [
            //Text(
              //'In-Car Safety Monitoring System',
              //textAlign: TextAlign.center,
              //style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            //),
            //SizedBox(height: 16),
            //Text(
              //'The system can sense if a person or pet is alone in a vehicle and check if they are in distress due to extreme weather conditions. It will then send out alerts to notify the driver.',
              //textAlign: TextAlign.center,
              //style: TextStyle(fontSize: 16),
            //),
          //],
        //),
      //),
    //);
  //}

class LogoutPage extends StatelessWidget {


  LogoutPage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  //Widget build(BuildContext context) {
  //return Scaffold(
  //appBar: myAppBar,
  //drawer: myDrawer(context),
  //body: Center(
  //child: Text('Logout Page'),
  //),
  //);
  //}
//}


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            //onPressed: signUserOut,
            onPressed: () {
            signUserOut();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AuthPage()),
            );
          }, icon: const Icon(Icons.logout),
            
          )
        ],
      ),
      body: Center(
        child: Text('Logout Page'),
        )
      );
          }
          
            signUserOut() {
              FirebaseAuth.instance.signOut();
            }
  }

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
                MaterialPageRoute(builder: (context) => NewPage()),
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
              'S E T T I N G S',
              style: drawerTextColor,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
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


/* import 'package:flutter/material.dart';

var defaultBackgroundColor = Colors.grey[300];
var appBarColor = Colors.grey[900];
var myAppBar = AppBar(
  backgroundColor: appBarColor,
  title: const Text(' '),
  centerTitle: false,
);
var drawerTextColor = TextStyle(
  color: Colors.grey[600],
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);
var myDrawer = Drawer(
  backgroundColor: Colors.grey[300],
  elevation: 0,
  child: Column(
    children: [
      const DrawerHeader(
        child: Icon(
          Icons.favorite,
          size: 64,
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: const Icon(Icons.home),
          title: Text(
            'D A S H B O A R D',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: const Icon(Icons.settings),
          title: Text(
            'S E T T I N G S',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: const Icon(Icons.info),
          title: Text(
            'A B O U T',
            style: drawerTextColor,
          ),
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: const Icon(Icons.logout),
          title: Text(
            'L O G O U T',
            style: drawerTextColor,
          ),
        ),
      ),
    ],
  ),
);
*/