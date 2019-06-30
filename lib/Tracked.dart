import 'package:flutter/material.dart';
import 'AssetPage.dart';

class Tracked extends StatefulWidget {
  static const routeName = '/tracked';
  @override
  TrackedState createState() => new TrackedState();
}

class TrackedState extends State<Tracked> with TickerProviderStateMixin {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  AnimationController _controller;

  static const List<IconData> icons = const [
    Icons.home,
    Icons.vertical_align_bottom,
    Icons.vertical_align_top
  ];

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    final logo = Text('tracked', style: style.copyWith(fontSize: 40));

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
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: new List.generate(icons.length, (int index) {
          Widget child = new Container(
            // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
            height: 40.0,
            alignment: FractionalOffset.center,
            child: new ScaleTransition(
              scale: new CurvedAnimation(
                parent: _controller,
                // 0.0 -> 0.5 = duration
                curve: new Interval(0.0, 0.5 - index / icons.length / 2.0,
                    curve: Curves.easeOut),
              ),
              child: new FloatingActionButton(
                heroTag: null,
                backgroundColor: Theme.of(context).backgroundColor,
                mini: true,
                child: new Icon(
                  icons[index],
                  size: 40.0,
                ),
                onPressed: () {},
              ),
            ),
          );
          return child;
        }).toList()
          ..add(
            new Container(
              height: 50.0,
              child: GestureDetector(
                onLongPress: () {
                  if (_controller.isDismissed) {
                    _controller.forward();
                  } else {
                    _controller.reverse();
                  }
                },
                child: FittedBox(
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).backgroundColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 2.0, color: Theme.of(context).accentColor),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                    elevation: 4.0,
                    child: Icon(Icons.filter_center_focus, size: 30.0),
                    // Icon(Icons.center_focus_weak, size: 30.0),
                    // Icon(Icons.crop_free, size: 30.0, ),
                    onPressed: () => print('long pressed [SCAN]'),
                  ),
                ),
              ),
            ),
          ),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                logo,
                SizedBox(height: 30.0),
                searchField,
              ],
            ),
          ),
        ),
      ),
    );
  }
}