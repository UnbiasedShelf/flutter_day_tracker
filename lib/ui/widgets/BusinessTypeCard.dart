import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_day_tracker/data/model/BusinessType.dart';


class BusinessTypeCard extends StatelessWidget {
  final int index;
  final bool isSelected;
  final void Function() onClick;

  const BusinessTypeCard(
      {Key? key,
      required this.index,
      required this.isSelected,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Center(
        child: Card(
          child: AnimatedContainer(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "assets/${BusinessType.values.string<BusinessType>(BusinessType.values[index])?.toLowerCase()}.png",
                width: 100,
              ),
            ),
            decoration: BoxDecoration(
              color: isSelected ? Colors.amber[800] : Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            duration: Duration(milliseconds: 100),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
