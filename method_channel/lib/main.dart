import 'package:flutter/material.dart';
import 'package:method_channel/platform_channels/platform_channel.dart';
import 'package:method_channel/two_example.dart'; // import for method channel

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
  var examplePlatformChannel = ExamplePlatformChannel();

  String _result = '';

  String nameRequest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                onChanged: (val) => nameRequest = val,
                decoration: InputDecoration(hintText: 'Name'),
              ),
            ),
            Text(
              'Method Chaneel Result:',
            ),
            Text(
              '$_result',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            heroTag: 'hr1',
            onPressed: () async {
              _result = await examplePlatformChannel.callSimpleMethodChannel();
              setState(() {});
            },
            tooltip: 'Call Method Channel',
            child: Text('1'),
          ),
          FloatingActionButton(
            heroTag: 'hr2',
            onPressed: () async {
              _result = await examplePlatformChannel
                  .callSimpleMethodChannelWithParams(nameRequest);
              setState(() {});
            },
            tooltip: 'Call Method Channel with param',
            child: Text('2'),
          ),
          FloatingActionButton(
            heroTag: 'hr3',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TwoExamplePage()),
              );
            },
            tooltip: 'Go to Outher Example',
            child: Text('3'),
          ),
        ],
      ),
    );
  }
}
