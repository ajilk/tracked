/*
  Menu Page 
  - profile details
  - other tools e.g. import, export
*/

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuPage extends StatelessWidget {
  static const routeName = '/menu';
  static const whitecolor = Colors.white; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: Automatically hide appBar when scrolling main page
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: whitecolor,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                  title: Align(
                    alignment: Alignment(-1.2, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('John Doe'),
                        Text(
                          'johndoe@gmail.com',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.exit_to_app),
                    color: Theme.of(context).accentColor,
                    onPressed: () => print('tapped [Sign Out]'),
                  ),
                  onTap: () => print('tapped [UserInfo]'),
                ),
                Divider(height: 10.0, indent: 100.0),
                ListTile(
                  title: Align(
                    child: Text('Export'),
                    alignment: Alignment(-1.1, 0),
                  ),
                  leading: Icon(
                    Icons.vertical_align_top,
                    color: whitecolor,
                  ),
                  onTap: () => print('tapped [export]'),
                ),
                ListTile(
                  title: Align(
                    child: Text('Import'),
                    alignment: Alignment(-1.1, 0),
                  ),
                  leading: Icon(
                    Icons.vertical_align_bottom,
                    color: whitecolor,
                  ),
                  onTap: () => print('tapped [import]'),
                ),
                Divider(),
                ListTile(
                  title: Align(
                    child: Text('Settings'),
                    alignment: Alignment(-1.1, 0),
                  ),
                  leading: Icon(
                    Icons.settings,
                    color: whitecolor,
                  ),
                  onTap: () => print('tapped [settings]'),
                ),
                ListTile(
                  title: Align(
                    child: Text('Help & Feedback'),
                    alignment: Alignment(-1.1, 0),
                  ),
                  leading: Icon(
                    Icons.help_outline,
                    color: whitecolor,
                  ),
                  onTap: () => print('tapped [help]'),
                ),
              ],
            ),
            ListTile(
              title: Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(fontSize: 11.0),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => launch('https://google.com'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
