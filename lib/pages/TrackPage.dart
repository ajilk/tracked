import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'AssetPage.dart';
import 'MenuPage.dart';
import '../models/Asset.dart';
import '../models/Arguments.dart';

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
  String scanResult;
  Widget body;

  @override
  void initState() {
    super.initState();
    searchController.addListener(setSearchMode);
    searchController.addListener(search);
    body = _buildBody(
        context, Firestore.instance.collection(user.uid).snapshots());
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

  void search() {
    RegExp doePattern = new RegExp(r'^D');
    setState(
      () {
        body = _buildBody(
          context,
          doePattern.hasMatch(searchController.text.toUpperCase())
              ? Firestore.instance
                  .collection(user.uid)
                  .orderBy('doe')
                  .startAt([searchController.text.toUpperCase()]).endAt(
                  [searchController.text.toUpperCase() + "\uf8ff"],
                ).snapshots()
              : Firestore.instance
                  .collection(user.uid)
                  .orderBy('serial')
                  .startAt([searchController.text.toUpperCase()]).endAt(
                  [searchController.text.toUpperCase() + "\uf8ff"],
                ).snapshots(),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, Stream<QuerySnapshot> stream) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
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
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(
            asset.doe == null || asset.doe.isEmpty ? 'N/A' : asset.doe,
          ),
          // onLongPress: selectAsset
          onTap: () => Navigator.pushNamed(context, AssetPage.routeName,
              arguments: Arguments(user, asset)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future scan() async {
      try {
        String barcode = await BarcodeScanner.scan();
        setState(() => scanResult = barcode);
      } on PlatformException catch (ex) {
        if (ex.code == BarcodeScanner.CameraAccessDenied) {
          setState(() => scanResult = "Camera permission was denied");
        } else {
          setState(() => scanResult = "Unknown Error $ex");
        }
      } on FormatException {
        // Pressed the back button before scanning anything
        setState(() => scanResult = "");
      } catch (ex) {
        setState(() => scanResult = "Unknown Error $ex");
      }
    }

    void clearSearch() {
      searchController.text = '';
      setState(() {
        body = _buildBody(
          context,
          Firestore.instance.collection(user.uid).snapshots(),
        );
      });
    }

    final suffixIconOfSearchField = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        searchController.text.length > 0
            ? IconButton(icon: Icon(Icons.clear), onPressed: clearSearch)
            : Container(height: 0, width: 0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).accentColor),
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(10.0),
            ),
          ),
          child: scanMode
              ? IconButton(
                  icon: Icon(Icons.center_focus_weak,
                      size: 30.0, color: Colors.white),
                  onPressed: () {
                    scan().then(
                      (value) => setState(() {
                            searchController.text = scanResult;
                            searchController.text.length == 0
                                ? clearSearch()
                                : search();
                          }),
                    );
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search, size: 30.0, color: Colors.white),
                  onPressed: () => search,
                ),
        ),
      ],
    );

    Widget newAssetButton = Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Center(
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.add),
              SizedBox(width: 20),
              Text('New Asset')
            ]),
          ),
          // onLongPress: selectAsset
          onTap: () {
            Firestore.instance.collection(user.uid).add({'doe': ''}).then(
              (reference) {
                Asset asset = Asset.fromMap({'reference': reference});
                Navigator.pushNamed(
                  context,
                  AssetPage.routeName,
                  arguments: Arguments(user, asset),
                );
              },
            );
          },
        ),
      ),
    );

    final searchField = Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            onSubmitted: (value) {
              value.isEmpty ? clearSearch() : search();
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              suffixIcon: suffixIconOfSearchField,
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          'tracked',
          textScaleFactor: 1.5,
          style: TextStyle(color: Colors.white70),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushNamed(context, MenuPage.routeName, arguments: user);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            newAssetButton,
            Expanded(child: body),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: searchField,
            ),
          ],
        ),
      ),
    );
  }
}
