import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_day_tracker/data/firebase/FirebaseRepository.dart';
import 'package:flutter_day_tracker/ui/widgets/BusinessItem.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../data/model/Business.dart';

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

class BusinessList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseRepository.instance.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return StreamBuilder<QuerySnapshot>(
              stream: FirebaseRepository.instance.getBusinessStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data!.docs[index];
                      Business item =
                          Business.fromJson(doc.data() as Map<String, Object?>);
                      return Dismissible(
                        key: ObjectKey(doc.id),
                        child: BusinessItem(
                            business: item,
                            onClick: () {
                              Navigator.pushNamed(context, "details",
                                  arguments: doc.id);
                            }),
                        onDismissed: (direction) {
                          FirebaseRepository.instance
                              .delete(doc.id)
                              .then((value) => {
                                    Fluttertoast.showToast(
                                        msg: "Item deleted",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black12,
                                        textColor: Colors.white,
                                        fontSize: 16.0)
                                  });
                        },
                        direction: DismissDirection.endToStart,
                      );
                    },
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                  );
                } else {
                  return Center();
                }
              });
        } else {
          return Center();
        }
      },
    );
  }
}
