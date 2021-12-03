import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_day_tracker/data/model/BusinessType.dart';
import 'package:flutter_day_tracker/ui/widgets/BusinessTypeCard.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Center(
        child: Column(
          children: [
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              children: List.generate(BusinessType.values.length, (index) {
                return BusinessTypeCard(
                  index: index,
                  isSelected: index == selectedIndex,
                  onClick: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
