import 'package:flutter/material.dart';
import 'package:zotivity/screens/CategoryPage.dart';
import '../models/Activity.dart';

class ActivityPage extends StatefulWidget {
  @override
  Activity activity;

  ActivityPage({this.activity});

  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity: " + widget.activity.getName()),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: [
            Image(
              image: NetworkImage(widget.activity.getImgLink()),
              width: screenSize.width,
              height: (2 / 5) * screenSize.height,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                widget.activity.getName(),
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text("Time required: " +
                  widget.activity.getTime().toString() +
                  " minutes"),
            ),
            Container(
              child: SingleChildScrollView(
                child: Text(
                  widget.activity.getDescription(),
                  textAlign: TextAlign.center,
                ),
              ),
              width: double.infinity,
              height: (1 / 5) * screenSize.height,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),
            RaisedButton(
              child: Text("Complete Activity"),
              onPressed: () {
                print("Activity '" + widget.activity.getName() + "' completed.");
              },
            ),
          ],
        ),
      ),
    );
  }
}
