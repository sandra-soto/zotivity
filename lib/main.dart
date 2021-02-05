import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'database.dart';

import './pages/HomePage.dart';
import './pages/SearchPage.dart';
import './pages/CategoryPage.dart';
import './pages/ActivityPage.dart';
import './models/Activity.dart';



void main() async{
  /* DB STUFF*/
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseProvider db = DatabaseProvider.db;

  var fido = Dog(
    id: 1,
    name: 'Fido',
    age: 36,
  );
  // this will delete any dogs added, remove this line to keep dogs on app close/open
  db.deleteAllDogs();
  List<Dog> dogs = await db.dogs();
  dogs.forEach((element) => print(element)); // should not print anything since all dogs were deleted
  print("before ^^^^ ======================== after vvvvv");
  db.insertDog(fido);
  dogs = await db.dogs();
  dogs.forEach((element) => print(element));
  /* DB STUFF END*/

  Activity a = Activity(
      "Take a Walk",
      "https://www.readytowakeup.biz/wp-content/uploads/2017/03/161018141431-silicon-valley-walk-stock-780x439.jpg",
      "outdoors",
      30,
      '''Description for Taking A Walk
      Simulating a very long description
      This should be scrollable
      ...
      ...
      ...
      ...
      ...
      ...
      ...
      ...
      ...
      ...
      ...
      ...
      End of description
      ''');

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomePage(),
      '/searchPage': (context) => SearchPage(),
    },
  ));
}



// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Startup Name Generator',
//       theme: ThemeData(
//         primaryColor: Colors.black,
//       ),
//       home: RandomWords(),
//     );
//   }
// }
//
// class RandomWordsState extends State<RandomWords> {
//   final _suggestions = <WordPair>[];
//   final _saved = Set<WordPair>();
//   final _biggerFont = const TextStyle(fontSize: 18.0);
//
//   Widget _buildSuggestions() {
//     return ListView.builder(
//         padding: const EdgeInsets.all(16.0),
//         itemBuilder: /*1*/ (context, i) {
//           if (i.isOdd) return Divider(); /*2*/
//
//           final index = i ~/ 2; /*3*/
//           if (index >= _suggestions.length) {
//             _suggestions.addAll(generateWordPairs().take(10)); /*4*/
//           }
//           return _buildRow(_suggestions[index]);
//         });
//   }
//
//   Widget _buildRow(WordPair pair) {
//     final alreadySaved = _saved.contains(pair);
//
//     return ListTile(
//       title: Text(
//         pair.asPascalCase,
//         style: _biggerFont,
//       ),
//       trailing: Icon(
//         alreadySaved? Icons.favorite : Icons.favorite_border,
//         color: alreadySaved ? Colors.red : null,
//       ),
//       onTap: () {
//         setState(() {
//           if (alreadySaved) {
//             _saved.remove(pair);
//           }
//           else {
//             _saved.add(pair);
//           }
//         });
//       },
//     );
//   }
//
//   void _pushSaved() {
//     Navigator.of(context).push(
//       MaterialPageRoute<void>(
//         // NEW lines from here...
//         builder: (BuildContext context) {
//           final tiles = _saved.map(
//             (WordPair pair) {
//               return ListTile(
//                 title: Text(
//                   pair.asPascalCase,
//                   style: _biggerFont,
//                 ),
//               );
//             },
//           );
//           final divided = ListTile.divideTiles(
//             context: context,
//             tiles: tiles,
//           ).toList();
//
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Saved Suggestions'),
//             ),
//             body: ListView(children: divided),
//           );
//         }, // ...to here.
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Startup Name Generator'),
//         actions: [
//           IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
//         ],
//       ),
//       body: _buildSuggestions(),
//     );
//   }
// }
//
// class RandomWords extends StatefulWidget {
//   @override
//   RandomWordsState createState() => new RandomWordsState();
// }
