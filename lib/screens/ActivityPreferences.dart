import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:zotivity/backend/firebase.dart';
import 'package:zotivity/backend/globals.dart';
import 'package:zotivity/models/activityCategory.dart';
import 'package:zotivity/models/BodyFocus.dart';
import 'package:zotivity/models/Equipment.dart';
import 'package:zotivity/models/checkboxFormField.dart';
import '../models/ZotUser.dart';
import 'SearchPage.dart';
import 'package:numberpicker/numberpicker.dart';


class ActivityPreferencesState extends State<ActivityPreferences> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Widget> listEquipment() {
    List<Widget> list = List<Widget>.empty(growable: true);

    for (var e in Equipment.values) {
      list.add(
        CheckboxFormField(
          title: Text(
            e.formatString(),
              style: Theme.of(context).textTheme.bodyText1,
          ),
          onSaved: (bool value) {
            if (value) {
              widget.prevInfo.addEquipment(e);
            }
          },
        )
      );
    }

    return list;
  }

  List<Widget> listBodyParts() {
    List<Widget> list = List<Widget>.empty(growable: true);

    for (var b in BodyFocus.values) {
      list.add(
        CheckboxFormField(
          title: Text(
            b.str,
              style: Theme.of(context).textTheme.bodyText1,
          ),
          onSaved: (bool value) {
            widget.prevInfo.setFocus(b, value);
          },
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
          CheckboxFormField(
            title: Text(
              ZotUser.TIME_MORN,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onSaved: (bool value) {
              widget.prevInfo.setWindow(ZotUser.TIME_MORN, value);
            },
          ),
          CheckboxFormField(
            title: Text(
              ZotUser.TIME_NOON,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onSaved: (bool value) {
              widget.prevInfo.setWindow(ZotUser.TIME_NOON, value);
            },
          ),
          CheckboxFormField(
            title: Text(
              ZotUser.TIME_NIGHT,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onSaved: (bool value) {
              widget.prevInfo.setWindow(ZotUser.TIME_NIGHT, value);
            },
          )
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
          CheckboxFormField(
            title: Text(
              "At the gym",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onSaved: (bool value) {
              widget.prevInfo.setInterest(ActivityCategory.gym, value);
            },
          ),
          CheckboxFormField(
            title: Text(
              "Indoors, within my home",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onSaved: (bool value) {
              widget.prevInfo.setInterest(ActivityCategory.indoor, value);
            },
          ),
          CheckboxFormField(
            title: Text(
              "Outdoors, around my neighborhood",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onSaved: (bool value) {
              widget.prevInfo.setInterest(ActivityCategory.outdoor, value);
            },
          )
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
            "Select the equipment that you have access to",
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
                widget.prevInfo.setExperience(value);
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
                widget.prevInfo.setExperience(value);
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
                widget.prevInfo.setExperience(value);
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
                  // print("changed to ");
                  // print(value);
                  widget.prevInfo.setIntensity(value);
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
                  // print("changed to ");
                  // print(value);
                  widget.prevInfo.setRoutineLen(value);
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return SearchPage();

                          },
                        ),
                      );
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

    currentUser = widget.prevInfo;
    print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    print(currentUser.toJson());

    // turning the user into a stringified JSON object, with their email as the key
    // currentUserEmail is from globals.dart and assigned in Login.dart on the _signInButton
    localStorage.setString(currentUserEmail, jsonEncode(currentUser.toJson()));


    //printAllActivities();
  }
}

class ActivityPreferences extends StatefulWidget {
  final ZotUser prevInfo; 

  ActivityPreferences(this.prevInfo);

  @override
  ActivityPreferencesState createState() => new ActivityPreferencesState();
}
