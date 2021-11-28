/// Flutter code sample for AnimatedPositioned

// The following example transitions an AnimatedPositioned
// between two states. It adjusts the `height`, `width`, and
// [Positioned] properties when tapped.

import 'dart:math';

import 'package:flutter/material.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  State<StatsPage> createState() => _StatsPageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _StatsPageState extends State<StatsPage> {
  List<bool> selected = List<bool>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistics"),
      ),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
