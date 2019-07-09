import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:validators/validators.dart';
import '../models/Asset.dart';

class AssetPage extends StatefulWidget {
  static const routeName = '/assetPage';
  final Asset asset;
  AssetPage({Key key, @required this.asset}) : super(key: key);

  @override
  _AssetPageState createState() => _AssetPageState(asset);
}

class _AssetPageState extends State<AssetPage> {
  final _assetFormKey = GlobalKey<FormState>();
  bool editable = false;
  Asset asset;

  _AssetPageState(this.asset);

  @override
  Widget build(BuildContext context) {
    final assetForm = Form(
      key: _assetFormKey,
      child: ListView(
        children: [
          TextFormField(
            enabled: editable,
            initialValue: asset.doe,
            decoration: InputDecoration(labelText: 'Asset Tag'),
            validator: (value) =>
                value.isEmpty ? 'Asset tag cannot be empty' : null,
            onSaved: (value) => print('<saved $value to inventory>'),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            enabled: editable,
            initialValue: asset.serial,
            decoration: InputDecoration(labelText: 'Serial Number'),
            onSaved: (value) => print('<saved $value to inventory>'),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            enabled: editable,
            initialValue: asset.location.toString(),
            decoration: InputDecoration(labelText: 'Location'),
            validator: (value) =>
                isNumeric(value) ? null : 'Location must be a number',
            keyboardType: TextInputType.number,
            onSaved: (value) => print('<saved $value to inventory>'),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            enabled: editable,
            initialValue: asset.manufacturer,
            decoration: InputDecoration(labelText: 'Manufacturer'),
            onSaved: (value) => print('<saved $value to inventory>'),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            enabled: editable,
            initialValue: asset.model,
            decoration: InputDecoration(labelText: 'Model'),
            onSaved: (value) => print('<saved $value to inventory>'),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            enabled: editable,
            initialValue: asset.description,
            decoration: InputDecoration(
                labelText: 'Description', alignLabelWithHint: true),
            keyboardType: TextInputType.multiline,
            maxLines: 15,
            onSaved: (value) {
              Firestore.instance.runTransaction(
                (transaction) async {
                  await transaction.update(
                    asset.reference,
                    {'description': value},
                  );
                },
              );
            },
          ),
        ],
      ),
    );

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
            icon: editable ? Icon(Icons.save) : Icon(Icons.edit),
            onPressed: () {
              setState(
                () {
                  editable = !editable;
                  _assetFormKey.currentState.save();
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0), child: assetForm),
    );
  }
}
