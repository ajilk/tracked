/* TODO: Dynamic Theme Selection */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/AssetPage.dart';
import 'pages/SigninPage.dart';
import 'pages/MenuPage.dart';
import 'pages/Tracked.dart';
import 'theme.dart';

class SlideLeftRoute<T> extends MaterialPageRoute<T> {
  SlideLeftRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  // Widget build(context, animation, secondaryAnimation, child) {}
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: new SlideTransition(
        position: new Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(1.0, 0.0),
        ).animate(secondaryAnimation),
        child: child,
      ),
    );
  }
}

class FadeRoute<T> extends MaterialPageRoute<T> {
  FadeRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  // Widget build(context, animation, secondaryAnimation, child) {}
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    // If you don't want any animation:
    return child;
    // return new FadeTransition(opacity: animation, child: child);
  }
}

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        new MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: buildThemeData(),
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
                return FadeRoute(builder: (context) => new AssetPage(asset: settings.arguments));
                break;
              case MenuPage.routeName:
                return FadeRoute(builder: (context) => new MenuPage());
                break;
            }
          },
        ),
      );
    },
  );
}
