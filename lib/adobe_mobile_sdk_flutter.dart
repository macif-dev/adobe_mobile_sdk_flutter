import 'dart:async';

import 'package:flutter/services.dart';

class AdobeMobileSdkFlutter {
  static const MethodChannel _channel =
      const MethodChannel('adobe_mobile_sdk_flutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
