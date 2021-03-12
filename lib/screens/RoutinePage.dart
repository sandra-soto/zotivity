import 'package:flutter/material.dart';
import 'package:zotivity/backend/firebase.dart';
import './ActivityPage.dart';
import 'package:zotivity/models/activityCategory.dart';
import '../models/Activity.dart';

// https://medium.com/nonstopio/flutter-future-builder-with-list-view-builder-d7212314e8c9

class RoutinePage extends StatefulWidget {
  final Future<List<Activity>> futureActivityList;
  RoutinePage({this.futureActivityList});

  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  buildTime(time, reps){
    if(time != "0") {
      return Text(time +
          " minutes");
    } else {
      return Text(reps +
          " reps");
    }
  }
  Widget buildRoutinePage() {
    var screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
      future: widget.futureActivityList,
      builder: (context, activityListSnap) {
        if (activityListSnap.data == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Your routine"),
            ),
          );
        }
        return Scaffold(
            appBar: AppBar(
              title: Text("Your routine"),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: activityListSnap.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Image(
                          image: NetworkImage(
                              activityListSnap.data[index].getImgLink()),
                          width: screenSize.width,
                          height: 200,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 60.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                children: [
                                  Text(
                                    activityListSnap.data[index].getTitle(),
                                    style: Theme.of(context).textTheme.headline1,
                                    textAlign: TextAlign.left,
                                  ),
                                  buildTime(activityListSnap.data[index].getTime().toString(),
                                      activityListSnap.data[index].getReps().toString()),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: ElevatedButton(
                                child: Text("Let's Do It!"),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (__) => new ActivityPage(
                                              futureActivity: getActivityByName(
                                                  activityListSnap.data[index]
                                                      .getTitle()))));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildRoutinePage(),
    );
  }
}
