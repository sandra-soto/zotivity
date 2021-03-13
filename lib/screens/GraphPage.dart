import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zotivity/backend/mongo.dart';
import '../models/Activity.dart';
import '../models/activityCategory.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zotivity/backend/globals.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
import 'package:fl_animated_linechart/chart/area_line_chart.dart';
import 'package:fl_animated_linechart/common/pair.dart';
import 'package:fl_animated_linechart/fl_animated_linechart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GraphPage extends StatefulWidget {
  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  @override
  Widget build(BuildContext context) {
    Map<DateTime, double> weightMap = Map();
    List<double> weights = [93,95,95,97,99,101,101,101,99,100,102,103,102,101,100,99,99,98,97];
    for(int i = currentZotUser.weightDateLog.length-1; i >= 0 ; i--){
      weightMap[DateTime.parse(currentZotUser.weightDateLog[i])] =  currentZotUser.weightProgress[i].toDouble();
    }

    LineChart chart;

    chart = AreaLineChart.fromDateTimeMaps(
        [weightMap], [Colors.blueAccent], ['lbs'],
        gradients: [Pair(Colors.blueAccent, Colors.blueAccent)],
        tapTextFontWeight: FontWeight.w700);

    return Container(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(23, 29, 38, 1),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          padding:  const EdgeInsets.all(15.0),
          child: SizedBox(width: 335, height: 170,
                child: AnimatedLineChart(chart, key: UniqueKey(),),
            //child:TimeSeriesBar.withSampleData(),
                ),

        );
  }

}
