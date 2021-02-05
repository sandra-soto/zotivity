import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
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
                  Navigator.pushNamed(context, '/activityPage');
                },
              ),
            ],
          )),
    );
  }
}