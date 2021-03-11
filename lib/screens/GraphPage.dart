import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zotivity/backend/mongo.dart';
import '../models/Activity.dart';
import '../models/activityCategory.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zotivity/backend/globals.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:fl_animated_linechart/chart/area_line_chart.dart';
import 'package:fl_animated_linechart/common/pair.dart';
import 'package:fl_animated_linechart/fl_animated_linechart.dart';


class GraphPage extends StatefulWidget {
  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  @override
  Widget buildPage() {
    Map<DateTime, double> weightMap = Map();
    List<double> weights = [93,95,95,97,99,101,101,101,99,100,102,103,102,101,100,99,99,98,97];
    for(int i = 0; i < weights.length; i++){
      weightMap[DateTime.utc(2021, DateTime.february, i+1)] = weights[i];
    }

    LineChart chart;

    chart = AreaLineChart.fromDateTimeMaps(
        [weightMap], [Colors.red.shade900], ['lbs'],
        gradients: [Pair(Colors.yellow.shade400, Colors.blue.shade700)]);

    return Scaffold(
      appBar: AppBar(
        title: Text("Graph Page"),
      ),
      body: Container(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedLineChart(
                      chart,
                      key: UniqueKey(),
                    ), //Unique key to force animations
                  )),
              SizedBox(width: 200, height: 50, child: Text('Weight Graph')),
            ]),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPage(),
    );
  }
}
