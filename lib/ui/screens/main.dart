import 'package:flutter/material.dart';
import 'package:flutter_day_tracker/ui/screens/stats.dart';
import 'package:flutter_day_tracker/ui/widgets/BottomBar.dart';

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
    // StatsPage(),
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
      bottomNavigationBar: FABBottomAppBar(
        items: <FABBottomAppBarItem>[
          FABBottomAppBarItem(
            iconData: Icons.home,
            text: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.show_chart),
          //   label: 'Statistics',
          // ),
          FABBottomAppBarItem(
            iconData: Icons.account_circle_rounded,
            text: 'Account',
          ),
        ],
        selectedColor: Colors.amber[800]!,
        onTabSelected: _onItemTapped,
        notchedShape: CircularNotchedRectangle(),
        centerItemText: "Add",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: "Add",
        backgroundColor: Colors.amber[800],
        onPressed: () { Navigator.pushNamed(context, "/details"); },
        child: const Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }
}

