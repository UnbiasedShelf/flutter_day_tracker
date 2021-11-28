import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusinessText extends StatelessWidget {
  final String text;
  const BusinessText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20
      ),
    );
  }
}
