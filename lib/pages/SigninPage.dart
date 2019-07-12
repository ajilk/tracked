/*
  Alternative:
    have a pop that sign users in to their gmail account
    so the user interface is familiar to them
*/
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:core';
import 'TrackPage.dart';

class SigninPage extends StatefulWidget {
  static const routeName = '/';
  @override
  SigninPageState createState() => new SigninPageState();
}

class SigninPageState extends State<SigninPage> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  String _email, _password;

  // bool validateAndSave() => key.currentState.validate() ? true : false;

  @override
  Widget build(BuildContext context) {
    RegExp validEmail = new RegExp(r'^.+\@gmail.com$');

    final logo = Text('tracked', style: TextStyle(fontSize: 40));

    Future<void> _signIn() async {
      final formState = key.currentState;
      if (formState.validate()) {
        key.currentState.save();
        try {
          FirebaseUser user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password);
          print("Signed In: ${user.uid}");
          Navigator.pushReplacementNamed(
            context,
            TrackPage.routeName,
            arguments: user,
          );
        } catch (e) {
          switch (e.code) {
            case 'ERROR_WRONG_PASSWORD':
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                    title: new Text("Wrong Password"),
                    content: new Text(e.message),
                    actions: <Widget>[
                      // usually buttons at the bottom of the dialog
                      new FlatButton(
                        child: new Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
              break;
            case 'ERROR_USER_NOT_FOUND':
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                    title: new Text("User not found"),
                    content: new Text(e.message),
                    actions: <Widget>[
                      // usually buttons at the bottom of the dialog
                      new FlatButton(
                        child: new Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
              break;
            default:
              print(e.code);
          }
        }
        print("Email: $_email");
        print("Password: $_password");
      }
    }

    final emailField = TextFormField(
      validator: (input) => input.length < 6 || !validEmail.hasMatch(input)
          ? "Invalid Email"
          : null,
      onSaved: (input) => _email = input,
      // decoration: InputDecoration(labelText: 'Email'),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );

    final passwordField = TextFormField(
      obscureText: true,
      validator: (input) =>
          input.length < 6 ? "Password must be more than 6 characters" : null,
      onSaved: (input) => _password = input,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );

    final signinButton = Material(
      color: Color.fromRGBO(51, 153, 255, 1.0), // have MaterialApp track this
      elevation: 2.0,
      borderRadius: BorderRadius.circular(10.0),
      child: MaterialButton(
        onPressed: () => _signIn(),
        minWidth: MediaQuery.of(context).size.width, // matches parent width
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Text(
          'Sign In',
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            key: key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                logo,
                SizedBox(height: 40.0),
                emailField,
                SizedBox(height: 20.0),
                passwordField,
                SizedBox(height: 40.0),
                signinButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
