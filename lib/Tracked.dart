import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'AssetPage.dart';
import 'MenuPage.dart';
import 'Asset.dart';

class Tracked extends StatefulWidget {
  static const routeName = '/tracked';
  @override
  TrackedState createState() => new TrackedState();
}

class TrackedState extends State<Tracked> with TickerProviderStateMixin {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  bool menuVisible = true;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('userEmail').snapshots(),
      builder: (context, snapshot) =>
          _buildList(context, snapshot.data.documents),
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
          onTap: () => Navigator.pushNamed(context, AssetPage.routeName, arguments: asset),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const color = Colors.white12;
    // TODO: Make this part of the bottomAppBar for automatic show/hide
    final searchField = TextField(
      onSubmitted: (input) {
        print(input);
        Navigator.pushNamed(context, AssetPage.routeName);
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: '[DOE] or [S/N]',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        suffixIcon: IconButton(
          // icon: Icon(Icons.center_focus_weak, size: 30.0),
          icon: Icon(
            Icons.center_focus_weak,
            size: 30.0,
          ),
          // icon: Icon(Icons.filter_center_focus, size: 30.0),
          onPressed: () => print('tapped [scan]'),
        ),
      ),
    );

    final menu = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.vertical_align_bottom),
            color: Theme.of(context).accentColor,
            onPressed: () => print('pressed [Import]'),
          ),
          IconButton(
            icon: Icon(Icons.vertical_align_top),
            color: Theme.of(context).accentColor,
            onPressed: () => print('pressed [Export]'),
          ),
        ],
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
            icon: menuVisible
                ? Icon(Icons.keyboard_arrow_up)
                : Icon(Icons.keyboard_arrow_down),
            color: Theme.of(context).accentColor,
            onPressed: () => setState(() => menuVisible = !menuVisible),
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            color: Theme.of(context).accentColor,
            onPressed: () => Navigator.pushNamed(context, MenuPage.routeName),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            menuVisible ? menu : new Container(width: 0.0, height: 0.0),
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
