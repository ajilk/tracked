/* TODO: Dynamic Theme Selection */
/* BUG: InkWell Effect on Drawer elements not working */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        new MaterialApp(
          theme: ThemeData(
            brightness: Brightness.dark,
            hintColor: Colors.grey.shade500,
            backgroundColor: Colors.black,
            splashColor: Colors.white,
            accentColor: Color.fromRGBO(51, 153, 255, 1.0),
            buttonColor: Color.fromRGBO(51, 153, 255, 1.0),
          ),
          home: tracked(),
          // theme: ThemeData(),
          // theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
        ),
      );
    },
  );
}

class tracked extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final logo = Text('tracked', style: style.copyWith(fontSize: 40));

    final searchField = TextField(
      // style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: '[DOE] or [S/N]',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        suffixIcon: IconButton(
          // icon: Icon(Icons.center_focus_weak, size: 30.0),
          // icon: Icon(Icons.crop_free, size: 30.0, ),
          icon: Icon(Icons.filter_center_focus, size: 30.0),
          onPressed: () => print('tapped [scan]'),
        ),
      ),
    );

    final searchButton = Material(
      color: Color.fromRGBO(51, 153, 255, 1.0), // have MaterialApp track this
      elevation: 2.0,
      borderRadius: BorderRadius.circular(10.0),
      child: MaterialButton(
          onPressed: () => print('pressed [Search]'),
          minWidth: MediaQuery.of(context).size.width, // matches parent width
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          child: Text(
            'Search',
            textAlign: TextAlign.left,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    final drawer = Container(
      padding: EdgeInsets.fromLTRB(10, 30, 0, 10),
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.arrow_back,
                    color: Theme.of(context).buttonColor),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                  title: Text('Export', style: style),
                  trailing: Icon(Icons.vertical_align_top,
                      color: Theme.of(context).buttonColor),
                  onTap: () => print('tapped [export]')),
              ListTile(
                  title: Text('Import', style: style),
                  trailing: Icon(Icons.vertical_align_bottom,
                      color: Theme.of(context).buttonColor),
                  onTap: () => print('tapped [import]')),
            ],
          ),
          ListTile(
              title: Text('Settings', style: style),
              trailing:
                  Icon(Icons.settings, color: Theme.of(context).buttonColor),
              onTap: () => print('tapped [settings]')),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
                icon: new Icon(Icons.dehaze,
                    color: Theme.of(context).buttonColor),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
                  icon: new Icon(Icons.dehaze,
                      color: Theme.of(context).buttonColor),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
          ),
        ],
      ),
      drawer: SizedBox(width: 200, child: Drawer(child: drawer)),
      endDrawer: SizedBox(width: 200, child: Drawer(child: drawer)),
      body: Stack(
        children: [
          Builder(
            builder: (context) =>
                GestureDetector(onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity > 0)
                    Scaffold.of(context).openDrawer();
                  else if (details.primaryVelocity < 0)
                    Scaffold.of(context).openEndDrawer();
                }),
          ),
          Center(
            child: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    logo,
                    SizedBox(height: 30.0),
                    searchField,
                    SizedBox(height: 20.0),
                    searchButton,
                    SizedBox(height: 100.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
