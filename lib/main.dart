import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        new MaterialApp(
          home: new Scaffold(body: tracked()),
          theme: ThemeData(
            fontFamily: 'HurmeGeometricSans1',
          ),
          debugShowCheckedModeBanner: false,
        ),
      );
    },
  );
}

class tracked extends StatelessWidget {
  // TextStyle style = TextStyle(fontFamily: '');
  final searchField = TextField(
    decoration: InputDecoration(hintText: '[DOE] or [S/N]'),
  );

  final searchButton = RaisedButton(
    onPressed: () => print('pressed [Search]'),
    child: const Text('Search'),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 80.0, right: 80.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            searchField,
            Padding(padding: EdgeInsets.all(10.0)),
            SizedBox(
              width: double.infinity, // matches parents width [container]
              child: RaisedButton(
                onPressed: () => print('pressed [Search]'),
                child: const Text('Search'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
