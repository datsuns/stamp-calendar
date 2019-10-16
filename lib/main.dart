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
  int _counter = 0;
  var _dayBody = <Widget>[
      Center( child: Text('1') ),
      Icon(Icons.check_box),
  ];
  Map<int, List<Widget>> _dayAll = {};

  Widget generateOneDay(BuildContext context, int day) {
    var b = List<Widget>();
    b.add(Text(day.toString()));
    b.add(Icon(Icons.check_box));

    this._dayAll[day] = b;
    //var c = Column( children: this._dayArray[day].Body() );
    var c = Column( children: this._dayAll[day] );

    var body = Container(
        decoration: BoxDecoration(border: Border.all(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        child: c,
        );

    return GestureDetector(
      onTap: () {
        setState(() {
          print("day ${day} pushed");
          _counter++;
          this._dayAll[day].add(Icon(Icons.add));
        });
      },

      child: body,
    );
  }

  Widget generateOneWeek(BuildContext context, int start) {
    return Container(
      decoration: BoxDecoration(border: Border.all(
          color: Colors.green,
          width: 2.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          generateOneDay(context, start + 0),
          generateOneDay(context, start + 1),
          generateOneDay(context, start + 2),
          generateOneDay(context, start + 3),
          generateOneDay(context, start + 4),
          generateOneDay(context, start + 5),
          generateOneDay(context, start + 6),
        ],
      ),
    );
  }

  Widget generateMainView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(
          color: Colors.red,
          width: 8.0,
          ),
        ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.display1,
          ),
          generateOneWeek(context, 1),
          generateOneWeek(context, 8),
          generateOneWeek(context, 15),
          generateOneWeek(context, 22),
          generateOneWeek(context, 29),
        ],
      )
    );
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("hello");
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: generateMainView(context),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
