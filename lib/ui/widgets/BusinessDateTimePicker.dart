import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class BusinessDateTimePicker extends StatelessWidget {
  final DateTime? begin;
  final DateTime? end;
  final String label;
  final TextEditingController controller;

  BusinessDateTimePicker(
      {Key? key,
      this.begin,
      this.end,
      required this.label,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        suffixIcon: Icon(Icons.edit)
      ),
      onTap: () {
        controller.text = DateTime.now().toString();
        DatePicker.showDateTimePicker(context,
            showTitleActions: true,
            minTime: DateTime(2018, 3, 5),
            maxTime: DateTime(2019, 6, 7),
            theme: DatePickerTheme(
                itemStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                doneStyle:
                TextStyle(color: Colors.amber[800], fontSize: 16)),
            onChanged: (date) {
              print('change $date in time zone ' +
                  date.timeZoneOffset.inHours.toString());
            }, onConfirm: (date) {
              print('confirm $date');
            }, currentTime: DateTime.now(), locale: LocaleType.en);
      },
      controller: controller,
      readOnly: true,
    );
  }
}
