import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_day_tracker/data/firebase/FirebaseRepository.dart';
import 'package:flutter_day_tracker/data/model/Business.dart';
import 'package:flutter_day_tracker/data/model/BusinessType.dart';
import 'package:flutter_day_tracker/data/util/util.dart';
import 'package:pie_chart/pie_chart.dart';

class StatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistics"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseRepository.instance.getBusinessStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var now = DateTime.now();
            var businesses = snapshot.data!.docs.map((doc) {
              var business =
                  Business.fromJson(doc.data() as Map<String, Object?>);
              return MapEntry(business.type,
                  (business.end ?? now).difference(business.start).inMinutes);
            });
            var typeToTotalTime =
                groupBy<MapEntry<BusinessType, int>, BusinessType>(
              businesses,
              (MapEntry<BusinessType, int> entry) => entry.key,
            ).map((key, value) => MapEntry(
                    formatType(key), value.map((e) => e.value).sum.toDouble()));

            return Column(
              children: [
                PieChart(
                  dataMap: typeToTotalTime,
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: true,
                    showChartValuesOutside: false,
                    decimalPlaces: 1,
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: Text(
                "Loading...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
