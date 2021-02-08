import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/widgets.dart';
import 'package:zotivity/screens/activity_preferences.dart';
import 'dart:async';
import 'database.dart';
import 'screens/profile_creation.dart';


void main() async{
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zotivity',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: ProfileCreation(),
      // home: ActivityPreferences(),
    );
  }
}
