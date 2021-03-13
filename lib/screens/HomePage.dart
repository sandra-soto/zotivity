import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zotivity/backend/globals.dart';
import 'package:zotivity/backend/recommend.dart';
import 'package:zotivity/models/activityCategory.dart';
import 'package:zotivity/screens/CategoryPage.dart';
import 'package:zotivity/styles/components.dart';
import '../models/Activity.dart';
import './ActivityPage.dart';
import './GraphPage.dart';

import '../models/BodyFocus.dart';
import '../models/Equipment.dart';
import 'RoutinePage.dart';
import 'SearchPage.dart';
import '../backend/firebase.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zotivity'),
        // backgroundColor: Colors.blue,
      ),
      drawer:CustomDrawer(),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left:15.0, bottom:10.0),
            child: Row(
                children: [
                  Text("${currentZotUser.getFirstName()}'s weight progress",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.white),)]),
          ),
          GraphPage(),
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(15),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                CardWidget(title: "My Routine", redirect: RoutinePage(futureActivityList:getRoutineRecs()), icon: FontAwesomeIcons.running),
                CardWidget(title: "Explore exercises", redirect: SearchPage(), icon:FontAwesomeIcons.search),
                CardWidget(title: "Log my weight", redirect: SearchPage(), icon:FontAwesomeIcons.balanceScale),
                CardWidget(title: "See my data", redirect: SearchPage(), icon: FontAwesomeIcons.list),
              ],
            )
          )
      ])
    );
  }
}


class CardWidget extends StatelessWidget {
  final String title;
  final Widget redirect;
  final IconData icon;
  const CardWidget({Key key, @required this.title,  @required this.redirect, @required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Card(
        color: const Color.fromRGBO(27, 61, 109, 1),
        child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return this.redirect;
                  },
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:  <Widget>[
                Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, left:25.0, right: 25.0),
                      child: Text(this.title, style:TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),),
                    ),
                ) ,
                Container(
                  alignment:Alignment.bottomLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left:27.0, right: 27.0, bottom: 15.0),
                      child:FaIcon(icon, color: Colors.amber, size:40.0)
                    ),
                  ),
                ])
            )
        )
    );
  }
}
