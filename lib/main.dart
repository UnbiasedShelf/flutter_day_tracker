import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'data/Business.dart';
import 'data/BusinessType.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Day Tracker',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: MyHomePage(title: "Home"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _counter = 0;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          // Initialize FlutterFire:
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return Text("Error");
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  AddBusiness(),
                  GetBusiness()
                ],
              );
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Text("Loading");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddBusiness extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference businesses = FirebaseFirestore.instance.collection(
        'businesses');

    Future<void> addBusiness() {
      var business = Business(
          id: null,
          start: DateTime.now(),
          end: null,
          type: BusinessType.LUNCH
      );
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
    CollectionReference businesses = FirebaseFirestore.instance.collection(
        'businesses');

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
          Map<String, Object?> data = snapshot.data!.data() as Map<String, Object?>;
          return Text(Business.fromJson(data).toString());
        }

        return Text("loading");
      },
    );
  }

}
