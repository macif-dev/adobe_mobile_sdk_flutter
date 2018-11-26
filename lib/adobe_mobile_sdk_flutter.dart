import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class AdobeMobileSdkFlutter {

  static const MethodChannel _channel = const MethodChannel('adobe_analytics_plugin');

  ///
  /// Sets the ADBMobileConfig fileName.
  ///
  static Future<String> initTrack(String fileName) async {
    if(Platform.isIOS){
      return "This function is not supported";
    }
    final Map<String, dynamic> params = <String, dynamic>{
      "fileName": fileName
    };

    String response = await _channel.invokeMethod('initTrack', params);

    return response;
  }

  ///
  /// Sets the current [actionName], which specifies the current action context
  /// in your app.
  ///
  /// This helps identify how they interact with your app.
  ///
  /// [additionalData] is optional because it allows to add information about the tracks
  ///
  static Future<String> trackAction(String actionName, [Map<String, dynamic> additionalData]) async {
    final Map<String, dynamic> params = <String, dynamic>{
      "actionName": actionName,
    };

    if(additionalData != null){
      params.addAll({"additionalData" : additionalData});
    }

    String response = await _channel.invokeMethod('trackAction', params);

    return response;
  }

  ///
  /// Sets the current [screenName], which specifies the current visual context
  /// in your app.
  ///
  /// This helps identify the areas in your app where users spend their time
  ///
  /// [additionalData] is optional because it allows to add information about the tracks
  ///
  static Future<String> trackState(String screenName, [Map<String, dynamic> additionalData]) async {
    final Map<String, dynamic> params = <String, dynamic>{
      "screenName": screenName
    };

    if(additionalData != null){
      params.addAll({"additionalData" : additionalData});
    }

    String response = await _channel.invokeMethod('trackState', params);

    return response;
  }

}
