import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modernlogintute/new_page.dart';
import 'package:modernlogintute/notif.dart';
import '../notif.dart';
import '../responsive/constants.dart';
import 'login_or_register_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
            ),
            child: Text('View Dashboard'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotifPage()),
                //child: Text(
                //"LOGGED IN AS: " + user.email!,
                //style: TextStyle(fontSize: 20),
                //)),
              );
            }),
      ),
    );
  }
}
