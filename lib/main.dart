/* TODO: Dynamic Theme Selection */
/* BUG: InkWell Effect on Drawer elements not working */
/* IDEA: Custom Widget with Types (type: Enum)
          e.g.  Image with short descriptions [ CustomImage(Type.short, src) ]
                Image with long descriptions [ CustomImage(Type.long, src) ]
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AssetPage.dart';
import 'Menu.dart';

class FadeRoute<T> extends MaterialPageRoute<T> {
  FadeRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  // Widget build(context, animation, secondaryAnimation, child) {}
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    // If you don't want any animation -> return child
    // return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        new MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: ThemeData(),
          // theme: ThemeData.dark(),
          theme: ThemeData(
            brightness: Brightness.dark,
            hintColor: Colors.grey.shade500,
            backgroundColor: Colors.black,
            splashColor: Colors.white,
            accentColor: Color.fromRGBO(51, 153, 255, 1.0),
            buttonColor: Color.fromRGBO(51, 153, 255, 1.0),
          ),

          home: tracked(),
          // initialRoute: tracked.routeName,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case tracked.routeName:
                return FadeRoute(builder: (context) => new tracked());
                break;
              case AssetPage.routeName:
                // FadeRoute(builder: (context) => new AssetPage());
                return FadeRoute(builder: (context) => new AssetPage());
                break;
            }
          },
        ),
      );
    },
  );
}

class tracked extends StatelessWidget {
  static const routeName = '/';

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
          // onPressed: () => print('pressed [Search]'),
          onPressed: () => Navigator.pushNamed(context, AssetPage.routeName),
          minWidth: MediaQuery.of(context).size.width, // matches parent width
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          child: Text(
            'Search',
            textAlign: TextAlign.left,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // floatingActionButton: new FloatingActionButton(
      // onPressed: () => _settingModalBottomSheet(context)),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Builder(
              builder: (context) {
                return GestureDetector(
                  onVerticalDragEnd: (details) =>
                      details.primaryVelocity > 0 ? openMenu(context) : null,
                  onTap: () => openMenu(context),
                  child: Container(
                    child: Center(
                      child: Icon(Icons.drag_handle, color: Colors.blue),
                    ),
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Builder(
          //   builder: (context) => GestureDetector(onVerticalDragEnd: (details) {
          //         if (details.primaryVelocity > 0) openMenu(context);
          //         // else if (details.primaryVelocity < 0)
          //         //   Scaffold.of(context).openEndDrawer();
          //       }),
          // ),
          Center(
            child: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    logo,
                    SizedBox(height: 30.0),
                    searchField,
                    SizedBox(height: 20.0),
                    searchButton,
                    // SizedBox(height: 100.0),
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
