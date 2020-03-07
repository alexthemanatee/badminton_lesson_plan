import 'dart:async';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final int minutes;

  GameScreen(this.minutes);

  @override
  State<StatefulWidget> createState() => GameScreenState(minutes);
}

class GameScreenState extends State<GameScreen> {
  Duration duration;
  int minutes;
  Timer timer;

  GameScreenState(this.minutes) {
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
          title: Text('Game Timer'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                durationToString(duration),
                style: TextStyle(fontSize: 50),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Continue'),
                    onPressed: () {
                      timer.cancel();
                      Navigator.pop(context);
                  }),
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
              if (duration.inSeconds == 0) {
                timer.cancel();
                Navigator.pop(context);
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
