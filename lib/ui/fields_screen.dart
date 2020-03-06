import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:badminton_lesson_plan/ui/drill_screen.dart';

class FieldScreen extends StatefulWidget {
  final int total;

  FieldScreen(this.total);

  @override
  State<StatefulWidget> createState() => FieldScreenState(total);
}

class FieldScreenState extends State<FieldScreen> {
  int total;
  final TextEditingController _wuController = TextEditingController();
  final TextEditingController _fwController = TextEditingController();
  final TextEditingController _serveController = TextEditingController();
  final TextEditingController _gameController = TextEditingController();

  FieldScreenState(this.total);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Enter Fields:')),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 4),
                child: Text(
                  'Unallocated Time:  ' + total.toString() + '  minutes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Warmup Time:'),
                  TextField(
                    controller: _wuController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                    ]
                  )
                ],
              )
            ],
          ),
        ));
  }
}
