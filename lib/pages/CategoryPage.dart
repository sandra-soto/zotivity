import 'package:flutter/material.dart';
import '../models/Activity.dart';
import './ActivityPage.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Activity a = Activity(
      "Take a Walk",
      "https://www.readytowakeup.biz/wp-content/uploads/2017/03/161018141431-silicon-valley-walk-stock-780x439.jpg",
      "exercise",
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
      ''');
  Activity b = Activity(
      "Bake Cookies",
      "https://images-gmi-pmc.edge-generalmills.com/e7b11c3e-d094-48ac-af35-67ccc8299b56.jpg",
      "baking",
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
      ''');
  Activity c = Activity(
      "Do Yoga",
      "https://miro.medium.com/max/11630/0*C5Y8W-6e9OVIB3AM",
      "exercise",
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
      ''');


  // activityList.add(a);
  // activityList.add(b);
  // activityList.add(c);

  Widget build(BuildContext context) {
    // var activityList = [a,b,c];
    // for(var i = 0; i <activityList.length; i++){
    //   print(activityList[i]);
    // }
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Page"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Image(
                image: NetworkImage(a.getImgLink()),
                width: screenSize.width,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      children: [
                        Text(
                          a.getName(),
                          style: TextStyle(fontSize: 28),
                          textAlign: TextAlign.left,
                        ),
                        Text(a.getTime().toString() + " minutes"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: RaisedButton(
                      child: Text("Let's Do It!"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (__) =>
                                    new ActivityPage(activity: a)));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Image(
              image: NetworkImage(b.getImgLink()),
              width: screenSize.width,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      children: [
                        Text(
                          b.getName(),
                          style: TextStyle(fontSize: 28),
                          textAlign: TextAlign.left,
                        ),
                        Text(b.getTime().toString() + " minutes"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: RaisedButton(
                      child: Text("Let's Do It!"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (__) =>
                                    new ActivityPage(activity: b)));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Image(
              image: NetworkImage(c.getImgLink()),
              width: screenSize.width,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      children: [
                        Text(
                          c.getName(),
                          style: TextStyle(fontSize: 28),
                          textAlign: TextAlign.left,
                        ),
                        Text(c.getTime().toString() + " minutes"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: RaisedButton(
                      child: Text("Let's Do It!"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (__) =>
                                new ActivityPage(activity: c)));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
