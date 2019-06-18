import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        new MaterialApp(
          // darkTheme: ThemeData(buttonColor: Color.fromRGBO(51, 153, 255, 1.0)),
          home: tracked(),
          theme: ThemeData(),
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
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: '[DOE] or [S/N]',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    final searchButton = Material(
      color: Color.fromRGBO(51, 153, 255, 1.0),
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

    final drawer = Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // children: <Widget>[Text('add'), Text('remove')],
            children: [
              ListTile(
                leading: Icon(Icons.arrow_back),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                  title: Text('add'),
                  trailing: Icon(Icons.add),
                  onTap: () => print('tapped [add]')),
              ListTile(
                  title: Text('remove'),
                  trailing: Icon(Icons.remove),
                  onTap: () => print('tapped [remove]')),
            ],
          ),
          ListTile(
              title: Text('settings'),
              trailing: Icon(Icons.settings),
              onTap: () => print('tapped [settings]')),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
                icon: new Icon(Icons.dehaze, color: Colors.black),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
      ),
      drawer: Drawer(child: drawer),
      body: Center(
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
                SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
