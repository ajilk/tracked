import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String logo = 'images/tracked.png';
    return Container(
      child: Image(
        image: AssetImage(logo),
      ),
    );
  }
}