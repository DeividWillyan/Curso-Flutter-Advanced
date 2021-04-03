import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // import for method channel

class TwoExamplePage extends StatefulWidget {
  @override
  _TwoExamplePageState createState() => _TwoExamplePageState();
}

class _TwoExamplePageState extends State<TwoExamplePage> {
  static const stream = EventChannel('unique.identifier.method/stream');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Stream Method Channel Result:',
            ),
            StreamBuilder(
                stream: stream.receiveBroadcastStream(),
                builder: (context, snapshot) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
