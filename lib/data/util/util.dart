import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter_day_tracker/data/model/BusinessType.dart';
import 'package:flutter_day_tracker/data/util/messages.dart';
import 'package:intl/intl.dart';

final DateFormat dateFormat = DateFormat('HH:mm dd.MM.yyyy');
final DateFormat timeFormat = DateFormat('HH:mm');

String formatDate(DateTime? date) {
  if (date == null) return "Now";
  DateTime now = DateTime.now();
  DateTime tomorrow = DateTime.fromMillisecondsSinceEpoch(
      (now.millisecondsSinceEpoch / 86400000.0).ceil() * 86400000 - now.timeZoneOffset.inMilliseconds - 1,
    isUtc: false
  );
  var delta = tomorrow.toUtc().difference(date.toUtc()).inDays;
  if (delta == 0) {
    return "${timeFormat.format(date)}, today";
  }
  if (delta == 1) {
    return "${timeFormat.format(date)}, yesterday";
  }
  if (delta < 7) {
    return "${timeFormat.format(date)}, $delta days ago";
  } else {
    return dateFormat.format(date);
  }
}

String formatType(BusinessType type) {
  var result = BusinessType.values
      .string<BusinessType>(type)
      ?.toLowerCase() ??
      "";
  result = result.substring(0, 1).toUpperCase() + result.substring(1);
  return result;
}

String buildRecommendationsFromDataMap(Map<String, double> dataMap) {
  String result = "";
  double sum = dataMap.values.sum;
  if (dataMap["Chill"] != null && dataMap["Chill"]! / sum < 0.1) result += too_few_chill;
  if (dataMap["Cleaning"] != null && dataMap["Cleaning"]! / sum < 0.01) result += too_few_cleaning;
  if (dataMap["Cooking"] != null && dataMap["Cooking"]! / sum > 0.05) result += too_much_cooking;
  if (dataMap["Lunch"] != null && dataMap["Lunch"]! / sum < 0.05) result += too_few_lunch;
  if (dataMap["Road"] != null && dataMap["Road"]! / sum > 0.1) result += too_much_road;
  if (dataMap["Sleep"] != null && dataMap["Sleep"]! / sum < 0.3) result += too_few_sleep;
  if (dataMap["Work"] != null && dataMap["Work"]! / sum > 0.3) result += too_much_work;
  if (dataMap["Workout"] != null && dataMap["Workout"]! / sum < 0.02) result += too_few_workout;

  return result;
}