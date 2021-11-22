/// Flutter code sample for AnimatedPositioned

// The following example transitions an AnimatedPositioned
// between two states. It adjusts the `height`, `width`, and
// [Positioned] properties when tapped.

import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  State<StatsPage> createState() => _StatsPageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _StatsPageState extends State<StatsPage> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 350,
      child: Stack(
        children: <Widget>[
          AnimatedPositioned(
            width: 100.0,
            height: 100.0,
            top: 0.0,
            left: selected ? 500.0 : 0.0,
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = !selected;
                });
              },
              child: Icon(
                Icons.accessible_forward_outlined,
                size: 100.0
              ),
            ),
          ),
        ],
      ),
    );
  }
}

