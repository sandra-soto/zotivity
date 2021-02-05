import 'package:flutter/material.dart';
import './ActivityPage.dart';

class CategoryPage extends StatefulWidget {
  @override
  String categoryName;
  var categoryList;
  CategoryPage({this.categoryName, this.categoryList});
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override

  Widget build(BuildContext context) {
    // var activityList = [a,b,c];
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Category: " + widget.categoryName),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: widget.categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image(
                    image: NetworkImage(widget.categoryList[index].getImgLink()),
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
                              widget.categoryList[index].getName(),
                              style: TextStyle(fontSize: 28),
                              textAlign: TextAlign.left,
                            ),
                            Text(widget.categoryList[index].getTime().toString() + " minutes"),
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
                                    builder: (__) => new ActivityPage(
                                        activity: widget.categoryList[index])));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
