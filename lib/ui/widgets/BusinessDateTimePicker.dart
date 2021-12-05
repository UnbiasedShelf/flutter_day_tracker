import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class BusinessDateTimePicker extends StatelessWidget {
  final DateTime now = DateTime.now();
  final DateTime? begin;
  final DateTime? end;
  final String label;
  final TextEditingController controller;
  final Function(DateTime) onDone;

  BusinessDateTimePicker(
      {Key? key,
      this.begin,
      this.end,
      required this.label,
      required this.controller,
      required this.onDone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          suffixIcon: Icon(Icons.edit)),
      onTap: () {

        DatePicker.showDateTimePicker(context,
            showTitleActions: true,
            minTime: begin ?? DateTime.fromMillisecondsSinceEpoch(0),
            maxTime: end ?? now,
            theme: DatePickerTheme(
                itemStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                doneStyle: TextStyle(color: Colors.amber[800], fontSize: 16)),
            onConfirm: (date) {
              onDone(date);
            },
            currentTime: end ?? now,
            locale: LocaleType.values.firstWhere((element) => element
                .toString()
                .substring(element.toString().indexOf(".") + 1) ==
                Localizations.localeOf(context).languageCode,
                orElse: () => LocaleType.en
            )
        );
      },
      controller: controller,
      readOnly: true,
    );
  }
}
