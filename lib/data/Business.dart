import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_day_tracker/data/BusinessType.dart';

class Business {
  int? id;
  DateTime start;
  DateTime? end;
  BusinessType type;

  Business({this.id, required this.start, this.end, required this.type});

  Business.fromJson(Map<String, Object?> json)
      : this(
    id: json['id'] as int?,
    start: (json['start']! as Timestamp).toDate(),
    end: (json['end'] as Timestamp?)?.toDate(),
    type: BusinessType.values.enumFromString(json['type']! as String)!,
  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'start': start,
      'end': end,
      'type': BusinessType.values.string(type)
    };
  }

  @override
  String toString() {
    return "$id $start $end $type";
  }
}