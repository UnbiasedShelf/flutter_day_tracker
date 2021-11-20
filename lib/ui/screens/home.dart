import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_day_tracker/data/auth/google.dart';

import '../../data/model/Business.dart';
import '../../data/model/BusinessType.dart';

class HomePage extends StatelessWidget {
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
            AddBusiness(),
            GetBusiness(),
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

class AddBusiness extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference businesses =
        FirebaseFirestore.instance.collection('businesses');

    Future<void> addBusiness() {
      var business = Business(
          id: null, start: DateTime.now(), end: null, type: BusinessType.LUNCH);
      return businesses
          .add(business.toJson())
          .then((value) => print("Business Added"))
          .catchError((error) => print("Failed to add business: $error"));
    }

    return OutlinedButton(onPressed: addBusiness, child: Text("Press me"));
  }
}

class GetBusiness extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference businesses =
        FirebaseFirestore.instance.collection('businesses');

    return FutureBuilder<DocumentSnapshot>(
      future: businesses.doc("yWUotAzgTloHXwHxNLiy").get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, Object?> data =
              snapshot.data!.data() as Map<String, Object?>;
          return Text(Business.fromJson(data).toString());
        }

        return Text("loading");
      },
    );
  }
}
