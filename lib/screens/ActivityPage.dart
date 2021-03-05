import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/Activity.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:zotivity/backend/globals.dart';

class ActivityPage extends StatefulWidget {
  final Future<Activity> futureActivity;
  ActivityPage({this.futureActivity});

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  buildTime(time, reps){
    if(time != "0") {
      return Padding(
        padding: EdgeInsets.only(bottom: 30.0, left: 30),
        child: Text(
          time + " minutes",
          textAlign: TextAlign.left,
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(bottom: 30.0, left: 30),
        child: Text(
          reps + " reps",
          textAlign: TextAlign.left,
        ),

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
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(activitySnap.data.getTitle()),
          ),
          body: SingleChildScrollView (
            child: Container(
              child: Column(
                children: [
                  Image(
                    image: NetworkImage(activitySnap.data.getImgLink()),
                    width: screenSize.width,
                    height: (2 / 5) * screenSize.height,
                  ),
                  Row(
                    children: [
                      Expanded (
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 5, top:10, left: 20),
                              child: Text(
                                activitySnap.data.getTitle(),
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ),
                            buildTime(activitySnap.data.getTime().toString(), activitySnap.data.getReps().toString())
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.star_outline,
                            color: Theme.of(context).accentColor,
                          ),
                          tooltip: 'Add activity to favorites',
                          onPressed: () { // TODO: fill in outline & change icon 
                            print("test star");
                            currentUser.addGoodRec(activitySnap.data.getid());  // TODO: make sure this works & got right data
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                        child: IconButton(
                          icon: Icon(
                            Icons.keyboard_control,
                            color: Theme.of(context).accentColor,
                          ),
                          tooltip: 'Activity resources',
                          onPressed: () {
                            print("test dots");
                            //launch(activitySnap.data.getResources());
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                        activitySnap.data.getDescription(),
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                        ),
                      )
                    ),
                    width: double.infinity,
                    height: (1 / 5) * screenSize.height,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                  ),
                  ElevatedButton(
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
          )
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
