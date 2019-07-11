import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SigninPage.dart';

class MenuPage extends StatelessWidget {
  static const routeName = '/menu';
  final FirebaseUser user;
  MenuPage({Key key, @required this.user});

  @override
  Widget build(BuildContext context) {
    signOut() {
      Navigator.pushNamedAndRemoveUntil(
        context,
        SigninPage.routeName,
        (Route r) => r == null,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).accentColor,
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
                  leading: Icon(Icons.account_circle),
                  title: Align(
                    alignment: Alignment(-1.2, 0),
                    child: Text('${user.email}'),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.exit_to_app),
                    color: Theme.of(context).accentColor,
                    onPressed: () => signOut(),
                  ),
                  onTap: () => print('tapped [UserInfo]'),
                ),
                Divider(height: 10.0, indent: 100.0),
                ListTile(
                  title: Align(
                    child: Text('Settings'),
                    alignment: Alignment(-1.1, 0),
                  ),
                  leading: Icon(Icons.settings),
                  onTap: () => print('tapped [settings]'),
                ),
                ListTile(
                  title: Align(
                    child: Text('Help & Feedback'),
                    alignment: Alignment(-1.1, 0),
                  ),
                  leading: Icon(Icons.help_outline),
                  onTap: () => print('tapped [help]'),
                ),
              ],
            ),
            ListTile(
              title: Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                        fontSize: 11.0, decoration: TextDecoration.underline),
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
