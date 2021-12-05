import 'package:flutter/material.dart';
import 'package:flutter_day_tracker/data/firebase/FirebaseRepository.dart';
import 'package:flutter_day_tracker/data/model/Business.dart';
import 'package:flutter_day_tracker/data/model/BusinessType.dart';
import 'package:flutter_day_tracker/data/util/util.dart';
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
  Business business =
      Business(start: DateTime.now(), end: null, type: BusinessType.values[0]);

  @override
  void initState() {
    super.initState();
    setState(() {
      _controller.text = _getValueByIndex(selectedIndex);
      _startController.text = formatDate(business.start);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Center(
        child: SingleChildScrollView(
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
                      primary: Colors.amber[800]),
                  onPressed: () {
                    var selectedType = BusinessType.values[selectedIndex];
                    business.type = selectedType;
                    business.start = DateTime.now();
                    business.end = null;
                    _save();
                  },
                  child: Text(
                    "SAVE WITH NOW AS BEGIN",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: NamedDivider(name: 'or')),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    "Setup time range manually:",
                    style: TextStyle(fontSize: 20),
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: BusinessDateTimePicker(
                    label: "Start",
                    controller: _startController,
                    begin: DateTime.fromMillisecondsSinceEpoch(0),
                    end: business.end?.add(Duration(seconds: 1)),
                    onDone: (date) {
                      setState(() {
                        business.start = date;
                        _startController.text = formatDate(date);
                      });
                    },
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: BusinessDateTimePicker(
                    label: "End",
                    controller: _endController,
                    begin: business.start.add(Duration(minutes: 1)),
                    onDone: (date) {
                      setState(() {
                        business.end = date;
                        _endController.text = formatDate(date);
                      });
                    },
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(40),
                      primary: Colors.amber[800]),
                  onPressed: () {
                    var selectedType = BusinessType.values[selectedIndex];
                    business.type = selectedType;
                    if(_validate(business)) _save();
                    else ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Invalid range"),
                        )
                    );
                  },
                  child: Text(
                    "SAVE",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
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

  bool _validate(Business business) {
    DateTime now = DateTime.now();
    print(business.end?.add(Duration(minutes: 1)).difference(business.start));
    print(business.end?.add(Duration(minutes: 1)).difference(business.start).isNegative);
    print(business.end?.difference(now));
    print(business.end?.difference(now).isNegative);
    bool result = !(business.end?.add(Duration(minutes: 1)).difference(business.start).isNegative ?? false)
        && (business.end?.difference(now).isNegative ?? true);
   return result;
  }

  void _save() {
    FirebaseRepository.instance.addBusiness(business);
    Navigator.pop(context);
  }
}
