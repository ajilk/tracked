import 'package:flutter/material.dart';
import 'Field.dart';

class AssetPage extends StatelessWidget {
  static const routeName = '/assetPage';
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    final editButton = Material(
      color: Color.fromRGBO(51, 153, 255, 1.0), // have MaterialApp track this
      elevation: 2.0,
      borderRadius: BorderRadius.circular(10.0),
      child: MaterialButton(
          onPressed: () => print('pressed [Edit]'),
          minWidth: MediaQuery.of(context).size.width, // matches parent width
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          child: Text(
            'Edit',
            textAlign: TextAlign.left,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView(
              children: [
                Field(text: 'Asset Tag'),
                Field(text: 'Serial Number'),
                Field(text: 'Location', keyboardType: TextInputType.number),
                Field(text: 'Manufacturer'),
                Field(text: 'Model'),
                Field(
                  text: 'Description',
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: 24.0),
                editButton,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
