import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _youHavePressed = 'Listening..';
  static const pressedChannel = MethodChannel('pressed');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(_youHavePressed),
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  _getPressedValue();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getPressedValue() async {
    String pressedValue;
    try {
      var result = await pressedChannel.invokeMethod('getPressedValue' );
      pressedValue = 'you have pressed $result';
    } on PlatformException catch (e) {
      pressedValue = "failed coz $e";
    }
    setState(() {
      _youHavePressed = pressedValue;
    });
  }
}
