import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_day_tracker/data/model/Business.dart';
import 'package:flutter_day_tracker/data/model/BusinessType.dart';
import 'package:flutter_day_tracker/data/util/util.dart';

import 'BusinessText.dart';

class BusinessItem extends StatelessWidget {
  final Business business;
  final void Function() onClick;

  const BusinessItem({Key? key, required this.business, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SizedBox(
            height: 100,
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  "assets/${BusinessType.values.string<BusinessType>(business.type)?.toLowerCase()}.png",
                  width: 100,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BusinessText(formatDate(business.end)),
                      BusinessText("..."),
                      BusinessText(formatDate(business.start)),
                    ],
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
