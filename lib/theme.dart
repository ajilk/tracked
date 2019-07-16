import 'package:flutter/material.dart';

ThemeData buildThemeData() {
  return ThemeData(
    fontFamily: 'HurmeGeometricSans1',
    brightness: Brightness.dark,
    hintColor: Colors.grey.shade500,
    backgroundColor: Colors.black,
    splashColor: Colors.blue,
    accentColor: Color.fromRGBO(51, 153, 255, 1.0),
    buttonColor: Color.fromRGBO(51, 153, 255, 1.0),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Color.fromRGBO(51, 153, 255, 1.0),
        ),
      ),
      contentPadding: EdgeInsets.all(15.0),
    ),
  );
}
