/* TODO: Dynamic Theme Selection */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/AssetPage.dart';
import 'pages/SigninPage.dart';
import 'pages/MenuPage.dart';
import 'pages/TrackPage.dart';
import 'theme.dart';
import 'models/Arguments.dart';

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
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}

class InstantRoute<T> extends MaterialPageRoute<T> {
  InstantRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return child;
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
          initialRoute: SigninPage.routeName,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case SigninPage.routeName:
                return InstantRoute(builder: (context) => new SigninPage());
                break;
              case TrackPage.routeName:
                return InstantRoute(
                  builder: (context) => new TrackPage(user: settings.arguments),
                );
                break;
              case AssetPage.routeName:
                return InstantRoute(builder: (context) {
                  Arguments arguments = settings.arguments;
                  return new AssetPage(
                      user: arguments.user, asset: arguments.asset);
                });
                break;
              case MenuPage.routeName:
                return InstantRoute(
                  builder: (context) => new MenuPage(user: settings.arguments),
                );
                break;
            }
          },
        ),
      );
    },
  );
}
