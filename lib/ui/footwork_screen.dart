import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:badminton_lesson_plan/ui/drill_screen.dart';
import 'package:badminton_lesson_plan/ui/serve_screen.dart';
import 'package:badminton_lesson_plan/helpers/drill.dart';

class FootworkScreen extends StatefulWidget {
  final int minutes;
  final List<Drill> loDrill;
  final List<int> loDur;
  final int serve;
  final int game;

  FootworkScreen(this.minutes, this.loDrill, this.loDur, this.serve, this.game);

  @override
  State<StatefulWidget> createState() =>
      FootworkScreenState(minutes, loDrill, loDur, serve, game);
}

class FootworkScreenState extends State<FootworkScreen> {
  Duration duration;
  int minutes;
  Timer timer;
  final List<Drill> loDrill;
  final List<int> loDur;
  final int serve;
  final int game;

  FootworkScreenState(
      this.minutes, this.loDrill, this.loDur, this.serve, this.game) {
    duration = new Duration(minutes: minutes);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  List<String> _fw = [
    'Shuttle Run',
    'Forwards and Backwards Bird Throws',
    'Partner Pointing',
    'Side to Side Follow the Leader',
    'Flick Serve Return',
    'Intercept'
  ];
  static int _fwLength = 6;
  static Random random = new Random();
  int randomIndex = random.nextInt(_fwLength);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Footwork Timer'),
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
                    _fw[randomIndex],
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
                        (loDrill.isEmpty)
                            ? Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ServeScreen(serve, game)),
                                ModalRoute.withName('/'))
                            : Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DrillScreen(
                                        0, loDrill, loDur, serve, game)),
                                ModalRoute.withName('/'));
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
                (loDrill.isEmpty)
                    ? Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ServeScreen(serve, game)),
                        ModalRoute.withName('/'))
                    : Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DrillScreen(0, loDrill, loDur, serve, game)),
                        ModalRoute.withName('/'));
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
