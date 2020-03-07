import 'package:flutter/material.dart';
import 'dart:math';
import 'package:badminton_lesson_plan/helpers/drill.dart';
import 'package:badminton_lesson_plan/helpers/drill_type.dart';
import 'package:flutter/services.dart';

class AddDrill extends StatefulWidget {
  final List<Drill> loDrills;
  final List<int> loDuration;

  AddDrill(this.loDrills, this.loDuration);

  @override
  AddDrillState createState() => AddDrillState();
}

class AddDrillState extends State<AddDrill> {
  String name = "Undecided";
  int numPlayers;
  DrillType drillType;
  String description = "Undecided";
  int duration = 0;
  final TextEditingController _durController = TextEditingController();

  int activeType = 0;
  int activePeople = 0;

  static Random random = new Random();

  void changeOff() {
    setState(() {
      activeType = 1;
    });
  }

  void changeDef() {
    setState(() {
      activeType = 2;
    });
  }

  void changeBoth() {
    setState(() {
      activeType = 3;
    });
  }

  void change2() {
    setState(() {
      activePeople = 2;
    });
  }

  void change3() {
    setState(() {
      activePeople = 3;
    });
  }

  List<List<String>> _two = [
    //def
    [
      'Blocks',
      'Both Partners stand on the same side.Feeder throws the bird downwards with an overhand throw and the other brings their racket out to block it'
    ],
    [
      'Lift',
      'Partners stand on opposite sides of the net. One partner tosses the bird over with and underhand throw and the other does a lift'
    ],
    [
      'Clear',
      'Feeding partner lifts the bird to the other, who does a clear. Alternatively, partners can clear back and forth'
    ],
    //off
    [
      'Drop, Drop, Smash',
      'Feeding partner only lifts the bird while the other does a drop, into a drop, into a smash'
    ],
    [
      'Intercepts',
      'Feeder does a shallow lift while their partner stands at midcourt and leaps to intercept the bird '
    ],
    [
      'Flying Net Kill',
      'Feeder tosses the bird over the net with an underhand toss while their partner leaps forward for a netkill'
    ],
    [
      'Net Kill',
      'Feeder tosses the bird over the net with an underhand toss while the partner netkills'
    ],
    ['Smash', 'Feeder lifts for their partner to smash'],
    ['Slow Drop', 'Feeder lifts for their partner to slow drop'],
    ['Fast Drop', 'Feeder lifts for their partner to fast drop'],
    [
      'Offensive Clear',
      'Feeder lifts for partner to do an offensive clear, alternatively, partners can clear back and forth to each other'
    ],
    //mix
    [
      'Straight Net Shot',
      'Feeder tosses the bird over with an underhand toss for partner to netshot, alternatively, can net shot to each other'
    ],
    [
      'Drive',
      'Feeder tosses the bird overhand for their partner to drive, alternatively, partners can drive back and forth'
    ],
    [
      'Cross Net Shot',
      'Feeder tosses the bird over with an underhand toss for part to do a cross net'
    ],
    [
      'In and Out Drop',
      'Feeder lifts, partner drops feeder does a net, partner nets back, repeat. Partners can also alternate by replacing the partner\'s net back with a lift'
    ],
    [
      'In and Out Smash',
      'Feeder lifts, partner smashes feeder does a net, partner nets back, repeat. Partners can also alternate by replacing the partner\'s net back with a lift'
    ],
    [
      'Box Game',
      'Partners rally against each other on a half court, with the boundaries being the inside box bounded by the front service line, back doubles service line, and side singles boundaries'
    ],
    ['Net Game', 'Partners rally against each other only using net shots'],
    [
      'Bingo',
      'One partner positions at front of their side of the court and does offensive drives while other partner stands in defensive position and only does defensive drives'
    ],
  ];

  List<List<String>> _three = [
    //def
    [
      'Alternating Blocks',
      'Group is all on same side, two feeders alternate throwing downwards while other member moves side to side blocking'
    ],
    [
      'Alternating Lifts',
      'Feeders alternate underhand tosses while other member does front court footwork and lifts'
    ],
    [
      'Alternating Clears',
      'Feeders alternate lifts while the other member does back court footwork and clears'
    ],
    //off
    [
      'Alternating Intercepts',
      'Feeders alternate shallow lifts while other partner leaps to intercept the shots'
    ],
    [
      'Alternating Flying Net Kills',
      'Feeders alternate tosses while other member leaps to the corner for a flying net kill'
    ],
    [
      'Alternating Net Kills',
      'Feeders alternate tosses while the other member does a netkill'
    ],
    [
      'Alternating Smash',
      'Feeders alternate lifts while the other group member does footwork into a smash'
    ],
    [
      'Alternating Slow Drops',
      'Feeders alternate lifts while the other group member does footwork into a slow drop'
    ],
    [
      'Alternating Fast Drops',
      'Feeders alternate lifts while the other group member does footwork into a fast drop'
    ],
    [
      'Alternating Offensive Clear',
      'Feeders alternate lifts while the other group member does footwork into an offensive clear'
    ],
    [
      'Alternating Overhead Attack',
      'Feeders alternate lifts while the other group member does footwork into any overhead attacking shot'
    ],
    //mix
    [
      'Alternating Straight Net Shot',
      'Feeders alternate tosses while the other group member does front court footwork into net shot'
    ],
    [
      'Alternating Cross Net Shot',
      'Feeders alternate tosses while the other group member does front court footwork into a cross court net shot'
    ],
    ['Master and Dog', 'Two partners are on one side of a half court attacking while the other partner is alone defending'],
    [
      'Attack and Defense',
      'Two partners are on one side of the court doing strictly offensive shots while the last partner is alone on their other stricly defending.'
    ],
  ];

  static int twoDef = 3;
  static int twoOff = 11;
  static int twoTotal = 19;
  static int threeDef = 3;
  static int threeOff = 11;
  static int threeTotal = 23;

  int getIndex(int num, int type) {
    int index;
    if (num == 2) {
      if (type == 3) {
        index = (random.nextInt(twoTotal));
      } else if (type == 2) {
        index = (random.nextInt(twoDef));
      } else if (type == 1) {
        index = (random.nextInt(twoOff) + twoDef);
      }
    } else if (num == 3) {
      if (type == 3) {
        index = (random.nextInt(threeTotal));
      } else if (type == 2) {
        index = (random.nextInt(threeDef));
      } else if (type == 1) {
        index = (random.nextInt(threeTotal) + threeDef);
      }
    } 
    return index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Drill'),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Choose a Type of Drill'),
              Container(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: changeOff,
                    child: Text('Offense'),
                    color: (activeType == 1) ? Colors.red : Colors.grey,
                  ),
                  RaisedButton(
                    onPressed: changeDef,
                    child: Text('Defense'),
                    color: (activeType == 2) ? Colors.red : Colors.grey,
                  ),
                  RaisedButton(
                    onPressed: changeBoth,
                    child: Text('Mixed'),
                    color: (activeType == 3) ? Colors.red : Colors.grey,
                  ),
                ],
              ),
              Container(
                height: 20,
              ),
              Text('Choose the Number of People'),
              Container(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: change2,
                    child: Text('2'),
                    color: (activePeople == 2) ? Colors.red : Colors.grey,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: RaisedButton(
                        onPressed: change3,
                        child: Text('3'),
                        color: (activePeople == 3) ? Colors.red : Colors.grey,
                      )),
                ],
              ),
              Container(
                height: 5,
              ),
              Container(
                width: 100.0,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _durController,
                  decoration: InputDecoration(hintText: 'Time'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  onSubmitted: (str) => setState(() {
                    duration = (int.parse(str));
                  }),
                ),
              ),
              Container(
                height: 20,
              ),
              RaisedButton(
                onPressed:
                    (activeType == 0 || activePeople == 0 || duration == 0)
                        ? null
                        : () {
                            numPlayers = activePeople;
                            if (activeType == 1) {
                              drillType = DrillType.offensive;
                            } else if (activeType == 2) {
                              drillType = DrillType.defensive;
                            } else {
                              drillType = DrillType.mixed;
                            }
                            int index = getIndex(numPlayers, activeType);
                            Drill toAdd;
                            if (numPlayers == 2) {
                              toAdd = new Drill(_two[index][0], numPlayers,
                                  drillType, _two[index][1]);
                            } else {
                              toAdd = new Drill(_three[index][0], numPlayers,
                                  drillType, _three[index][1]);
                            }
                            widget.loDuration.add(duration);
                            widget.loDrills.add(toAdd);
                            Navigator.of(context).pop();
                          },
                child: Text('Add'),
              ),
            ]));
  }
}
