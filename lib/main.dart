/* TODO: Dynamic Theme Selection */
/* BUG: InkWell Effect on Drawer elements not working */
/* IDEA: Custom Widget with Types (type: Enum)
          e.g.  Image with short descriptions [ CustomImage(Type.short, src) ]
                Image with long descriptions [ CustomImage(Type.long, src) ]
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AssetPage.dart';
import 'SigninPage.dart';
import 'Tracked.dart';

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
          theme: ThemeData(
            brightness: Brightness.dark,
            hintColor: Colors.grey.shade500,
            backgroundColor: Colors.black,
            splashColor: Colors.blue,
            accentColor: Color.fromRGBO(51, 153, 255, 1.0),
            buttonColor: Color.fromRGBO(51, 153, 255, 1.0),
          ),

          home: SigninPage(),
          // initialRoute: tracked.routeName,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case SigninPage.routeName:
                return FadeRoute(builder: (context) => new SigninPage());
                break;
              case Tracked.routeName:
                return FadeRoute(builder: (context) => new Tracked());
                break;
              case AssetPage.routeName:
                return FadeRoute(builder: (context) => new AssetPage());
                break;
            }
          },
        ),
      );
    },
  );
}
