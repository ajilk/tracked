import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'AssetPage.dart';
import 'MenuPage.dart';

class Tracked extends StatefulWidget {
  static const routeName = '/tracked';
  @override
  TrackedState createState() => new TrackedState();
}

class TrackedState extends State<Tracked> with TickerProviderStateMixin {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

     const color = Colors.white12; 
    // TODO: Make this part of the bottomAppBar for automatic show/hide
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
        suffixIcon: IconButton(
          // icon: Icon(Icons.center_focus_weak, size: 30.0),
          icon: Icon(
            Icons.center_focus_weak,
            size: 30.0,
          ),
          // icon: Icon(Icons.filter_center_focus, size: 30.0),
          onPressed: () => print('tapped [scan]'),
        ),
      ),
    );

    final data = Expanded(
      child: Container(
        color: Colors.white24,
        child: Center(        
          child:ListView(
  padding: const EdgeInsets.all(10.0),
  physics: BouncingScrollPhysics(),
  children: <Widget>[         //Window view of inventory for that particular device 
    Container(
      height: 50,
      child: const Center(child: Text('INVENTORY DATA', 
      textScaleFactor: 1.5,)
      ),

    ),
    Container(
      height: 50,
      color: color,
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.symmetric(vertical:3.0),
      child: Text('Asset Tag :')

    ),
    Container(
      height: 50,
      color: color,
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.symmetric(vertical:3.0),
      child: Text('Serial Number :')

    ),
    Container(
      height: 50,
      color: color,
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.symmetric(vertical:3.0),
      child: Text('Location :'),
    ),
    Container(
      height: 50,
      color: color,
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.symmetric(vertical:3.0),
      child: Text('Manufacturer :'),
      

    ),
    Container(
      height: 50,
      color: color,
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.symmetric(vertical:3.0),
      child: Text('Model :')
    ),
    
    Container(
      
      height: 160,
      color: Colors.white24,
       padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.symmetric(vertical:3.0),
      child: Text('Description :',)
    )],
)
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('tracked',textScaleFactor: 1.3,),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            color: Theme.of(context).accentColor,
            onPressed: () => Navigator.pushNamed(context, MenuPage.routeName),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            data,
            Padding(
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                child: searchField),
          ],
        ),
      ),
    );
  }
}
