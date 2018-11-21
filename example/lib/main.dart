import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:adobe_mobile_sdk_flutter/adobe_mobile_sdk_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _init = "Unknow";
  String _platformString = "Android";

  @override
  void initState(){
    super.initState();
    initTrackState();
    Platform.isIOS ? _platformString = "IOS" : _platformString = "ANDROID";
  }

  Future<void> initTrackState() async{

    String result;
    try{
      await AdobeMobileSdkFlutter.initTrack("ADBMobileConfigCustom.json");
      result = ("Track is init...");
    } on Exception {
      result = 'Failed to init Adobe Tracking';
    }

    setState(() {
      _init = result;
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Adobe tracking example app'),
          ),
          body: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              Center(
                child: Text('Status : $_init\n'),
              ),
              SizedBox(height: 16.0,),
              FlatButton(
                color: Colors.blue,
                child: Text("Track screen", style: TextStyle(color: Colors.white),),
                onPressed: (){
                  print("Track screen...");
                  AdobeMobileSdkFlutter.trackState("ECRAN_TEST_ADOBE_$_platformString").then((val){
                    print(val);
                  });
                },
              ),
              SizedBox(height: 16.0,),
              FlatButton(
                color: Colors.blue,
                child: Text("Track action", style: TextStyle(color: Colors.white)),
                onPressed: (){
                  print("Track action...");
                  try{
                    AdobeMobileSdkFlutter.trackAction("ACTION_TEST_ADOBE_$_platformString",<String, dynamic>{
                      "action": "action_test"
                    }).then((val){
                      print(val);
                    });
                  } on Exception {
                    setState(() {
                      _init = 'Failed to track action';
                    });
                  }
                },
              ),
            ],
          )
      ),
    );
  }
}
