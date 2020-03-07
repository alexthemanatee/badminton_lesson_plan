import 'dart:async';

import 'package:flutter/material.dart';
import 'package:badminton_lesson_plan/ui/footwork_screen.dart';
import'package:badminton_lesson_plan/helpers/drill.dart';

class WarmupScreen extends StatefulWidget {
  final int minutes;
  final int fw;
  final List<Drill> loDrill;
  final List<int> loDur;
  final int serve;
  final int game;

  WarmupScreen(this.minutes, this.fw, this.loDrill, this.loDur, this.serve, this.game);

  @override
  State<StatefulWidget> createState() => WarmupScreenState(minutes, fw, loDrill, loDur, serve, game);
}

class WarmupScreenState extends State<WarmupScreen> {
  Duration duration;
  int minutes;
  Timer timer;
  final int fw;
  final List<Drill> loDrill;
  final List<int> loDur;
  final int serve;
  final int game;

  WarmupScreenState(this.minutes, this.fw, this.loDrill, this.loDur, this.serve, this.game) {
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
                      Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => FootworkScreen(fw, loDrill, loDur, serve, game)),
                        ModalRoute.withName('/')
                      );
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
              if (duration.inSeconds <= 0) {
                timer.cancel();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => FootworkScreen(fw, loDrill, loDur, serve, game)),
                    ModalRoute.withName('/')
                  );
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
