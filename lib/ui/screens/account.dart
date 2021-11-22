import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_day_tracker/data/auth/google.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // signInWithGoogle().then((value) => print(value));

    FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          children: [
            OutlinedButton(
                onPressed: () =>
                    signOutOfGoogle().then((value) => print(auth.currentUser)),
                child: Text("Sign out")),
            OutlinedButton(
                onPressed: () =>
                    signInWithGoogle().then((value) => print(auth.currentUser)),
                child: Text("Sign in")),
          ],
        ),
      ),
    );
  }
}