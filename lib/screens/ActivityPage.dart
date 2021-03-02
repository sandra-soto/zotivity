import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/Activity.dart';
import 'package:zotivity/screens/UserFeedback.dart';

class ActivityPage extends StatefulWidget {
  final Future<Activity> futureActivity;
  ActivityPage({Key key, this.futureActivity}): super(key: key);
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  buildTime(time, reps){
    if(time != "0") {
      return Padding(
        padding: EdgeInsets.only(bottom: 30.0),
        child: Text("Time required: " +
            time +
            " minutes"),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(bottom: 30.0),
        child: Text("Reps: " +
            reps +
            " reps"),
      );
    }
  }
  Widget buildActivity() {
    var screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
      future: widget.futureActivity,
      builder: (context, activitySnap) {
        if (activitySnap.data == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Activity Not Found."),
              backgroundColor: Colors.blue,
            ),
          );
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
                buildTime(activitySnap.data.getTime().toString(), activitySnap.data.getReps().toString()),
                // Padding(
                //   padding: EdgeInsets.only(bottom: 30.0),
                //   child: Text("Time required: " +
                //       activitySnap.data.getTime().toString() +
                //       " minutes"),
                // ),
                Container(
                  child: SingleChildScrollView(
                    child: Text(
                      activitySnap.data.getDescription() + "\n\n\n\nResource Link: " + activitySnap.data.getResources(),
                      // activitySnap.data.toString(),
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
                   // Navigator.push(
                      //context,
                      //MaterialPageRoute(builder: (context) => UserFeedback()),
                    //);
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
