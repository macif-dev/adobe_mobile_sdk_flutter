#import "AdobeMobileSdkFlutterPlugin.h"
#import "ADBMobile.h"

@implementation AdobeMobileSdkFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"adobe_analytics_plugin"
            binaryMessenger:[registrar messenger]];
  AdobeMobileSdkFlutterPlugin* instance = [[AdobeMobileSdkFlutterPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSDictionary *arguments = call.arguments;
  if ([@"trackAction" isEqualToString:call.method]) {
    [self trackAction:call result:result args:arguments];
  }
  else if ([@"trackState" isEqualToString:call.method]) {
    [self trackState:call result:result args:arguments];
  }
  else if ([@"trackCrash" isEqualToString:call.method]) {
    [self trackCrash:call result:result args:arguments];
  }
  else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)trackAction:(FlutterMethodCall*)call result:(FlutterResult)result args:(NSDictionary*)args {
  NSString *actionName = [args objectForKey:@"actionName"];
  if(actionName != nil ){
    NSDictionary *additionalData = [args objectForKey:@"additionalData"];
    [self sendTrack:actionName additionalData:additionalData isState:false];
  }else{
    result([NSString stringWithFormat:@"[ trackAction ERROR ] :: actionName is required"]);
  }
}

- (void)trackState:(FlutterMethodCall*)call result:(FlutterResult)result args:(NSDictionary*)args {
  NSString *screenName = [args objectForKey:@"screenName"];
  if(screenName != nil ){
    NSDictionary *additionalData = [args objectForKey:@"additionalData"];
    [self sendTrack:screenName additionalData:additionalData isState:true];
  }else{
    result([NSString stringWithFormat:@"[ trackState ERROR ] :: screenName is required"]);
  }
}

- (void)sendTrack:(NSString*)name additionalData:(NSDictionary*)additionalData isState:(bool)isState {

  NSMutableDictionary *contextData = nil;

  if([additionalData count] > 0){
      contextData = [NSMutableDictionary dictionary];
      for (NSString *key in additionalData) {
          NSString *value = additionalData[key];
          [contextData setObject:value forKey:key];
      }
  }

  if(isState){
    [ADBMobile trackState:name data:contextData];
  }else{
    [ADBMobile trackAction:name data:contextData];
  }
}

- (void)trackCrash:(FlutterMethodCall*)call result:(FlutterResult)result args:(NSDictionary*)args {
  result([NSString stringWithFormat:@"TrackCrash is not implemented"]);
}

@end
