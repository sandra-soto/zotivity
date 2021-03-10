import 'package:flutter/material.dart';
import 'package:zotivity/backend/firebase.dart';
import './ActivityPage.dart';
import 'package:zotivity/models/activityCategory.dart';
import '../models/Activity.dart';

// https://medium.com/nonstopio/flutter-future-builder-with-list-view-builder-d7212314e8c9

class CategoryPage extends StatefulWidget {
  final String categoryName;
  final Future<List<Activity>> futureActivityList;
  CategoryPage({this.categoryName, this.futureActivityList});

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  buildDesc(time, reps) {
    return Container (
        // color: const Color.fromRGBO(27, 61, 109, 1),
        child: Row(
          children: [
            Icon(
              time != 0? Icons.timer: Icons.format_list_numbered,
              color: Theme.of(context).accentColor,
            ),
            Text(
              time != 0? time.toString() + " mins": reps.toString() + " reps"
            ),
          ],
      )
    );
  }
  Widget buildCategoryPage() {
    var screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
      future: widget.futureActivityList,
      builder: (context, activityListSnap) {
        if (activityListSnap.data == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.categoryName),
              backgroundColor: Colors.blue,
            ),
          );
        }
        return Scaffold(
            appBar: AppBar(
// <<<<<<< HEAD
//               title: Text("Category: " + widget.categoryName.str),
// =======
              title: Text(widget.categoryName),
              backgroundColor: Colors.blue,
// >>>>>>> kelson
            ),
            body: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              itemCount: activityListSnap.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // color: const Color.fromRGBO(144, 149, 154, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Image(
                            image: NetworkImage(
                                activityListSnap.data[index].getImgLink()),
                            width: screenSize.width,
                            height: 200,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // color: const Color.fromRGBO(144, 149, 154, 0.75),
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
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
                                    buildDesc(activityListSnap.data[index].getTime(),
                                            activityListSnap.data[index].getReps()),
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 40.0)
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
      body: buildCategoryPage(),
    );
  }
}
