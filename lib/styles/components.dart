import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zotivity/backend/calendarUtil.dart';
import 'package:zotivity/backend/firebase.dart';
import 'package:zotivity/backend/globals.dart';
import 'package:zotivity/backend/mongo.dart';
import 'package:zotivity/backend/recommend.dart';
import 'package:zotivity/screens/ActivityPreferences.dart';
import 'package:zotivity/screens/CalendarPage.dart';
import 'package:zotivity/screens/ProfileCreation.dart';
import 'package:zotivity/backend/sign_in.dart';
import 'package:zotivity/screens/RoutinePage.dart';
import '../models/Activity.dart';

import '../screens/Login.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Text(
                  'Zotivity',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 24
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text(
                  'Profile Creation Screen',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                onTap: ()  {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ActivityPreferences(currentZotUser);//ProfileCreation();
                        },
                      ),
                  );
                }
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.dumbbell),
                title: Text(
                  'Show Routine Notification',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                onTap: () async {
                  configureSelectNotificationSubject();
                  //await showNotification();
                  await scheduleRoutineNotif(23, DateTime.now().add(Duration(seconds: 2)));
                  Navigator.pop(context);
                }
              ),
              ListTile(
                  leading: FaIcon(FontAwesomeIcons.star),
                  title: Text(
                    'Test Calendar',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onTap: () async {
                    List<DateTime> calendarRecs = await getCalendarRecs();
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return CalendarPage(items: calendarRecs);
                        },
                      ),
                    );

                  }
              ),
              ListTile(
                  leading: FaIcon(FontAwesomeIcons.list),
                  title: Text(
                    'Get Routine Recommendation',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return RoutinePage(futureActivityList: getRoutineRecs());
                        },
                      ),
                    );
                  }
              ),
              ListTile(
                  leading: FaIcon(FontAwesomeIcons.list),
                  title: Text('CANCEL NOTIFS'),
                  onTap: () async {
                    getRoutineRecs();
                      Future<void> _cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }
  _cancelNotification();
                  }
              ),
              ListTile(
                  leading: FaIcon(FontAwesomeIcons.question),
                  title: Text(
                    'Test your function here - components.dart',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onTap: () async {


                  }
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                onTap: () async {
                  signOutGoogle().then((_) {
                    Navigator.pop(context);
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        LoginPage()), (Route<dynamic> route) => false);
                  });
                },
              ),
            ],
          ),
        );
  }
}