/* TODO: move searchField into the appBar for automatic hiding */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'AssetPage.dart';
import 'MenuPage.dart';
import '../models/Asset.dart';

class TrackPage extends StatefulWidget {
  static const routeName = '/tracked';
  final FirebaseUser user;

  TrackPage({Key key, @required this.user}) : super(key: key);

  @override
  _TrackPageState createState() => new _TrackPageState(user);
}

class _TrackPageState extends State<TrackPage> with TickerProviderStateMixin {
  FirebaseUser user;
  _TrackPageState(this.user);

  final searchController = TextEditingController();
  bool scanMode = true;
  bool filterOptionsVisible = false;
  String result;

  @override
  void initState() {
    super.initState();
    searchController.addListener(setSearchMode);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void setSearchMode() {
    searchController.text.length == 0
        ? setState(() => scanMode = true)
        : setState(() => scanMode = false);
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        result = barcode;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        // You pressed the back button before scanning anything
        result = "";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(user.uid).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: SizedBox(
              height: 50.0,
              width: 50.0,
              child: CircularProgressIndicator(),
            ),
          );
        else
          return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
        children:
            snapshot.map((data) => _buildListItem(context, data)).toList());
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final asset = Asset.fromSnapshot(data);

    return Padding(
      // padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(asset.doe),
          onTap: () => Navigator.pushNamed(context, AssetPage.routeName,
              arguments: asset),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Make this part of the bottomAppBar for automatic show/hide
    final searchField = TextField(
      controller: searchController,
      onSubmitted: (value) {
        Navigator.pushNamed(context, AssetPage.routeName);
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: 'Search',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        suffixIcon: scanMode
            ? IconButton(
                // icon: Icon(Icons.center_focus_weak, size: 30.0),
                // icon: Icon(Icons.filter_center_focus, size: 30.0),
                icon: Icon(Icons.center_focus_weak, size: 30.0),
                onPressed: () {
                  scan();
                  searchController.text = result;
                })
            : IconButton(
                icon: Icon(Icons.search, size: 30.0),
                onPressed: () => print('pressed Search'),
              ),
      ),
    );

    final filterOptions = Container(
      child: Center(
        child: Text(
          '[ Filter Options ] ',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          'tracked',
          style: TextStyle(color: Colors.white70),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          IconButton(
            icon: filterOptionsVisible
                ? Icon(Icons.keyboard_arrow_up)
                : Icon(Icons.filter_list),
            color: Theme.of(context).accentColor,
            onPressed: () =>
                setState(() => filterOptionsVisible = !filterOptionsVisible),
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            color: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.pushNamed(
                context,
                MenuPage.routeName,
                arguments: user,
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            filterOptionsVisible
                ? filterOptions
                : new Container(width: 0.0, height: 0.0),
            Expanded(child: _buildBody(context)),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
              child: searchField,
            ),
          ],
        ),
      ),
    );
  }
}
