import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tracked/pages/SigninPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
  static const routeName = '/';
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),
        () => Navigator.pushReplacementNamed(context, SigninPage.routeName));
  }

  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/tracked..png');
    Image image = Image(image: assetImage);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            child: image,
            decoration: BoxDecoration(color: Colors.black),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LinearProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "Version 1.0.0",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10.0, 
                          color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
          TrackedImage()
        ],
      ),
    );
  }
}

class TrackedImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/tracked..png');
    Image image = Image(image: assetImage);
    return Container(child: image);
  }
}
