import 'package:flutter/material.dart';

class AssetPage extends StatelessWidget {
  static const routeName = '/assetPage';
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    final field = TextField(
      // style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: '....',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );

    final editButton = Material(
      color: Color.fromRGBO(51, 153, 255, 1.0), // have MaterialApp track this
      elevation: 2.0,
      borderRadius: BorderRadius.circular(10.0),
      child: MaterialButton(
        onPressed: () => print('pressed [Edit]'),
        // minWidth: MediaQuery.of(context).size.width, // matches parent width
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Text(
          'Edit',
          textAlign: TextAlign.left,
          style:
              style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    final homeButton = Material(
      color: Color.fromRGBO(51, 153, 255, 1.0), // have MaterialApp track this
      elevation: 2.0,
      borderRadius: BorderRadius.circular(10.0),
      child: MaterialButton(
        onPressed: () => Navigator.pop(context),
        // minWidth: MediaQuery.of(context).size.width, // matches parent width
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Text(
          'Home',
          textAlign: TextAlign.left,
          style:
              style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: ListView(
            children: [
              field,
              SizedBox(height: 20.0),
              field,
              SizedBox(height: 20.0),
              field,
              SizedBox(height: 20.0),
              field,
              SizedBox(height: 20.0),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,  children: [homeButton, editButton]),
            ],
          ),
        ),
      ),
    );
  }
}
