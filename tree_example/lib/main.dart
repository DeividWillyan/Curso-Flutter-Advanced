import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool swith = false;

  _actionSwith() => setState(() => swith = !swith);

  Widget get a => Container(
        color: Colors.red,
        child: Row(
          children: [
            Image.network('https://flutterweekly.dev/images/favicon.ico'),
            Text('Any')
          ],
        ),
      );

  Widget get b => Container(
        color: Colors.blue,
        child: Row(
          children: [
            Image.network('https://flutterweekly.dev/images/favicon.ico'),
            Text('Alter Any')
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: swith ? a : b),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _actionSwith(),
      ),
    );
  }
}
