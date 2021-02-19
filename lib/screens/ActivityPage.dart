import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/Activity.dart';

class ActivityPage extends StatefulWidget {
  final Future<Activity> futureActivity;
  ActivityPage({this.futureActivity});

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  Widget buildActivity() {
    var screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
      future: widget.futureActivity,
      builder: (context, activitySnap) {
        if(activitySnap.data == null){
          return Container();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("Activity: " + activitySnap.data.getTitle()),
            backgroundColor: Colors.blue,
          ),
          body: Container(
            child: Column(
              children: [
                Image(
                  image: NetworkImage(activitySnap.data.getImgLink()),
                  width: screenSize.width,
                  height: (2 / 5) * screenSize.height,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    activitySnap.data.getTitle(),
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Text("Time required: " +
                      activitySnap.data.getTime().toString() +
                      " minutes"),
                ),
                Container(
                  child: SingleChildScrollView(
                    child: Text(
                      activitySnap.data.toString(),
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
                    print("Activity '" +
                        activitySnap.data.getTitle() +
                        "' completed.");
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildActivity(),
    );
  }
}
