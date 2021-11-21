import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_day_tracker/data/firebase/FirebaseRepository.dart';

class Splash extends StatelessWidget {
  Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseRepository.instance
        .init()
        .then((_) => Navigator.pushReplacementNamed(context, "/home"));

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