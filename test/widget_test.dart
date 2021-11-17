// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_day_tracker/data/Business.dart';
import 'package:flutter_day_tracker/data/BusinessType.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_day_tracker/main.dart';

void main() {
  Business business = Business(
    id: null,
    start: DateTime.now(),
    end: null,
    type: BusinessType.LUNCH
  );

  var json = business.toJson();
  print(json);
  var business1 = Business.fromJson(json);
  print(business1);
}
