import 'package:flutter/material.dart';
import 'package:zotivity/backend/firebase.dart';
import 'package:zotivity/models/activityCategory.dart';
import './CategoryPage.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Page"),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(100),
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Categories:",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (__) => new CategoryPage(
                            categoryName: ActivityCategory.indoor,
                            futureActivityList:
                                getActivitiesByCategory("indoor"))));
              },
              child: Text("Indoor"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (__) => new CategoryPage(
                            categoryName: ActivityCategory.outdoor,
                            futureActivityList:
                                getActivitiesByCategory("outdoor"))));
              },
              child: Text("Outdoor"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (__) => new CategoryPage(
                            categoryName: ActivityCategory.gym,
                            futureActivityList:
                                getActivitiesByCategory("gym"))));
              },
              child: Text("Gym"),
            ),
          ],
        ),
      ),
    );
  }
}
