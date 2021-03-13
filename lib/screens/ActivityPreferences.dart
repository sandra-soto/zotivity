import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:zotivity/backend/firebase.dart';
import 'package:zotivity/backend/globals.dart';
import 'package:zotivity/backend/mongo.dart';
import 'package:zotivity/models/activityCategory.dart';
import 'package:zotivity/models/BodyFocus.dart';
import 'package:zotivity/models/Equipment.dart';
import 'package:zotivity/models/checkboxFormField.dart';
import '../models/ZotUser.dart';
import 'package:zotivity/screens/HomePage.dart';
import 'package:numberpicker/numberpicker.dart';


class ActivityPreferencesState extends State<ActivityPreferences> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Widget> listEquipment() {
    List<Widget> list = List<Widget>.empty(growable: true);

    for (var e in Equipment.values) {
      if (e == Equipment.none) {
        continue;
      }

      list.add(
        CheckboxFormField(
          title: Text(
            e.formatString(),
              style: Theme.of(context).textTheme.bodyText1,
          ),
          onSaved: (bool value) {
            setState(() {
              if (value) {
                currentZotUser == null? widget.prevInfo.addEquipment(e):currentZotUser.addEquipment(e);
              }
              else {
                currentZotUser == null? widget.prevInfo.removeEquipment(e):currentZotUser.removeEquipment(e);
              }
            });
          },
          initialValue: currentZotUser == null? false:currentZotUser.getAccess().contains(e),
        )
      );
    }

    return list;
  }

  List<Widget> listBodyParts() {
    List<Widget> list = List<Widget>.empty(growable: true);

    for (var b in BodyFocus.values) {
      if (b == BodyFocus.none) {
        continue;
      }
 
      list.add(
        CheckboxFormField(
          title: Text(
            b.str,
              style: Theme.of(context).textTheme.bodyText1,
          ),
          onSaved: (bool value) {
            setState(() {
              currentZotUser == null? widget.prevInfo.setFocus(b, value):currentZotUser.setFocus(b, value);
            });
          },
          initialValue: currentZotUser == null? false:currentZotUser.getFocus()[b],
        )
      );
    }

    return list;
  }

  Widget _buildExerciseWindow() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "When do you prefer to exercise?",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Row(
            children: [
              Icon(Icons.wb_twighlight),
              Expanded(
                child: 
                  CheckboxFormField(
                    title: Text(
                      ZotUser.TIME_MORN,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    onSaved: (bool value) {
                      setState(() {
                        currentZotUser == null? widget.prevInfo.setWindow(ZotUser.TIME_MORN, value):currentZotUser.setWindow(ZotUser.TIME_MORN, value);
                      });
                    },
                    initialValue: currentZotUser == null? false:currentZotUser.getAvailWindow()[ZotUser.TIME_MORN],
                  ),
              )
            ],
          ),
          Row(
            children: [
              Icon(Icons.wb_sunny),
              Expanded(
                child: 
                  CheckboxFormField(
                    title: Text(
                      ZotUser.TIME_NOON,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    onSaved: (bool value) {
                      setState(() {
                        currentZotUser == null? widget.prevInfo.setWindow(ZotUser.TIME_NOON, value):currentZotUser.setWindow(ZotUser.TIME_NOON, value);
                      });
                    },
                    initialValue: currentZotUser == null? false:currentZotUser.getAvailWindow()[ZotUser.TIME_NOON],
                  ),
              )
            ],
          ),
          Row(
            children: [
              Icon(Icons.brightness_2_rounded),
              Expanded(
                child: 
                  CheckboxFormField(
                    title: Text(
                      ZotUser.TIME_NIGHT,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    onSaved: (bool value) {
                      setState(() {
                        currentZotUser == null? widget.prevInfo.setWindow(ZotUser.TIME_NIGHT, value):currentZotUser.setWindow(ZotUser.TIME_NIGHT, value);
                      });
                    },
                    initialValue: currentZotUser == null? false:currentZotUser.getAvailWindow()[ZotUser.TIME_NIGHT],
                  ),
              )
            ],
          ),
        ],
      )
    );
  }

  Widget _buildCategory() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Where do you prefer to exercise?",
              style: Theme.of(context).textTheme.bodyText2,
          ),
          Row(
            children: [
              Icon(Icons.sports_outlined),
              Expanded(
                child: CheckboxFormField(
                  title: Text(
                    "At the gym",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onSaved: (bool value) {
                    setState(() {
                        currentZotUser == null? widget.prevInfo.setInterest(ActivityCategory.gym, value):currentZotUser.setInterest(ActivityCategory.gym, value);
                    });
                  },
                  initialValue: currentZotUser == null? false:currentZotUser.getInterests()[ActivityCategory.gym],
                )
              )
            ]
          ),
          Row(
            children: [
              Icon(Icons.home),
              Expanded(
                child: CheckboxFormField(
                  title: Text(
                    "Indoors, within my home",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onSaved: (bool value) {
                    setState(() {
                        currentZotUser == null? widget.prevInfo.setInterest(ActivityCategory.indoor, value):currentZotUser.setInterest(ActivityCategory.indoor, value);
                    });
                  },
                  initialValue: currentZotUser == null? false:currentZotUser.getInterests()[ActivityCategory.indoor],
                ),
              )
            ]
          ),
          Row(
            children: [
              Icon(Icons.cloud),
              Expanded(
                child: CheckboxFormField(
                  title: Text(
                    "Outdoors, around my neighborhood",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onSaved: (bool value) {
                    setState(() {
                        currentZotUser == null? widget.prevInfo.setInterest(ActivityCategory.outdoor, value):currentZotUser.setInterest(ActivityCategory.outdoor, value);
                    });
                  },
                  initialValue: currentZotUser == null? false:currentZotUser.getInterests()[ActivityCategory.outdoor],
                )
              )
            ]
          ),
        ],
      )
    );
  }

  Widget _buildAccess() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What equipment do you have access to?",
              style: Theme.of(context).textTheme.bodyText2,
          ),
          Column (
            children: listEquipment(),
          )
        ],
      )
    );
  }

  Widget _buildFocus() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Which area(s) of your body do you want to focus on?",
              style: Theme.of(context).textTheme.bodyText2,
          ),
          Column (
            children: listBodyParts()
          )
        ],
      )
    );
  }

  Widget _buildExperience() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "How experienced are you with exercising?",
              style: Theme.of(context).textTheme.bodyText2,
          ),
          RadioListTile<int>(
            title: Text(
              "Beginner",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            activeColor: Theme.of(context).accentColor,
            value: 0,
            groupValue: widget.prevInfo.getExperience(),
            onChanged: (int value) {
              setState(() {
                currentZotUser == null? widget.prevInfo.setExperience(value):currentZotUser.setExperience(value);
              });
            },
            selected: widget.prevInfo.getExperience() == 0
          ),
          RadioListTile<int>(
            title: Text(
              "Intermediate",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            activeColor: Theme.of(context).accentColor,
            value: 1,
            groupValue: widget.prevInfo.getExperience(),
            onChanged: (int value) {
              setState(() {
                currentZotUser == null? widget.prevInfo.setExperience(value):currentZotUser.setExperience(value);
              });
            },
            selected: widget.prevInfo.getExperience() == 1
          ),
          RadioListTile<int>(
            title: Text(
              "Expert",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            activeColor: Theme.of(context).accentColor,
            value: 2,
            groupValue: widget.prevInfo.getExperience(),
            onChanged: (int value) {
              setState(() {
                currentZotUser == null? widget.prevInfo.setExperience(value):currentZotUser.setExperience(value);
              });
            },
            selected: widget.prevInfo.getExperience() == 2
          ),
        ],
      )
    );
  }

  Widget _buildIntensity() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "How often do you want to exercise each week?",
              style: Theme.of(context).textTheme.bodyText2,
          ),
          Align(
            alignment: Alignment.center,
            child: NumberPicker.integer(   //https://pub.dev/packages/numberpicker
              textStyle: Theme.of(context).textTheme.bodyText1,
              initialValue: widget.prevInfo.getIntensity(), 
              minValue: 1, 
              maxValue: 7, 
              onChanged: (num value) {
                setState(() {
                currentZotUser == null? widget.prevInfo.setIntensity(value):currentZotUser.setIntensity(value);
                });
              }
            ),
          )
        ],
      )
    );
  }

  Widget _buildRoutineLen() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "How many minutes do you want to spend exercising per day?",
              style: Theme.of(context).textTheme.bodyText2,
          ),
          Align(
            alignment: Alignment.center,
            child: NumberPicker.integer(   //https://pub.dev/packages/numberpicker
              textStyle: Theme.of(context).textTheme.bodyText1,
              initialValue: widget.prevInfo.getRoutineLen(), 
              minValue: 5, 
              maxValue: 120, 
              onChanged: (num value) {
                setState(() {
                currentZotUser == null? widget.prevInfo.setRoutineLen(value):currentZotUser.setRoutineLen(value);
                });
              }
            )
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(title: Text('Activity Preferences')),
      body: SingleChildScrollView(
        child: Container (
          padding: EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildExerciseWindow(),
                _buildCategory(),
                _buildAccess(),
                _buildFocus(),
                _buildExperience(),
                _buildIntensity(),
                _buildRoutineLen(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (!_formKey.currentState.validate()) {
                        return;
                      }

                      _formKey.currentState.save();
                      submitDB();
                      // going to category page

                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          HomePage()), (Route<dynamic> route) => false);
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          )
        )
      )
    );
  }


  void submitDB() async{

    currentZotUser = widget.prevInfo;
    updateMongoUser();

  }
}

class ActivityPreferences extends StatefulWidget {
  final ZotUser prevInfo; 

  ActivityPreferences(this.prevInfo);

  @override
  ActivityPreferencesState createState() => new ActivityPreferencesState();
}
