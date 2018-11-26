#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "ADBMobile.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.

  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ADBMobileConfig" ofType:@"json"];
  [ADBMobile overrideConfigPath:filePath];

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
