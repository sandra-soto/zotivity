import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/Activity.dart';
import '../models/activityCategory.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zotivity/backend/globals.dart';

class ActivityPage extends StatefulWidget {
  final Future<Activity> futureActivity;
  ActivityPage({this.futureActivity});

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  buildTime(time, reps) {
    return Container (
        child: Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 16)),
            Icon(
              time != 0? Icons.timer: Icons.format_list_numbered,
              color: Theme.of(context).accentColor,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                time != 0? time.toString() + " mins": reps.toString() + " reps"
              ),
            ),
          ],
      )
    );
  }

  Widget buildActivity() {
    var cat_icons = {
      ActivityCategory.indoor: Icons.home, 
      ActivityCategory.outdoor: Icons.cloud, 
      ActivityCategory.gym: Icons.sports_outlined
    };
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
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
                    child: Image(
                      image: NetworkImage(activitySnap.data.getImgLink()),
                      width: screenSize.width,
                      height: (2 / 5) * screenSize.height,
                    )
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
                            buildTime(activitySnap.data.getTime(), activitySnap.data.getReps())
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                        child: Icon(
                          cat_icons[activitySnap.data.getCategory()],
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                        child: IconButton(
                          icon: Icon(
                            currentUser.getGoodRecs().contains(activitySnap.data.getTitle())? Icons.star : Icons.star_outline,
                            color: Theme.of(context).accentColor,
                          ),
                          tooltip: 'Add activity to favorites',
                          onPressed: () {
                            setState(() {
                              if (currentUser.getGoodRecs().contains(activitySnap.data.getTitle())) {
                                currentUser.removeGoodRec(activitySnap.data.getTitle());
                              }
                              else {
                                currentUser.addGoodRec(activitySnap.data.getTitle());
                              }  
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.keyboard_control,
                            color: Theme.of(context).accentColor,
                          ),
                          tooltip: 'Activity resources',
                          onPressed: () {
                            launch(activitySnap.data.getResources());
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: SingleChildScrollView(
                        child: Text(
                          activitySnap.data.getDescription(),
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center,
                        ),
                    ),
                    width: double.infinity,
                    height: (1 / 5) * screenSize.height,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
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
