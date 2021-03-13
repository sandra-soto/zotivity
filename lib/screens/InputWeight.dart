import 'package:flutter/material.dart';

void main() => runApp(
  MyApp(),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  TextEditingController textcontroller = TextEditingController();

  Future<String> _buildPopupDialog(BuildContext context) {
    return showDialog(context: context, builder:(context){
      return new AlertDialog(
        title: const Text('Enter Your Weight'),
        content:
        TextField(
          controller: textcontroller,
        ),
        actions: <Widget>[
          new FlatButton(
            child: Text('Submit'),
            onPressed: () {
              Navigator.of(context).pop(textcontroller.text.toString());
            },
          ),
        ],
      );

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Your Current Weight'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: RaisedButton(
          child: Text(
            'Click to enter your weight',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Colors.blue,
          onPressed: () {
            _buildPopupDialog(context);
          },
        ),
      ),
    );
  }
}

