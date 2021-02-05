import 'package:flutter/material.dart';
import '../models/Activity.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Activity _activity = Activity(
      "Take a Walk",
      "https://www.readytowakeup.biz/wp-content/uploads/2017/03/161018141431-silicon-valley-walk-stock-780x439.jpg",
      "outdoors",
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
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity Page"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: [
            Image(
              image: NetworkImage(_activity.getImgLink()),
              width: screenSize.width,
              height: (2 / 5) * screenSize.height,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                _activity.getName(),
                style: TextStyle(fontSize: 28),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text("Time required: " +
                  _activity.getTime().toString() +
                  " minutes"),
            ),
            Container(
              child: SingleChildScrollView(
                child: Text(
                  _activity.getDescription(),
                  textAlign: TextAlign.center,
                ),
              ),
              width: double.infinity,
              height: (1/5)*screenSize.height,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),
            RaisedButton(
              child: Text("Complete Activity"),
              onPressed: () {
                print("Activity '" + _activity.getName() + "' completed.");
              },
            ),
          ],
        ),
      ),
    );
  }
}
