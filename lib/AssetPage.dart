import 'package:flutter/material.dart';
import 'Field.dart';
import 'Asset.dart';

class AssetPage extends StatelessWidget{
  static const routeName = '/assetPage';
  final Asset asset;

  const AssetPage({Key key, @required this.asset}) : super(key: key);

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            Field(label: 'Asset Tag', hintText: asset.doe),
            Field(label: 'Serial Number', hintText: asset.serial),
            Field(label: 'Location', hintText: asset.location.toString(), keyboardType: TextInputType.number),
            Field(label: 'Manufacturer', hintText: asset.manufacturer,),
            Field(label: 'Model', hintText: asset.model, keyboardType: TextInputType.text,),
            Field(
              label: 'Description',
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
