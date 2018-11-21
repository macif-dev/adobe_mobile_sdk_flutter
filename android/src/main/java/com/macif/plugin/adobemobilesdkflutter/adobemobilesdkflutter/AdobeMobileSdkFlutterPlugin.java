package com.macif.plugin.adobemobilesdkflutter.adobemobilesdkflutter;

import android.app.Activity;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.adobe.mobile.*;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;


/**
 * AdobeMobileSdkFlutterPlugin
 */
public class AdobeMobileSdkFlutterPlugin implements MethodCallHandler {

  private final Activity activity;

  private AdobeMobileSdkFlutterPlugin(Activity activity) {
    this.activity = activity;
  }

  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "adobe_analytics_plugin");
    channel.setMethodCallHandler(new AdobeMobileSdkFlutterPlugin(registrar.activity()));

    Config.setContext(registrar.activeContext());
    Config.setDebugLogging(false);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    try {
      switch (call.method) {
        case "initTrack":
          handlerInitTrack(call, result);
          break;
        case "trackAction":
          handlerTrackAction(call, result);
          break;
        case "trackState":
          handlerTrackState(call, result);
          break;
        default:
          result.notImplemented();
          break;
      }
    } catch (Exception e) {
      result.error("Error", e.getMessage(), e.getStackTrace());
    }
  }

  public void handlerInitTrack(MethodCall call, Result result) throws Exception {
    try {
      String fileName = call.argument("fileName").toString();
      InputStream configInput = activity.getAssets().open(fileName);
      Config.overrideConfigStream(configInput);
      result.success("Init with config [" + fileName + "]");
    } catch (IOException ex) {
      result.error("File not found", ex.getMessage(), ex.getStackTrace());
    }
  }

  public void handlerTrackAction(MethodCall call, Result result) throws Exception {
    String actionName = call.argument("actionName");
    Map<String, Object> additionnalData = call.argument("additionnalData");
    Analytics.trackAction(actionName, additionnalData);
    result.success("trackAction [" + actionName + "]");
  }

  public void handlerTrackState(MethodCall call, Result result) throws Exception {
    String screenName = call.argument("screenName");
    Map<String, Object> additionnalData = call.argument("additionnalData");
    Analytics.trackState(screenName, additionnalData);
    result.success("screenName [" + screenName + "]");
  }
}
