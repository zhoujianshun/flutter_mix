import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtherRouteApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OtherRouteApp',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: OtherRoute(title: 'Flutter Other Route Page'),
    );
  }
}

class OtherRoute extends StatefulWidget {
  final String title;
  OtherRoute({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _OtherRouteState();
  }
}

class _OtherRouteState extends State<OtherRoute> {
  static const platform = const MethodChannel('com.flutter.sample/home');
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('111'),
        leading: Builder(
          builder: (BuildContext context) {
            return new IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () async {
                bool popResult = await platform
                    .invokeMethod('flutter_toNativeDismiss', ['OtherRoute']);
                print(
                  "popResult:"
                );
              },
            );
          },
        ),
      ),
      body:Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('toNativeSomething'),
              onPressed: () {
                platform.invokeMethod(
                    'flutter_toNativeSomething', [2, 'toNativeSomething']);
              },
            ),
            FlatButton(
              child: Text('toNativePush'),
              onPressed: () {
                platform.invokeMethod(
                    'flutter_toNativePush', [1, 'toNativePush']);
              },
            ),
          ],
        ),
      ),
    );
  }
}
