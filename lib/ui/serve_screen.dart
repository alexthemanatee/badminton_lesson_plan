import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:badminton_lesson_plan/ui/game_screen.dart';

class ServeScreen extends StatefulWidget {
  final int minutes;
  final int game;

  ServeScreen(this.minutes, this.game);

  @override
  State<StatefulWidget> createState() => ServeScreenState(minutes, game);
}

class ServeScreenState extends State<ServeScreen> {
  Duration duration;
  int minutes;
  Timer timer;
  final int game;

  ServeScreenState(this.minutes, this.game) {
    duration = new Duration(minutes: minutes);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  List<String> _serves = [
    'Doubles Serve',
    'Flick Serve',
    'Singles Underhand',
    'Serve Return Singles',
    'Serve Return Doubles Flick',
    'Serve Return Doubles to Center',
    'Serve Return Doubles to Side'
  ];
  static int _servesLength = 7;
  static Random random = new Random();
  int randomIndex = random.nextInt(_servesLength);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Serve Timer'),
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
                  Text(
                    _serves[randomIndex],
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Continue'),
                    onPressed: () {
                      timer.cancel();
                      Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => GameScreen(game)),
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
              if (duration.inSeconds == 0) {
                timer.cancel();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => GameScreen(game)),
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
