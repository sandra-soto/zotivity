import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zotivity/backend/firebase.dart';
import 'package:zotivity/backend/globals.dart';
import 'package:zotivity/models/activityCategory.dart';
import 'package:zotivity/models/BodyFocus.dart';
import 'package:zotivity/models/Equipment.dart';
import 'package:zotivity/models/checkboxFormField.dart';
import '../models/user.dart';
import '../backend/database.dart';
import 'SearchPage.dart';
import 'package:numberpicker/numberpicker.dart';


class ActivityPreferencesState extends State<ActivityPreferences> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildExerciseWindow() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "When do you prefer to exercise?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          CheckboxFormField(
            title: Text(
              User.TIME_MORN,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onSaved: (bool value) {
              widget.prevInfo.setWindow(User.TIME_MORN, value);
            },
          ),
          CheckboxFormField(
            title: Text(
              User.TIME_NOON,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onSaved: (bool value) {
              widget.prevInfo.setWindow(User.TIME_NOON, value);
            },
          ),
          CheckboxFormField(
            title: Text(
              User.TIME_NIGHT,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onSaved: (bool value) {
              widget.prevInfo.setWindow(User.TIME_NIGHT, value);
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          CheckboxFormField(
            title: Text(
              "At the gym",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onSaved: (bool value) {
              widget.prevInfo.setInterest(ActivityCategory.gym, value);
            },
          ),
          CheckboxFormField(
            title: Text(
              "Indoors, within my home",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onSaved: (bool value) {
              widget.prevInfo.setInterest(ActivityCategory.indoor, value);
            },
          ),
          CheckboxFormField(
            title: Text(
              "Outdoors, around my neighborhood",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          CheckboxFormField(
            title: Text(
              Equipment.bike.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onSaved: (bool value) {
              widget.prevInfo.addEquipment(Equipment.bike);
            },
          ),
          CheckboxFormField(
            title: Text(
              Equipment.dumbbells.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onSaved: (bool value) {
              widget.prevInfo.addEquipment(Equipment.dumbbells);
            },
          ),
          CheckboxFormField(
            title: Text(
              Equipment.resistance_bands.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onSaved: (bool value) {
              widget.prevInfo.addEquipment(Equipment.resistance_bands);
            },
          ),
          CheckboxFormField(
            title: Text(
              Equipment.pull_up_bar.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onSaved: (bool value) {
              widget.prevInfo.addEquipment(Equipment.pull_up_bar);
            },
          ),
          CheckboxFormField(
            title: Text(
              Equipment.yoga_mat.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onSaved: (bool value) {
              widget.prevInfo.addEquipment(Equipment.yoga_mat);
            },
          ),
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          CheckboxFormField(
            title: Text(
              BodyFocus.arms.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onSaved: (bool value) {
              widget.prevInfo.setFocus(BodyFocus.arms, value);
            },
          ),
          CheckboxFormField(
            title: Text(
              BodyFocus.chest.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onSaved: (bool value) {
              widget.prevInfo.setFocus(BodyFocus.chest, value);
            },
          ),
          CheckboxFormField(
            title: Text(
              BodyFocus.shoulders.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onSaved: (bool value) {
              widget.prevInfo.setFocus(BodyFocus.shoulders, value);
            },
          ),
          CheckboxFormField(
            title: Text(
              BodyFocus.back.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onSaved: (bool value) {
              widget.prevInfo.setFocus(BodyFocus.back, value);
            },
          ),
          CheckboxFormField(
            title: Text(
              BodyFocus.legs.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onSaved: (bool value) {
              widget.prevInfo.setFocus(BodyFocus.legs, value);
            },
          ),
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          RadioListTile<int>(
            title: const Text("Beginner"),
            value: 0,
            groupValue: -1,
            onChanged: (int value) {
              widget.prevInfo.setExperience(value);
            }
          ),
          RadioListTile<int>(
            title: const Text("Intermediate"),
            value: 1,
            groupValue: -1,
            onChanged: (int value) {
              widget.prevInfo.setExperience(value);
            }
          ),
          RadioListTile<int>(
            title: const Text("Expert"),
            value: 2,
            groupValue: -1,
            onChanged: (int value) {
              widget.prevInfo.setExperience(value);
            }
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          NumberPicker.integer(   //https://pub.dev/packages/numberpicker
            initialValue: 3, 
            minValue: 1, 
            maxValue: 7, 
            onChanged: (num value) {
              widget.prevInfo.setIntensity(value);
            }
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          NumberPicker.integer(   //https://pub.dev/packages/numberpicker
            initialValue: 30, 
            minValue: 5, 
            maxValue: 120, 
            onChanged: (num value) {
              widget.prevInfo.setRoutineLen(value);
            }
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

    //print(widget.prevInfo);
    //print(widget.prevInfo.interests);

    // currentUserId is the google ID
    widget.prevInfo.setId(currentUserId);
    //addUser(widget.prevInfo);
    currentUser = widget.prevInfo;
    print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    // after writing in a user, comment the line below and restart to see data persisted
    //await localInfo.writeUser(jsonEncode(currentUser.toMap()));
    await localInfo.readUser().then((value) => print(User.fromJson(jsonDecode(value))));


    //printAllActivities();
  }
}

class ActivityPreferences extends StatefulWidget {
  final User prevInfo; 

  ActivityPreferences(this.prevInfo);

  @override
  ActivityPreferencesState createState() => new ActivityPreferencesState();
}
