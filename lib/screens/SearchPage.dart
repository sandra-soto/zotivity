import 'package:flutter/material.dart';
import 'package:zotivity/models/activityCategory.dart';
import '../models/Activity.dart';
import './CategoryPage.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Activity exercise1 = Activity(
      "Take a Walk",
      ActivityCategory.exercise,
      30, '''Description for Taking A Walk
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
      ''', "https://www.readytowakeup.biz/wp-content/uploads/2017/03/161018141431-silicon-valley-walk-stock-780x439.jpg",);
  Activity exercise2 = Activity(
      "Do Yoga",
      ActivityCategory.exercise,
      45, '''Description for doing Yoga
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
      ''',  "https://miro.medium.com/max/11630/0*C5Y8W-6e9OVIB3AM");
  Activity baking1 = Activity(
      "Bake Cookies",
      ActivityCategory.baking,
      60, '''Description for Baking Cookies
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
      ''', "https://images-gmi-pmc.edge-generalmills.com/e7b11c3e-d094-48ac-af35-67ccc8299b56.jpg");
  Activity baking2 = Activity(
      "Bake Cheesecake",
      ActivityCategory.baking,
      260, '''Description for Baking Cheesecake
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
      ''',  "https://hips.hearstapps.com/hmg-prod/images/full-no-bake-cheesecake-horizontal-jpg-1525208292.jpg");
  Activity baking3 = Activity(
      "Bake Biscuits",
      ActivityCategory.baking,
      20, '''Description for Baking Biscuits
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
      ''',      "https://www.joyofbaking.com/images/facebook/biscuits.jpg");
  Activity cooking1 = Activity(
      "Pan Fried Tofu",
      ActivityCategory.cooking,
      15, '''Description for Cooking Pan Fried Tofu
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
      ''',       "https://ifoodreal.com/wp-content/uploads/2019/01/FG-crispy-pan-fried-tofu.jpg",);
  Activity cooking2 = Activity(
      "Kimchi Fried Rice",
      ActivityCategory.cooking,
      10, '''Description for Cooking Kimchi Fried Rice
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
      ''',       "https://www.maangchi.com/wp-content/uploads/2008/03/fried-rice.jpg");
  Activity cooking3 = Activity(
      "Fried Chicken",
      ActivityCategory.cooking,
      25, '''Description for Cooking Korean Fried Chicken
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
      ''',       "https://i2.wp.com/seonkyounglongest.com/wp-content/uploads/2017/12/Korean-Fried-Chicken-03.jpg?fit=1300%2C730&ssl=1",);
  Activity cooking4 = Activity(
      "Roasted Potatoes",
      ActivityCategory.cooking,
      30, '''Description for Cooking Roasted Potatoes
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
      ''',       "https://images-gmi-pmc.edge-generalmills.com/85695489-a0c9-41b6-b926-f8b4d3620f5e.jpg");
  Activity exercise3 = Activity(
      "Learn a Dance",
      ActivityCategory.exercise,
      60, '''Description for learning a dance
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
      ''',       "https://img.grouponcdn.com/deal/fsBGAB33wyPkpHBk5e76/gD-2048x1229/v1/t440x300.jpg");

  Widget build(BuildContext context) {
    var database = [
      exercise1,
      exercise2,
      baking1,
      baking2,
      baking3,
      cooking1,
      cooking2,
      cooking3,
      cooking4
    ];

    List getCategoryList(String categoryName) {
      var categoryList = [];
      for (int i = 0; i < database.length; i++) {
        if (database[i].getCategory().str == categoryName) {
          categoryList.add(database[i]);
        }
      }
      return categoryList;
    }

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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Categories:",
                style: TextStyle(fontSize: 28),
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (__) => new CategoryPage(
                            categoryName: ActivityCategory.exercise,
                            categoryList: getCategoryList("exercise"))));
              },
              child: Text("Exercise"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (__) => new CategoryPage(
                            categoryName: ActivityCategory.baking,
                            categoryList: getCategoryList("baking"))));
              },
              child: Text("Baking"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (__) => new CategoryPage(
                            categoryName: ActivityCategory.cooking,
                            categoryList: getCategoryList("cooking"))));
              },
              child: Text("Cooking"),
            ),
          ],
        ),
      ),
    );
  }
}
