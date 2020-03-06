import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:badminton_lesson_plan/ui/drill_screen.dart';

class WarmupScreen extends StatefulWidget {
  final int minutes;

  WarmupScreen({Key key, this.minutes}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WarmupScreenState(minutes);
}

class WarmupScreenState extends State<WarmupScreen> {
  Duration duration;
  int minutes;
  Timer timer;

  WarmupScreenState(this.minutes) {
    duration = new Duration(minutes: minutes);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Warmup Timer'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              Text(
                durationToString(duration),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DrillScreen()));
                  })
                ],
              )
            ],
          ),
        ));
  }

  String durationToString(Duration duration) {
    return duration.toString().split('.').first.padLeft(8, "0");
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
        oneSec,
        (timer) => setState(() {
              if (duration.isNegative) {
                timer.cancel();
              } else {
                duration -= oneSec;
              }
            }));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
