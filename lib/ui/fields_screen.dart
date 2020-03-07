import 'package:badminton_lesson_plan/ui/warmup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:badminton_lesson_plan/ui/add_drill_screen.dart';
import 'package:badminton_lesson_plan/helpers/drill.dart';
import 'package:badminton_lesson_plan/helpers/drill_type.dart';

class FieldScreen extends StatefulWidget {
  final int total;

  FieldScreen(this.total);

  @override
  State<StatefulWidget> createState() => FieldScreenState(total);
}

class FieldScreenState extends State<FieldScreen> {
  int total;
  int wu = 0;
  int fw = 0;
  int serve = 0;
  int game = 0;
  List<Drill> loDrill = [];
  List<int> loDuration = [];
  final TextEditingController _wuController = TextEditingController();
  final TextEditingController _fwController = TextEditingController();
  final TextEditingController _serveController = TextEditingController();
  final TextEditingController _gameController = TextEditingController();

  FieldScreenState(this.total);

  int sumDrill(List<int> lod) {
    int sum = 0;
    for (int i = 0; i < lod.length; i++) {
      sum += lod[i];
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text('Enter Fields:')),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SafeArea(
            child: Container(
              child: LayoutBuilder(builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  reverse: true,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: viewportConstraints.minHeight,
                          maxHeight: viewportConstraints.maxHeight),
                      child: Column(
                        children: <Widget>[
                          Container(
                            //padding: const EdgeInsets.fromLTRB(0, 0, 16, 4),
                            child: Text(
                              'Unallocated Time:  ' +
                                  (total -
                                          (wu +
                                              fw +
                                              sumDrill(loDuration) +
                                              serve +
                                              game))
                                      .toString() +
                                  '  minutes',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Warmup Time:  '),
                              Expanded(
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: _wuController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly,
                                  ],
                                  onSubmitted: (str) => setState(() {
                                    wu = (int.parse(str));
                                  }),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Footwork Time:  '),
                              Expanded(
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: _fwController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly,
                                  ],
                                  onSubmitted: (str) => setState(() {
                                    fw = (int.parse(str));
                                  }),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Add Drill'),
                              IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddDrill(loDrill, loDuration)));
                                  })
                            ],
                          ),
                          new Expanded(
                              child: new ListView.builder(
                                  itemCount: loDrill.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return new DispDrill(
                                        loDrill[index], loDuration[index]);
                                  })),
                          Container(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Serving Time:  '),
                              Expanded(
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: _serveController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly,
                                  ],
                                  onSubmitted: (str) => setState(() {
                                    serve = (int.parse(str));
                                  }),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Game Time:  '),
                              Expanded(
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: _gameController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly,
                                  ],
                                  onSubmitted: (str) => setState(() {
                                    game = (int.parse(str));
                                  }),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                  child: Text('Start'),
                                  onPressed: (total -
                                              (wu +
                                                  fw +
                                                  sumDrill(loDuration) +
                                                  serve +
                                                  game) !=
                                          0)
                                      ? null
                                      : () {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    WarmupScreen(
                                                        wu,
                                                        fw,
                                                        loDrill,
                                                        loDuration,
                                                        serve,
                                                        game),
                                              ),
                                              ModalRoute.withName('/'));
                                        })
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ));
  }
}

class DispDrill extends StatelessWidget {
  final Drill _drill;
  final int _duration;

  DispDrill(this._drill, this._duration);

  @override
  Widget build(BuildContext context) {
    //return Text(_drill.name + ': ' + _duration.toString());
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(_drill.numPlayers.toString() + ' People'),
              Text(_drill.drillType == DrillType.offensive
                  ? 'Offensive'
                  : _drill.drillType == DrillType.defensive
                      ? 'Defensive'
                      : 'Mixed'),
              Text(
                'Duration: ' + _duration.toString() + ' Minutes',
              )
            ]),
      ),
    );
  }
}
