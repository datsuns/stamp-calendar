// [ ]save date implement
//    - Month-related data structure
//    - save and load

import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'スタンプカレンダー',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'スタンプカレンダー'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  var _done = Map<int, bool>() ;

  @override
  void initState() {
    super.initState();
    for( var i = 0; i < 31; i++ ){
      this._done[i] = false;
    }
  }

  Widget generateEmptyDay(BuildContext context) {
    var c = ListTile(
      title: Text(""),
    );
    var body = Container(
        child: Column(
          children: <Widget>[c],
        ),
    );
    return body;
  }

  Widget generateOneDay(BuildContext context, int day) {
    var c = ListTile(
      title: Text(day.toString()),
      onLongPress: () {
        setState(() {
          this._done[day] = this._done[day] == true ? false : true;
        });
      }
    );

    var icon = this._done[day] == true ? Icon(Icons.check) : Container();
    var col  = this._done[day] == true ? Colors.lightGreenAccent[400] : Colors.transparent;

    var body = Container(
        color: col,
        child: Column(
          children: <Widget>[c, icon],
        ),
    );

    return body;
  }

  Widget generateWeekTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded( child: Center( child: Text("日"), ) ),
        Expanded( child: Center( child: Text("月"), ) ),
        Expanded( child: Center( child: Text("火"), ) ),
        Expanded( child: Center( child: Text("水"), ) ),
        Expanded( child: Center( child: Text("木"), ) ),
        Expanded( child: Center( child: Text("金"), ) ),
        Expanded( child: Center( child: Text("土"), ) ),
      ],
    );
  }

  Widget generateOneWeek(BuildContext context, int start, int last, int offset) {
    var remain = last - start;
    var valid = math.min(7, remain);
    var topPadding = offset;
    var footPadding = 7 - valid;
    print("gen ${start} w/ ${valid} days, padd:${topPadding},${footPadding}");
    var body = List<Widget>();
    for( var i = 0; i < topPadding; i++ ){
      body.add( Expanded( child: generateEmptyDay(context)) );
    }
    for( var i = 0; i < valid; i++ ){
      body.add( Expanded( child: generateOneDay(context, start + i) ) );
    }
    for( var i = 0; i < footPadding; i++ ){
      body.add( Expanded( child: generateEmptyDay(context)) );
    }
    return Container(
      decoration: BoxDecoration(border: Border.all(
          color: Colors.green,
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: body,
        ),
    );
  }

  Widget generateMainView(BuildContext context, int month, int lastDay, int weekday) {
    print("m ${month} l ${lastDay} w ${weekday}");
    var secondStart = 7 - weekday;
    return Container(
      //decoration: BoxDecoration(border: Border.all(
      //    color: Colors.red,
      //    width: 1.0,
      //    ),
      //  ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded( child: generateWeekTitle(context) ),
          Expanded( child: generateOneWeek(context, 1,  lastDay, weekday) ),
          Expanded( child: generateOneWeek(context, 8,  lastDay, 0) ),
          Expanded( child: generateOneWeek(context, 15, lastDay, 0) ),
          Expanded( child: generateOneWeek(context, 22, lastDay, 0) ),
          Expanded( child: generateOneWeek(context, 29, lastDay, 0) ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final first = new DateTime(now.year, now.month, 1);
    final last = new DateTime(now.year, now.month + 1, 0);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: generateMainView(context, first.month, last.day, first.weekday),
    );
  }
}
