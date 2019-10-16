// [ ]are Row and Column decoratable or not

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  Widget generateOneDay(BuildContext context, int day) {
    var c = ListTile(
      title: Text(day.toString()),
      onLongPress: () {
        setState(() {
          this._done[day] = this._done[day] == true ? false : true;
        });
      }
    );

    var body = Container(
        color: this._done[day] == true ? Colors.green : Colors.red,
        child: c,
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

  Widget generateOneWeek(BuildContext context, int start) {
    return Container(
      decoration: BoxDecoration(border: Border.all(
          color: Colors.green,
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded( child: generateOneDay(context, start + 0) ),
          Expanded( child: generateOneDay(context, start + 1) ),
          Expanded( child: generateOneDay(context, start + 2) ),
          Expanded( child: generateOneDay(context, start + 3) ),
          Expanded( child: generateOneDay(context, start + 4) ),
          Expanded( child: generateOneDay(context, start + 5) ),
          Expanded( child: generateOneDay(context, start + 6) ),
        ],
      ),
    );
  }

  Widget generateMainView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(
          color: Colors.red,
          width: 3.0,
          ),
        ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded( child: generateWeekTitle(context) ),
          Expanded( child: generateOneWeek(context, 1) ),
          Expanded( child: generateOneWeek(context, 8) ),
          Expanded( child: generateOneWeek(context, 15) ),
          Expanded( child: generateOneWeek(context, 22) ),
          Expanded( child: generateOneWeek(context, 29) ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: generateMainView(context),
      ),
    );
  }
}
