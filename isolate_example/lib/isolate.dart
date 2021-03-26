import 'dart:isolate';

class IsolateExample {
  var portResultListener = ReceivePort();

  void increment(int i) => _sendToIsolate(i, true);
  void decrement(int i) => _sendToIsolate(i, false);

  void _sendToIsolate(int i, bool isIncrement) async {
    var portaOuvindoDoMainIsolate = ReceivePort();

    await Isolate.spawn(_isolateLogic, portaOuvindoDoMainIsolate.sendPort);
    var portaDoIsolateInterno = await portaOuvindoDoMainIsolate.first;

    portaDoIsolateInterno.send(
      IsolateMessage(
        portResultListener.sendPort,
        {'value': i, 'increment': isIncrement},
      ),
    );
  }

  static _isolateLogic(SendPort message) {
    var portaDoIsolateInterno = ReceivePort();

    message.send(portaDoIsolateInterno.sendPort);

    portaDoIsolateInterno.listen((message) {
      var isolateAguardandoResposta = message.isolate;
      int value = message.payload['value'];
      bool isIncrement = message.payload['increment'];

      isolateAguardandoResposta.send(isIncrement ? ++value : --value);
    });
  }
}

class IsolateMessage {
  SendPort isolate;
  Map payload;
  IsolateMessage(this.isolate, this.payload);
}
