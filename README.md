# adobe_mobile_sdk_flutter

adobe_plugin_flutter is a flutter plugin for use AdobeMobileSDK.

### Adobe Mobile User Documentation
Adobe Mobile services provides a new UI that brings together mobile marketing capabilities for mobile applications from across the Adobe Experience Cloud. Initially, the Mobile service provides seamless integration of app analytics and targeting capabilities from the Adobe Analytics, Adobe Audience Manager, and Adobe Target solutions, and Experience Cloud ID service.

To learn more about the Mobile Services UI and read the user documentation, see [Adobe Mobile Services](https://marketing.adobe.com/resources/help/en_US/mobile/).

*Note*: This plugin is still under development, and some APIs might not be available yet. [Feedback](https://github.com/flutter/flutter/issues) and [Pull Requests](https://github.com/flutter/plugins/pulls) are most welcome!


#### Mobile support

  - Android
  - iOS
  

## Getting Started

### Usage
To use this plugin, add adobe_plugin_flutter as a dependency in your pubspec.yaml file.

### Set the ADBMobile JSON Config Path

Tip: 
* On iOS, the `ADBMobileConfig.json` can be placed anywhere that it is accessible in your `bundle`. see [Adobe Mobile iOS](https://marketing.adobe.com/resources/help/en_US/mobile/ios/overview.html)

* On android, the `ADBMobileConfig.json` can be placed on assets folder. See [Adobe Mobile SDK android](https://marketing.adobe.com/resources/help/en_US/mobile/android/overview.html)


### InitTrack

This function is use for set the ADBMobile configuration with files.

* On iOS : add ADBConfigFile to appDelegate.m

```
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ADBMobileConfig" ofType:@"json"];
    [ADBMobile overrideConfigPath:filePath];
```

* On Android : use initTrack function

`initTrack(String fileName);`

```dart
    try{
        await AdobeAnalyticsPlugin.initTrack("ADBMobileConfigCustom.json");
    } on Exception {
       print('Failed to init Adobe Tracking');
    }
```
### TrackScreen

This function is use for track the screen with optional data.

`trackState(String screenName, [Map<String, dynamic> additionalData]);`

```dart
    String result = await AdobeAnalyticsPlugin.trackState(
        "SCREEN_NAME",
        null
    );
```

### TrackAction

This function is use for track the action with optional data.

`trackAction(String actionName, [Map<String, dynamic> additionalData]);`

```dart
    String result = await AdobeAnalyticsPlugin.trackAction(
        "ACTION_NAME",
        <String, dynamic>{
            "action": "ACTION",
            "category": "TEST"
        }
    );
```

## Getting Started

See the `example` directory for a complete sample app using adobe_plugin_flutter.

### Plugins

| Plugin | Links |
| ------ | ------ |
| AdobeMobileSDK iOS | https://cocoapods.org/pods/AdobeMobileSDK |
| AdobeMobileSDK android | https://mvnrepository.com/artifact/com.adobe.mobile/adobeMobileLibrary/4.17.0 |

