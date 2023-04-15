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

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      drawer: myDrawer(context),
      body: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      drawer: myDrawer(context),
      body: Center(
        child: Text('About Page'),
      ),
    );
  }
}

class LogoutPage extends StatelessWidget {
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