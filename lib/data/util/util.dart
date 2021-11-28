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
