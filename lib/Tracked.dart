import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'AssetPage.dart';

class Tracked extends StatefulWidget {
  static const routeName = '/tracked';
  @override
  TrackedState createState() => new TrackedState();
}

class TrackedState extends State<Tracked> with TickerProviderStateMixin {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  void initState() {super.initState();}

  @override
  Widget build(BuildContext context) {
    final searchField = TextField(
      // style: style,
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
            Icons.crop_free,
            size: 30.0,
          ),
          // icon: Icon(Icons.filter_center_focus, size: 30.0),
          onPressed: () => print('tapped [scan]'),
        ),
      ),
    );

    final drawer = Padding(
      padding: EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // children: <Widget>[Text('add'), Text('remove')],
            children: [
              ListTile(
                title: Align(
                  alignment: Alignment(-1.5, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('John Doe'),
                      Text(
                        'johndoe@gmail.com',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
                ),
                leading: Icon(Icons.account_circle),
                onTap: () => print('tapped [export]'),
              ),
              Divider(height: 10.0, indent: 100.0),
              ListTile(
                title: Align(
                  child: Text('Export'),
                  alignment: Alignment(-1.2, 0),
                ),
                leading: Icon(Icons.vertical_align_top),
                onTap: () => print('tapped [export]'),
              ),
              ListTile(
                title: Align(
                  child: Text('Import'),
                  alignment: Alignment(-1.2, 0),
                ),
                leading: Icon(Icons.vertical_align_bottom),
                onTap: () => print('tapped [import]'),
              ),
              Divider(),
              ListTile(
                title: Align(
                  child: Text('Settings'),
                  alignment: Alignment(-1.2, 0),
                ),
                leading: Icon(Icons.settings),
                onTap: () => print('tapped [settings]'),
              ),
              ListTile(
                title: Align(
                  child: Text('Help & Feedback'),
                  alignment: Alignment(-1.2, 0),
                ),
                leading: Icon(Icons.help_outline),
                onTap: () => print('tapped [help]'),
              ),
            ],
          ),
          ListTile(
            title: Center(
              child: RichText(
                text: TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(fontSize: 11.0),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => print('tapped [TOS]')),
              ),
            ),
          ),
        ],
      ),
    );

    final data = Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        color: Colors.white24,
        child: Center(
          child: Text('INVENTORY DATA'),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('tracked'),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
                icon: new Icon(Icons.dehaze, color: Colors.blue),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
      ),
      drawer: SizedBox(
        width: 250.0,
        child: Drawer(child: drawer),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              data,
              searchField,
            ],
          ),
        ),
      ),
    );
  }
}
