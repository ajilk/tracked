import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Asset.dart';

class AssetPage extends StatefulWidget {
  static const routeName = '/assetPage';
  final Asset asset;
  final FirebaseUser user;
  AssetPage({Key key, @required this.user, @required this.asset})
      : super(key: key);

  @override
  _AssetPageState createState() => _AssetPageState(user, asset);
}

class _AssetPageState extends State<AssetPage> {
  final key = GlobalKey<FormState>();
  final FirebaseUser user;
  Asset asset;
  bool editable = false;

  _AssetPageState(this.user, this.asset);

  Widget buildField({
    String field,
    String labelText,
    TextInputType keyboardType,
    Function validator,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        enabled: editable,
        initialValue: asset.toMap()[field],
        keyboardType: keyboardType,
        maxLines: keyboardType == TextInputType.multiline ? 15 : 1,
        decoration: InputDecoration(
          labelText: labelText,
          alignLabelWithHint: true,
        ),
        validator: validator,
        onSaved: (value) {
          Firestore.instance.runTransaction(
            (transaction) async {
              await transaction.update(asset.reference, {field: value});
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void _delete() {
      final DocumentReference documentReference = Firestore.instance
          .collection("9VfW5pgvlcWbwDbgoBwME6N9wDq1")
          .document(asset.reference.documentID);
      documentReference.delete().whenComplete(() {
        print("Deleted Successfully");
        print(asset.reference.documentID);
        Navigator.pop(context);
      }).catchError((e) => print(e));
    }

    final editButton = IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        setState(() {
          editable = true;
        });
      },
    );

    final saveButton = IconButton(
      icon: Icon(Icons.save),
      onPressed: () {
        setState(() {
          if (key.currentState.validate()) {
            key.currentState.save();
            editable = false;
          }
        });
      },
    );

    final obsoleteButton = Container(
      decoration: BoxDecoration(
        color: Colors.red,
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(10.0)),
      width: MediaQuery.of(context).size.width,
      child: IconButton(
        color: Colors.white,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent, // makes highlight invisible too
        onPressed: () => _delete(),
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        icon: Icon(Icons.delete),
      ),
    );

    final assetForm = Form(
      key: key,
      child: ListView(
        children: [
          buildField(
            field: 'doe',
            labelText: 'Asset Tag',
            validator: (value) {
              return value.isEmpty ? 'Asset tag cannot be empty' : null;
            },
          ),
          buildField(field: 'serial', labelText: 'Serial Number'),
          buildField(field: 'location', labelText: 'Location'),
          buildField(field: 'manufacturer', labelText: 'Manufacturer'),
          buildField(field: 'model', labelText: 'Model'),
          buildField(
            field: 'description',
            labelText: 'Description',
            keyboardType: TextInputType.multiline,
          ),
          editable ? obsoleteButton : Container(height: 0, width: 0),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [editable ? saveButton : editButton],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0), child: assetForm),
    );
  }
}
