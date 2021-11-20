import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  Splash({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    _initialization.then((_) => Navigator.pushNamed(context, "/home"));

    return Scaffold(
        backgroundColor: Colors.lightGreen,
        body: Center(
          child: Image.asset(
            'assets/alarm-clock.png',
            height: 125,
            width: 125,
          ),
        ));
  }
}