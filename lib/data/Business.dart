import 'package:flutter_day_tracker/data/BusinessType.dart';

class Business {
  int? id;
  DateTime start;
  DateTime? end;
  BusinessType type;

  Business(this.start, this.type, {DateTime? end}) {
    this.end = end;
  }

  @override
  String toString() {
    return "$id $start $end $type";
  }
}