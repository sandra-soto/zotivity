import 'package:flutter/material.dart';
import 'package:zotivity/backend/firebase.dart';
import 'package:zotivity/models/activityCategory.dart';
import 'package:zotivity/models/BodyFocus.dart';
import 'package:zotivity/models/Equipment.dart';
import './CategoryPage.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<bool> categorySelect = List.filled(ActivityCategory.values.length, false);
  List<bool> intensitySelect = List.filled(3, false);
  List<bool> focusSelect = List.filled(BodyFocus.values.length - 1, false);
  List<bool> equipSelect = List.filled(Equipment.values.length, false);
  bool matchAll = true;

  ElevatedButton _buildCatButton(ActivityCategory cat) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
      textStyle: TextStyle(
        fontWeight: categorySelect[cat.index] ? FontWeight.w800 : FontWeight.w400,
        fontSize: 16,
      ),
        primary: categorySelect[cat.index] ? Theme.of(context).accentColor : Colors.grey.shade400,
      ),
      onPressed: () {
        setState(() {
          categorySelect[cat.index] = !categorySelect[cat.index];
          if (matchAll) {
            for (var i = 0; i < categorySelect.length; i++) {
              if (i == cat.index)
                continue;
              categorySelect[i] = false;
            }
          }

        });
      },
      child: Text(cat.str),
    );
  }

  ElevatedButton _buildIntensityButton(int intensity) {
    String title = '';
    if (intensity == 0)
      title = "low";
    else if (intensity == 1)
      title = "medium";
    else 
      title = "high";

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
      textStyle: TextStyle(
        fontWeight: intensitySelect[intensity] ? FontWeight.w800 : FontWeight.w400,
        fontSize: 16,
      ),
        primary: intensitySelect[intensity] ? Theme.of(context).accentColor : Colors.grey.shade400,
      ),
      onPressed: () {
        setState(() {
          intensitySelect[intensity] = !intensitySelect[intensity];
          if (matchAll) {
            for (var i = 0; i < intensitySelect.length; i++) {
              if (i == intensity)
                continue;
              intensitySelect[i] = false;
            }
          }

        });
      },
      child: Text(title),
    );
  }

  ElevatedButton _buildBodyButton(BodyFocus focus) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
      textStyle: TextStyle(
        fontWeight: focusSelect[focus.index] ? FontWeight.w800 : FontWeight.w400,
        fontSize: 16,
      ),
        primary: focusSelect[focus.index] ? Theme.of(context).accentColor : Colors.grey.shade400,
      ),
      onPressed: () {
        setState(() {
          focusSelect[focus.index] = !focusSelect[focus.index];
          if (matchAll) {
            for (var i = 0; i < focusSelect.length; i++) {
              if (i == focus.index)
                continue;
              focusSelect[i] = false;
            }
          }

        });
      },
      child: Text(focus.str),
    );
  }

  ElevatedButton _buildEquipButton(Equipment equip) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
      textStyle: TextStyle(
        fontWeight: equipSelect[equip.index] ? FontWeight.w800 : FontWeight.w400,
        fontSize: 16,
      ),
        primary: equipSelect[equip.index] ? Theme.of(context).accentColor : Colors.grey.shade400,
      ),
      onPressed: () {
        setState(() {
          equipSelect[equip.index] = !equipSelect[equip.index];
          if (matchAll) {
            for (var i = 0; i < equipSelect.length; i++) {
              if (i == equip.index)
                continue;
              equipSelect[i] = false;
            }
          }

        });
      },
      child: Text(equip.formatString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Selection"),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        alignment: Alignment.topCenter,
        child:
        SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Filter Type", 
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                      fontWeight: matchAll ? FontWeight.w800 : FontWeight.w400,
                      fontSize: 16,
                    ),
                      primary: matchAll ? Theme.of(context).accentColor : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      if (matchAll)
                        return;
                      setState(() {
                        matchAll = !matchAll;
                        var i = 0;
                        for (; i < categorySelect.length; i++) {
                          categorySelect[i] = false;
                          intensitySelect[i] = false;
                          focusSelect[i] = false;
                          equipSelect[i] = false;
                        }
                        for (; i < focusSelect.length; i++) {
                          focusSelect[i] = false;
                          equipSelect[i] = false;
                        }
                        for (; i < equipSelect.length; i++) {
                          equipSelect[i] = false;
                        }
                      });
                    },
                    child: Text("Match All"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                      fontWeight: matchAll ? FontWeight.w400 : FontWeight.w800,
                      fontSize: 16,
                    ),
                      primary: matchAll ? Colors.grey.shade400 : Theme.of(context).accentColor,
                    ),
                    onPressed: () {
                      if (!matchAll)
                        return;
                      setState(() {
                        matchAll = !matchAll;
                        var i = 0;
                        for (; i < categorySelect.length; i++) {
                          categorySelect[i] = false;
                          intensitySelect[i] = false;
                          focusSelect[i] = false;
                          equipSelect[i] = false;
                        }
                        for (; i < focusSelect.length; i++) {
                          focusSelect[i] = false;
                          equipSelect[i] = false;
                        }
                        for (; i < equipSelect.length; i++) {
                          equipSelect[i] = false;
                        }
                      });
                    },
                    child: Text("Match Any"),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Categories",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCatButton(ActivityCategory.indoor),
                  _buildCatButton(ActivityCategory.outdoor),
                  _buildCatButton(ActivityCategory.gym),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Intensity",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildIntensityButton(0),
                  _buildIntensityButton(1),
                  _buildIntensityButton(2),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Body Focus",
                ),
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _buildBodyButton(BodyFocus.arms),
                    Padding(padding: const EdgeInsets.all(5.0),),
                    _buildBodyButton(BodyFocus.torso),
                    Padding(padding: const EdgeInsets.all(5.0),),
                    _buildBodyButton(BodyFocus.legs),
                    Padding(padding: const EdgeInsets.all(5.0),),
                    _buildBodyButton(BodyFocus.chest),
                    Padding(padding: const EdgeInsets.all(5.0),),
                    _buildBodyButton(BodyFocus.back),
                    Padding(padding: const EdgeInsets.all(5.0),),
                    _buildBodyButton(BodyFocus.full),
                    Padding(padding: const EdgeInsets.all(5.0),),
                    _buildBodyButton(BodyFocus.shoulders),
                    Padding(padding: const EdgeInsets.all(5.0),),
                    _buildBodyButton(BodyFocus.glutes),
                  ],
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Column(
              //       children: [
              //         _buildBodyButton(BodyFocus.arms),
              //         _buildBodyButton(BodyFocus.torso),
              //         _buildBodyButton(BodyFocus.legs),
              //       ],
              //     ),
              //     Column(
              //       children: [
              //         _buildBodyButton(BodyFocus.chest),
              //         _buildBodyButton(BodyFocus.back),
              //         _buildBodyButton(BodyFocus.full),
              //       ],
              //     ),
              //     Column(
              //       children: [
              //         _buildBodyButton(BodyFocus.shoulders),
              //         _buildBodyButton(BodyFocus.glutes),
              //       ],
              //     ),
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Equipment",
                ),
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _buildEquipButton(Equipment.bike),
                    Padding(padding: const EdgeInsets.all(5.0),),
                    _buildEquipButton(Equipment.machine),
                    Padding(padding: const EdgeInsets.all(5.0),),
                    _buildEquipButton(Equipment.pull_up_bar),
                    Padding(padding: const EdgeInsets.all(5.0),),
                    _buildEquipButton(Equipment.bench),
                    Padding(padding: const EdgeInsets.all(5.0),),
                    _buildEquipButton(Equipment.barbell),
                    Padding(padding: const EdgeInsets.all(5.0),),
                    _buildEquipButton(Equipment.resistance_bands),
                    Padding(padding: const EdgeInsets.all(5.0),),
                    _buildEquipButton(Equipment.yoga_mat),
                    Padding(padding: const EdgeInsets.all(5.0),),
                    _buildEquipButton(Equipment.dumbbells),
                    Padding(padding: const EdgeInsets.all(5.0),),
                    _buildEquipButton(Equipment.none),
                  ],
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Column(
              //       children: [
              //         _buildEquipButton(Equipment.bike),
              //         _buildEquipButton(Equipment.machine),
              //         _buildEquipButton(Equipment.pull_up_bar),
              //       ],
              //     ),
              //     Column(
              //       children: [
              //         _buildEquipButton(Equipment.bench),
              //         _buildEquipButton(Equipment.barbell),
              //         _buildEquipButton(Equipment.resistance_bands),
              //       ],
              //     ),
              //     Column(
              //       children: [
              //         _buildEquipButton(Equipment.yoga_mat),
              //         _buildEquipButton(Equipment.dumbbells),
              //         _buildEquipButton(Equipment.none),
              //       ],
              //     ),
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
              ),
              Container(
                margin: EdgeInsets.all(35),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (__) => new CategoryPage(
                                categoryName: "Search Results",
                                futureActivityList: getActivityList(matchAll, categorySelect, 
                                                                    intensitySelect, focusSelect, equipSelect))));
                  },
                  child: Text("Search"),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
