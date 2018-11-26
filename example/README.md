# adobe_mobile_sdk_flutter_example

### On iOS

* Replace ADBMobileConfig.json in Runner/Runner
* Call to override function in appDelegate

```
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ADBMobileConfig" ofType:@"json"];
    [ADBMobile overrideConfigPath:filePath];
```
### On android


# Track function

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
