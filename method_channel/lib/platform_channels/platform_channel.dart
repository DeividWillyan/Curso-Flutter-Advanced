import 'package:flutter/services.dart';

class ExamplePlatformChannel {
  var platform = MethodChannel('unique.identifier.method/hello');

  ExamplePlatformChannel() {
    platform.setMethodCallHandler(this._callbackPlatformChannel);
  }

  Future<String> callSimpleMethodChannel() async =>
      await platform.invokeMethod('getHelloWorld');

  Future<String> callSimpleMethodChannelWithParams(String param) async {
    if (param == null || param.isEmpty) return '';
    return await platform.invokeMethod('getHelloWorld', {'user': param});
  }

  Future<void> _callbackPlatformChannel(MethodCall call) async {
    final String args = call.arguments;
    switch (call.method) {
      case "methodCallback":
        print('Method Channel Callback -> $args');
    }
  }
}
