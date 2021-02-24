import 'package:flutter/material.dart';

class UserFeedback extends StatefulWidget {

  @override
  _UserFeedbackState createState() => _UserFeedbackState();
}

class _UserFeedbackState extends State<UserFeedback> {
// support function here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("activity feedback"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,

        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            onPressed: () {
              // navigate to home page WRITE HERE
            },
          )
        ],
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RawMaterialButton(onPressed: () {}, //keep recommendation
              elevation: 2.0,
              fillColor: Colors.lightGreen,
              child: Icon(
                Icons.thumb_up,
                color: Colors.white,
                size: 30.0,
              ),
              padding: EdgeInsets.all(50.0),
              shape: CircleBorder(),),

            RawMaterialButton(onPressed: () {}, //not recommend this activity again
              elevation: 2.0,
              fillColor: Colors.redAccent,
              child: Icon(
                Icons.thumb_down,
                color: Colors.white,
                size: 30.0,
              ),
              padding: EdgeInsets.all(50.0),
              shape: CircleBorder(),),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
