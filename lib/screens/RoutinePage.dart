import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/Activity.dart';


class RoutinePage extends StatelessWidget {
  final List<Activity> items;

  RoutinePage({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Your Routine';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: items.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
              title: Text(item.title),
              subtitle: Text(jsonEncode(item.toMap())),
            );
          },
        ),
      ),
    );
  }
}



