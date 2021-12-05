import 'package:flutter/material.dart';
import 'package:flutter_day_tracker/data/firebase/FirebaseRepository.dart';
import 'package:flutter_day_tracker/data/model/Business.dart';
import 'package:flutter_day_tracker/data/model/BusinessType.dart';
import 'package:flutter_day_tracker/data/util/util.dart';
import 'package:flutter_day_tracker/ui/widgets/BusinessDateTimePicker.dart';
import 'package:flutter_day_tracker/ui/widgets/BusinessTypeCard.dart';
import 'package:flutter_day_tracker/ui/widgets/NamedDivider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailsPage extends StatefulWidget {
  final String? argument;

  const DetailsPage({Key? key, this.argument}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState(argument);
}

class _DetailsPageState extends State<DetailsPage> {
  final String? docId;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  Business business =
      Business(start: DateTime.now(), end: null, type: BusinessType.values[0]);

  _DetailsPageState(this.docId) : super();

  @override
  void initState() {
    super.initState();
    if (docId != null) {
      FirebaseRepository.instance.getBusinessById(docId!).then((value) =>
          setState(() {
            business = Business.fromJson(value.data() as Map<String, Object?>);
            _controller.text = _getValueByIndex(business.type.index);
            _startController.text = formatDate(business.start);
            business.end != null ? _endController.text = formatDate(business.end) : null;
          })
      );
    } else {
      setState(() {
        _controller.text = _getValueByIndex(business.type.index);
        _startController.text = formatDate(business.start);
      });
    }
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
                      isSelected: index == business.type.index,
                      onClick: () {
                        setState(() {
                          business.type = BusinessType.values[index];
                          _controller.text = _getValueByIndex(business.type.index);
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
                    if (docId == null) {
                      business.start = DateTime.now();
                      business.end = null;
                    } else {
                      business.end = DateTime.now();
                    }
                    _save();
                  },
                  child: Text(
                    docId == null ? "SAVE WITH NOW AS BEGIN" : "SAVE WITH NOW AS END",
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
                    if (_validate(business))
                      _save();
                    else
                      Fluttertoast.showToast(
                          msg: "Invalid Range",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black12,
                          textColor: Colors.white,
                          fontSize: 16.0);
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
    var type = BusinessType.values[index];
    return formatType(type);
  }

  bool _validate(Business business) {
    DateTime now = DateTime.now();
    bool result = !(business.end
                ?.add(Duration(minutes: 1))
                .difference(business.start)
                .isNegative ??
            false) &&
        (business.end?.difference(now).isNegative ?? true);
    return result;
  }

  void _save() {
    if (docId == null) {
      FirebaseRepository.instance.addBusiness(business).then((value) => _showToastSaved());
    } else {
      FirebaseRepository.instance.updateBusiness(docId!, business).then((value) => _showToastSaved());
    }


    Navigator.pop(context);
  }

  void _showToastSaved() {
    Fluttertoast.showToast(
        msg: "Item saved successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black12,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
