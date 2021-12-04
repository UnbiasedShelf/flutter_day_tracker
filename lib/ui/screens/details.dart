import 'package:flutter/material.dart';
import 'package:flutter_day_tracker/data/firebase/FirebaseRepository.dart';
import 'package:flutter_day_tracker/data/model/Business.dart';
import 'package:flutter_day_tracker/data/model/BusinessType.dart';
import 'package:flutter_day_tracker/ui/widgets/BusinessDateTimePicker.dart';
import 'package:flutter_day_tracker/ui/widgets/BusinessTypeCard.dart';
import 'package:flutter_day_tracker/ui/widgets/NamedDivider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int selectedIndex = 0;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _controller.text = _getValueByIndex(selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: GridView.count(
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                shrinkWrap: true,
                crossAxisCount: 3,
                children: List.generate(BusinessType.values.length, (index) {
                  return BusinessTypeCard(
                    index: index,
                    isSelected: index == selectedIndex,
                    onClick: () {
                      setState(() {
                        selectedIndex = index;
                        _controller.text = _getValueByIndex(selectedIndex);
                      });
                    },
                  );
                }),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Business type',
                ),
                controller: _controller,
                readOnly: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40),
                  primary: Colors.amber[800]
                ),
                onPressed: () {
                  var selectedType = BusinessType.values[selectedIndex];
                  var business = Business(start: DateTime.now(), type: selectedType);
                  FirebaseRepository.instance.addBusiness(business);
                  Navigator.pop(context);
                },
                child: Text(
                  "SET NOW AS BEGIN",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: NamedDivider(name: 'or')
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                    "Setup time range manually:",
                  style: TextStyle(fontSize: 20),
                )
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: BusinessDateTimePicker(
                  label: "Start",
                  controller: _startController,
                )
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: BusinessDateTimePicker(
                  label: "End",
                  controller: _endController,
                )
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getValueByIndex(int index) {
    var result = BusinessType.values
            .string<BusinessType>(BusinessType.values[index])
            ?.toLowerCase() ??
        "";
    result = result.substring(0, 1).toUpperCase() + result.substring(1);
    return result;
  }
}
