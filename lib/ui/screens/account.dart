import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_day_tracker/data/auth/google.dart';
import 'package:flutter_day_tracker/data/firebase/FirebaseRepository.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseRepository.instance.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            var user = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(user.photoURL ??
                            "https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg"),
                        backgroundColor: Colors.transparent,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.displayName ?? "",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                user.email ?? "",
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, "/stats"),
                  child: Text("Statistics"),
                  style: TextButton.styleFrom(
                      primary: Colors.amber[800],
                      minimumSize: Size.fromHeight(50)),
                ),
                TextButton(
                  onPressed: () {
                    signOutOfGoogle();
                    // if (Platform.isAndroid) signOutOfGoogle();
                    // else if (Platform.isIOS) signOutOfApple();
                  },
                  child: Text("Sign out"),
                  style: TextButton.styleFrom(
                      primary: Colors.amber[800],
                      minimumSize: Size.fromHeight(50)),
                ),
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    "You are not signed in!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: TextButton(
                      onPressed: () {
                        signInWithGoogle();
                        // if (Platform.isAndroid)
                        //   signInWithGoogle();
                        // else if (Platform.isIOS) signInWithApple();
                      },
                      child: Text("Sign in"),
                      style: TextButton.styleFrom(
                          primary: Colors.amber[800],
                          minimumSize: Size.fromHeight(50))),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
