package com.macif.plugin.adobemobilesdkflutter.adobemobilesdkflutter;

import android.content.Context;

import com.adobe.mobile.Analytics;
import com.adobe.mobile.Config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * AdobeMobileSdkFlutterPlugin
 */
public class AdobeMobileSdkFlutterPlugin implements MethodCallHandler, FlutterPlugin {

  private Context applicationContext;

  public AdobeMobileSdkFlutterPlugin() {
  }

  private void initialize(Context context) {
    applicationContext = context.getApplicationContext();
    Config.setContext(applicationContext);
    Config.setDebugLogging(false);
  }

  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    final AdobeMobileSdkFlutterPlugin instance = new AdobeMobileSdkFlutterPlugin();
    instance.initialize(registrar.activeContext());

    final MethodChannel channel = new MethodChannel(registrar.messenger(), "adobe_analytics_plugin");
    channel.setMethodCallHandler(instance);
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

  @Override
  public void onAttachedToEngine(FlutterPluginBinding binding) {
    initialize(binding.getApplicationContext());
    final MethodChannel channel = new MethodChannel(binding.getBinaryMessenger(), "adobe_analytics_plugin");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onDetachedFromEngine(FlutterPluginBinding binding) {
    this.applicationContext = null;
  }

  public void handlerInitTrack(MethodCall call, Result result) throws Exception {
    try {
      String fileName = call.argument("fileName").toString();
      InputStream configInput = applicationContext.getAssets().open(fileName);
      Config.overrideConfigStream(configInput);
      result.success("Init with config [" + fileName + "]");
    } catch (IOException ex) {
      result.error("File not found", ex.getMessage(), ex.getStackTrace());
    }
  }

  public void handlerTrackAction(MethodCall call, Result result) throws Exception {
    String actionName = call.argument("actionName");
    Map<String, Object> additionalData = call.argument("additionalData");
    Analytics.trackAction(actionName, additionalData);
    result.success("trackAction [" + actionName + "]");
  }

  public void handlerTrackState(MethodCall call, Result result) throws Exception {
    String screenName = call.argument("screenName");
    Map<String, Object> additionalData = call.argument("additionalData");
    Analytics.trackState(screenName, additionalData);
    result.success("screenName [" + screenName + "]");
  }
}
