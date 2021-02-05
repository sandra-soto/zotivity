import 'package:flutter/material.dart';
import '../models/Activity.dart';
import './ActivityPage.dart';

class HomePage extends StatelessWidget {
  @override
  Activity a = Activity(
      "Take a Walk",
      "https://www.readytowakeup.biz/wp-content/uploads/2017/03/161018141431-silicon-valley-walk-stock-780x439.jpg",
      "exercise",
      30,
      '''Description for Taking A Walk
      Simulating a very long description
      This should be scrollable
      ...
      ...
      ...
      ...
      ...
      ...
      ...
      ...
      ...
      ...
      ...
      ...
      End of description
      ''');
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Row 2 UI'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('Search Page'),
                onPressed: () {
                  Navigator.pushNamed(context, '/searchPage');
                },
              ),
              RaisedButton(
                child: Text('Category Page'),
                onPressed: () {
                  Navigator.pushNamed(context, '/categoryPage');
                },
              ),
              RaisedButton(
                child: Text('Activity Page'),
                onPressed: () {
                  // Navigator.pushNamed(context, '/activityPage');
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (__) => new ActivityPage(activity: a)));
                },
              ),
            ],
          )),
    );
  }
}