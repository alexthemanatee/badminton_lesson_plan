import 'package:badminton_lesson_plan/ui/fields_screen.dart';
import 'package:flutter/material.dart';
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
                    child: Text('Both'),
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
                onPressed: (activeType == 0 ||
                        activePeople == 0 ||
                        duration == 0)
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
                        Drill toAdd =
                            new Drill(name, numPlayers, drillType, description);
                        widget.loDuration.add(duration);
                        widget.loDrills.add(toAdd);
                        Navigator.of(context).pop();
                      },
                child: Text('Add'),
              ),
            ]));
  }
}
