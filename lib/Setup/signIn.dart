import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  String _email, _password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in"),
      ), 
      body: Form (
        //TODO: Implement key
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
                if(input.isEmpty){
                  return "Email field can't be empty";
                }
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                labelText: 'Email'
              )
            ),
          TextFormField(
              validator: (input) {
                if(input.length < 6){
                  return "Password must be more than 6 characters";
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                labelText: 'Password'
              ),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: (){},
              child: Text('Sign in'),
              )
          ],
        ),
      )
    );
  }

  void signIn(){
    final formState = formKey.currentState;
    if(formState.validate()){
      //TODO login to firebase
    }
    theme: ThemeData(
            brightness: Brightness.dark,
            hintColor: Colors.grey.shade500,
            backgroundColor: Colors.black,
            splashColor: Colors.blue,
            accentColor: Color.fromRGBO(51, 153, 255, 1.0),
            buttonColor: Color.fromRGBO(51, 153, 255, 1.0),
          );    
  }
}