import 'package:flutter/material.dart';
import 'Field.dart';

class AssetPage extends StatelessWidget {
  static const routeName = '/assetPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.blue,
          icon: Icon(Icons.keyboard_arrow_left, size: 40.0),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            color: Colors.blue,
            icon: Icon(Icons.create),
            onPressed: () => print('tapped [EDIT]'),
          ),
        ],
      ),
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
              ],
            ),
          ),
          GestureDetector(
            child: Container(width: 100.0),
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity > 0) Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
