import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_day_tracker/data/firebase/FirebaseRepository.dart';
import 'package:flutter_day_tracker/ui/widgets/BusinessItem.dart';

import '../../data/model/Business.dart';
import '../../data/model/BusinessType.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: BusinessList(),
    );
  }
}

//todo validation
class AddBusiness extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> addBusiness() {
      var business = Business(start: DateTime.now(), end: null, type: BusinessType.LUNCH);
      return FirebaseRepository.instance.addBusiness(business)
          .then((value) => print("Business Added"))
          .catchError((error) => print("Failed to add business: $error"));
    }

    return OutlinedButton(onPressed: addBusiness, child: Text("Press me"));
  }
}

class BusinessList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseRepository.instance.getBusinessStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                Business item = Business.fromJson(doc.data() as Map<String, Object?>);
                return BusinessItem(business: item, onClick: () {
                  Navigator.pushNamed(context, "details", arguments: doc.id);
                });
              },
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            );
          } else {
            return Center();
          }
        });
  }
}
