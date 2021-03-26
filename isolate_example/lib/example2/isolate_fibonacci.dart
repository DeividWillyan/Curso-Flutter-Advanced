import 'dart:isolate';

class Calc {
  Future<int> isolateFibonacci(int n) async {
    var isolateListnner = ReceivePort();
    var port = ReceivePort();

    await Isolate.spawn(_isolateLogic, port.sendPort);
    SendPort portNewIsolate = await port.first;

    portNewIsolate.send(
      {'isolate': isolateListnner.sendPort, 'value': n},
    );

    return await isolateListnner.first;
  }

  static _isolateLogic(SendPort message) {
    var isolatePrivatePort = ReceivePort();
    message.send(isolatePrivatePort.sendPort);

    isolatePrivatePort.listen((message) {
      var externalIsolate = message['isolate'];
      int value = message['value'];
      externalIsolate.send(fibonacci(value));
    });
  }

  static int fibonacci(int n) {
    if (n == 0 || n == 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
  }
}
