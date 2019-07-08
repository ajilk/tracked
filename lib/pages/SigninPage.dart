/*
  Alternative:
    have a pop that sign users in to their gmail account
    so the user interface is familiar to them
*/
import 'package:flutter/material.dart';
import 'Tracked.dart';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';

class SigninPage extends StatefulWidget {
  static const routeName = '/';
  @override
  SigninPageState createState() => new SigninPageState();
}

class SigninPageState extends State<SigninPage> {

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  String _email, _password;

bool validateandSave(){

   final form = key.currentState;
   if(form.validate()){
     return true;
   }else{
     return false;
   }
 }

  Future<void> _signIn() async{
    final formState = key.currentState;
    if (formState.validate()) {
      key.currentState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        print("Signed In: ${user.uid}");
        Navigator.push(context, MaterialPageRoute(builder: (context) => Tracked()));
      }catch(e){
        print(e);
      }
      print("Email: $_email");
      print("Password: $_password");

    }
  }

  @override
  Widget build(BuildContext context) {
    RegExp validEmail = new RegExp(r'^.+\@gmail.com$');

    final logo = Text('tracked', style: TextStyle(fontSize: 40));

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
            //TODO: Implement key
            key: key, // Like this ?
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
