import 'package:flutter/material.dart';
import 'package:flutter_day_tracker/ui/screens/details.dart';
import 'package:flutter_day_tracker/ui/screens/main.dart';
import 'package:flutter_day_tracker/ui/screens/splash.dart';
import 'package:flutter_day_tracker/ui/screens/stats.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == "details") {
          return MaterialPageRoute(
              builder: (_) => DetailsPage(argument: settings.arguments.toString())
          );
        }
      },
      routes: {
        '/': (context) => Splash(),
        '/home': (context) => MainNavigationStatefulWidget(),
        '/details': (context) => DetailsPage(),
        '/stats': (context) => StatsPage(),
      },
    );
  }
}
