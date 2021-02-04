import 'package:flutter/material.dart';
import '../models/user.dart';

class ProfileCreationState extends State<ProfileCreation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User _user = User();

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
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        // Scaffold.of(context)
                        //     .showSnackBar(SnackBar(content: Text('Processing Data')));
                        
                        print(_user);
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

class ProfileCreation extends StatefulWidget {
  @override
  ProfileCreationState createState() => new ProfileCreationState();
}

