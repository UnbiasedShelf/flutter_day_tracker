import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NamedDivider extends StatelessWidget {
  final String name;

  NamedDivider({Key? key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: SizedBox(
          height: 10.0,
          child: new Center(
            child: new Container(
              margin: new EdgeInsetsDirectional.only(start: 2.0, end: 2.0),
              height: 1.0,
              color: Colors.grey,
            ),
          ),
        )),
        Text(
          name,
          style: TextStyle(
            fontSize: 20
          ),
        ),
        Expanded(
            child: SizedBox(
          height: 10.0,
          child: new Center(
            child: new Container(
              margin: new EdgeInsetsDirectional.only(start: 2.0, end: 2.0),
              height: 1.0,
              color: Colors.grey,
            ),
          ),
        )),
      ],
    );
  }
}
