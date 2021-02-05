import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  var _num = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Page"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(100),
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            Text(_num.toString()),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _num = _num + 1;
                });
              },
              child: Text("Click!"),
            ),
          ],
        ),
      ),
    );
  }
}

// class SearchPage extends StatefulWidget {
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }
//
// class _SearchPageState extends State<SearchPage> {
//   @override
//   var _num = 0;
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Search Page"),
//         backgroundColor: Colors.blue,
//       ),
//       body: Center(
//         child: RaisedButton(
//           onPressed: () {
//             // Navigator.pop(context);
//             _num = _num + 1;
//             print(_num);
//           },
//           child: Text('Click!'),
//         ),
//       ),
//     );
//   }
// }
