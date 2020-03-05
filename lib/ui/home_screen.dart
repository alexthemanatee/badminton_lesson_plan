import 'package:badminton_lesson_plan/ui/warmup_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Badminton Lesson Plan"),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            FlatButton(
              child: Text("Click Me"),
              onPressed: () {
                navigateToSubPage(context);
              },
            )
          ],
        )));
  }

  Future navigateToSubPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WarmupScreen(minutes: 5)));
  }
}
