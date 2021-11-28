import 'package:flutter/material.dart';
import 'package:flutter_day_tracker/ui/screens/stats.dart';

import 'account.dart';
import 'home.dart';

/// This is the stateful widget that the main application instantiates.
class MainNavigationStatefulWidget extends StatefulWidget {
  const MainNavigationStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MainNavigationStatefulWidget> createState() => _MainNavigationStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MainNavigationStatefulWidgetState extends State<MainNavigationStatefulWidget> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    StatsPage(),
    AccountPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

