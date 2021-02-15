//import 'package:flutter/material.dart';
//import 'package:zotivity/models/activityCategory.dart';
//import 'package:zotivity/screens/CategoryPage.dart';
//import '../models/Activity.dart';
//import './ActivityPage.dart';
//
//class HomePage extends StatelessWidget {
//  Activity a = Activity(
//      "Take a Walk",
//      "https://www.readytowakeup.biz/wp-content/uploads/2017/03/161018141431-silicon-valley-walk-stock-780x439.jpg",
//      "exercise",
//      30, '''Description for Taking A Walk
//      Simulating a very long description
//      This should be scrollable
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      End of description
//      ''');
//  Activity b = Activity(
//      "Bake Cookies",
//      "https://images-gmi-pmc.edge-generalmills.com/e7b11c3e-d094-48ac-af35-67ccc8299b56.jpg",
//      "baking",
//      60, '''Description for Baking Cookies
//    Simulating a very long description
//      This should be scrollable
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      End of description
//      ''');
//  Activity c = Activity(
//      "Do Yoga",
//      "https://miro.medium.com/max/11630/0*C5Y8W-6e9OVIB3AM",
//      "exercise",
//      45, '''Description for doing Yoga
//    Simulating a very long description
//      This should be scrollable
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      ...
//      End of description
//      ''');
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Row 2 UI'),
//        backgroundColor: Colors.blue,
//      ),
//      body: Center(
//          child: Column(
//        children: <Widget>[
//          RaisedButton(
//            child: Text('Search Page'),
//            onPressed: () {
//              Navigator.pushNamed(context, '/searchPage');
//            },
//          ),
//          RaisedButton(
//            child: Text('Category Page'),
//            onPressed: () {
//              // Navigator.pushNamed(context, '/categoryPage');
//              Navigator.push(
//                  context,
//                  new MaterialPageRoute(
//                      builder: (__) => new CategoryPage(
//                        // Todo: change this later
//                          categoryName: ActivityCategory.exercise,
//                          categoryList: [a, b, c])));
//            },
//          ),
//          RaisedButton(
//            child: Text('Activity Page'),
//            onPressed: () {
//              // Navigator.pushNamed(context, '/activityPage');
//              Navigator.push(
//                  context,
//                  new MaterialPageRoute(
//                      builder: (__) => new ActivityPage(activity: a)));
//            },
//          ),
//        ],
//      )),
//    );
//  }
//}