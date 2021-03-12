import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zotivity/backend/mongo.dart';
import '../models/Activity.dart';
import '../models/activityCategory.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zotivity/backend/globals.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class ActivityPage extends StatefulWidget {
  final Future<Activity> futureActivity;
  ActivityPage({this.futureActivity});

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  createVidWidget(activitySnap) {
    return YoutubePlayer(
      controller: YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(activitySnap.data.getResources()),
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: true,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      ),
      liveUIColor: Theme.of(context).accentColor,
    );
  }
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
    var catIcons = [Icons.home, Icons.cloud, Icons.sports_outlined];
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
                          catIcons[activitySnap.data.getCategory().index],
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                        child: IconButton(
                          icon: Icon(
                            currentZotUser.getGoodRecs().contains(activitySnap.data.getTitle())? Icons.star : Icons.star_outline,
                            color: Theme.of(context).accentColor,
                          ),
                          tooltip: 'Add activity to favorites',
                          onPressed: () {
                            setState(() {
                              if (currentZotUser.getGoodRecs().contains(activitySnap.data.getTitle())) {
                                currentZotUser.removeGoodRec(activitySnap.data.getTitle());
                              }
                              else {
                                currentZotUser.addGoodRec(activitySnap.data.getTitle());
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
                    child: Text(
                      activitySnap.data.getDescription(),
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Visibility(
                    visible: activitySnap.data.getResources().contains("youtube"),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: activitySnap.data.getResources().contains("youtube")? createVidWidget(activitySnap): 
                                                                                  Center(child: Text("shouldn't show")),
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      child: Text("Complete Activity"),
                      onPressed: () {
                        print("Activity '" +
                            activitySnap.data.getTitle() +
                            "' completed.");
                      },
                    ),
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
