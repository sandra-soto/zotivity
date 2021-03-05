import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zotivity/backend/sign_in.dart';
import '../models/ZotUser.dart';
import 'ActivityPreferences.dart';


class ProfileCreationState extends State<ProfileCreation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ZotUser _user = new ZotUser();
  User googleInfo = getCurrentUser();

  Widget _buildName() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded (
            child: TextFormField(
              cursorColor: Theme.of(context).accentColor,
              decoration: InputDecoration(
                icon: const Icon(Icons.person),
                labelStyle: Theme.of(context).textTheme.bodyText2,
                labelText: 'First Name',
              ),
              initialValue: googleInfo.displayName.split(' ').first,
              keyboardType: TextInputType.name,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
              onSaved: (String value) {
                _user.setFirstName(value);
              }
            ),
          ),
          Expanded (
            child: TextFormField(
              cursorColor: Theme.of(context).accentColor,
              decoration: InputDecoration(
                labelStyle: Theme.of(context).textTheme.bodyText2,
                labelText: 'Last Name'
              ),
              initialValue: googleInfo.displayName.split(' ').last,
              keyboardType: TextInputType.name,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
              },
              onSaved: (String value) {
                _user.setLastName(value);
              }
            ),
          ),
        ],
      )
    );
  }

  Widget _buildEmail() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            cursorColor: Theme.of(context).accentColor,
            decoration: InputDecoration(
              icon: const Icon(Icons.email),
              labelStyle: Theme.of(context).textTheme.bodyText2,
              labelText: 'Email'
            ),
            initialValue: googleInfo.email,
            keyboardType: TextInputType.emailAddress,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter your email address';
              }
              if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
                return 'Please enter a valid email Address';
              }
              return null;
            },
            onSaved: (String value) {
              _user.setEmail(value);
            }
          )
        ],
      )
    );
  }

  Widget _buildAge() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            cursorColor: Theme.of(context).accentColor,
            decoration: InputDecoration(
              icon: const Icon(Icons.calendar_today),
              labelStyle: Theme.of(context).textTheme.bodyText2,
              labelText: 'Age',
            ),
            keyboardType: TextInputType.number,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter your age';
              }

              int age = int.tryParse(value);

              if (age < 1) {
                return 'Please enter a valid age';
              }
              return null;
            },
            onSaved: (String value) {
              _user.setAge(int.tryParse(value));
            }
          )
        ],
      )
    );
  }

  Widget _buildWeight() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            cursorColor: Theme.of(context).accentColor,
            decoration: InputDecoration(
              icon: const Icon(Icons.leaderboard),
              labelStyle: Theme.of(context).textTheme.bodyText2,
              labelText: 'Current weight',
            ),
            keyboardType: TextInputType.number,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter your weight';
              }

              int weight = int.tryParse(value);

              if (weight < 1) {
                return 'Please enter a valid weight';
              }
              return null;
            },
            onSaved: (String value) {
              _user.addWeight(int.tryParse(value));
            }
          )
        ],
      )
    );
  }

  Widget _buildGoal() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            cursorColor: Theme.of(context).accentColor,
            decoration: InputDecoration(
              icon: const Icon(Icons.star_outlined),
              labelStyle: Theme.of(context).textTheme.bodyText2,
              labelText: 'Weight Goal',
            ),
            keyboardType: TextInputType.number,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter your weight goal';
              }

              int weight = int.tryParse(value);

              if (weight < 1) {
                return 'Please enter a valid weight';
              }
              return null;
            },
            onSaved: (String value) {
              _user.setGoal(int.tryParse(value));
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
      appBar: AppBar(title: Text('Profile Creation')),
      body: SingleChildScrollView(
        child: Container (
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName(),
                _buildEmail(),
                _buildAge(),
                _buildWeight(),
                _buildGoal(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async{
                      // Validate returns true if the form is valid, or false otherwise.
                      if (!_formKey.currentState.validate()) {
                        return;
                      }

                      _formKey.currentState.save();


                      //https://stackoverflow.com/questions/59706862/flutter-form-multi-screens
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ActivityPreferences(_user);  // transfer user info to the next page
                          }
                        ),
                      );
                    },
                    child: Text('Next'),
                  ),
                ),
              ],
            ),
          )
        )
      )
    );
  }
}

class ProfileCreation extends StatefulWidget {
  @override
  ProfileCreationState createState() => new ProfileCreationState();
}

