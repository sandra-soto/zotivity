import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zotivity/backend/globals.dart';
import 'package:zotivity/screens/ProfileCreation.dart';
import 'package:zotivity/backend/sign_in.dart';

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
                  color: Colors.blue,
                ),
                child: Text(
                  'Zotivity',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              onTap: ()  {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ProfileCreation();
                      },
                    ),
                );
              }),
              ListTile(

                leading: FaIcon(FontAwesomeIcons.dumbbell),
                title: Text('Show Routine Notification'),
                onTap: () async {
                  configureSelectNotificationSubject();
                  //await showNotification();
                  await showNotification();
                  Navigator.pop(context);
              }
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () async {
                  signOutGoogle().then((_) {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ),
                    );
                  });
                },
              ),
            ],
          ),
        );
  }
}