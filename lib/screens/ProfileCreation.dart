import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zotivity/backend/sign_in.dart';
import '../models/ZotUser.dart';
import 'ActivityPreferences.dart';

class ProfileCreationState extends State<ProfileCreation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ZotUser _user = new ZotUser();
  User googleInfo = getCurrentUser();

  Widget _buildFirstName() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "First Name",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              // helperText: "Example: Jane Doe",
              border: const OutlineInputBorder(),
              // contentPadding: EdgeInsets.symmetric(vertical: 4),
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
              // NOTE: can grab info from signed in user by doing
              // _user.setFirstName(getCurrentUser().displayName);
              _user.setFirstName(value);
            }
          )
        ],
      )
    );
  }

  Widget _buildLastName() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Last Name",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              // helperText: "Example: Jane Doe",
              border: const OutlineInputBorder(),
              // contentPadding: EdgeInsets.symmetric(vertical: 4),
            ),
            initialValue: googleInfo.displayName.split(' ').last,  // TODO: prepopulate using Google data! 
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
          )
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
          Text(
            "Email",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              // helperText: "Example: Jane Doe",
              border: const OutlineInputBorder(),
              // contentPadding: EdgeInsets.symmetric(vertical: 4),
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
          Text(
            "Age",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              // helperText: "Example: Jane Doe",
              border: const OutlineInputBorder(),
              // contentPadding: EdgeInsets.symmetric(vertical: 4),
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

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(title: Text('Profile Creation')),
      body: SingleChildScrollView(
        child: Container (
          padding: EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildFirstName(),
                _buildLastName(),
                _buildEmail(),
                _buildAge(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async{
                      //Todo: remove my printstatements l8r
                      print("balh");
                      print(getCurrentUser());
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

