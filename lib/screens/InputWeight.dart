import 'package:flutter/material.dart';


class InputWeight extends StatelessWidget {
  TextEditingController textcontroller = TextEditingController();

  Future<String> _buildPopupDialog(BuildContext context) {
    return showDialog(context: context, builder:(context){
      return new AlertDialog(
        title: Text(
          'Enter Your Weight',
          style: Theme.of(context).textTheme.headline4,
        ),
        content:
        TextField(
          controller: textcontroller,
          cursorColor: Theme.of(context).accentColor,
          keyboardType: TextInputType.number,
        ),
        actions: <Widget>[
          new ElevatedButton(
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
        title: Text('Weight Log'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child:IconButton(
              icon: Icon(
                Icons.add_outlined,
                color: Theme.of(context).accentColor,
              ),
            // child: ElevatedButton(
            //   child: Text('Add an entry'),
              onPressed: () {
                _buildPopupDialog(context);
              },
            ),
          )
        ]
      ),
    );
  }
}

