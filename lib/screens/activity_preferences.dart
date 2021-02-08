import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/activity.dart';
import 'package:zotivity/models/activityCategory.dart';
import 'package:zotivity/models/checkboxFormField.dart';
import '../models/user.dart';

class ActivityPreferencesState extends State<ActivityPreferences> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<ActivityCategory> categories = Activity.getAllCategories();
  User _user = User();

  Widget _buildExercise() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CheckboxFormField(
            title: Text(
              "Exercise",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onSaved: (bool value) {
              _user.setInterest(categories[0], value);
            },
          )
        ],
      )
    );
  }

  Widget _buildCooking() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CheckboxFormField(
            title: Text(
              "Cooking",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onSaved: (bool value) {
              _user.setInterest(categories[1], value);
            },
          )
        ],
      )
    );
  }

  Widget _buildBaking() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CheckboxFormField(
            title: Text(
              "Baking",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            onSaved: (bool value) {
              _user.setInterest(categories[2], value);
            },
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
                _buildExercise(),
                _buildCooking(),
                _buildBaking(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        // Scaffold.of(context)
                        //     .showSnackBar(SnackBar(content: Text('Processing Data')));
                        
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          )
        ))
    );
  }
}

class ActivityPreferences extends StatefulWidget {
  @override
  ActivityPreferencesState createState() => new ActivityPreferencesState();
}
