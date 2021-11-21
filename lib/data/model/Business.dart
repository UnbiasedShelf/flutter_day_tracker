import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_day_tracker/data/model/BusinessType.dart';

class Business {
  DateTime start;
  DateTime? end;
  BusinessType type;

  Business({required this.start, this.end, required this.type});

  Business.fromJson(Map<String, Object?> json)
      : this(
    start: (json['start']! as Timestamp).toDate(),
    end: (json['end'] as Timestamp?)?.toDate(),
    type: BusinessType.values.enumFromString(json['type']! as String)!,
  );

  Map<String, Object?> toJson() {
    return {
      'start': start,
      'end': end,
      'type': BusinessType.values.string(type)
    };
  }

  @override
  String toString() {
    return "$start $end $type";
  }
}