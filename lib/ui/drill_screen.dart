import 'package:flutter/material.dart';
import 'package:badminton_lesson_plan/helpers/drill.dart';
import 'package:badminton_lesson_plan/helpers/drill_type.dart';
import 'package:badminton_lesson_plan/ui/serve_screen.dart';
import 'dart:async';

class DrillScreen extends StatefulWidget {
  final int index;
  final List<Drill> loDrill;
  final List<int> loDur;
  final int serve;
  final int game;

  DrillScreen(this.index, this.loDrill, this.loDur, this.serve, this.game);

  @override
  DrillScreenState createState() =>
      DrillScreenState(index, loDrill, loDur, serve, game);
}

class DrillScreenState extends State<DrillScreen> {
  int index;
  List<Drill> loDrill;
  List<int> loDur;
  int serve;
  int game;
  Duration duration;
  Timer timer;

  DrillScreenState(
      this.index, this.loDrill, this.loDur, this.serve, this.game) {
    duration = new Duration(minutes: loDur[index]);
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
          title: Text(loDrill[index].name),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    (loDrill[index].drillType == DrillType.offensive) ?
                    'Offensive Drill' :
                    (loDrill[index].drillType == DrillType.defensive) ?
                    'Defensive Drill' :
                    'Mixed Drill'
                  ),
                  Text(
                    loDrill[index].numPlayers.toString() + ' Players'
                  ),
                ],
              ),
              Center(
                child: Container(
                  child: Text(
                    loDrill[index].description,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                      child: Text('Continue'),
                      onPressed: () {
                        timer.cancel();
                        (index == loDrill.length - 1)
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
                                        ++index, loDrill, loDur, serve, game)),
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
                (loDrill.length - 1 == index)
                    ? Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ServeScreen(serve, game)),
                        ModalRoute.withName('/'))
                    : Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DrillScreen(
                                index++, loDrill, loDur, serve, game)),
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
