import 'package:flutter/material.dart';
import 'package:badminton_lesson_plan/ui/warmup_screen.dart';

class DrillScreen extends StatefulWidget {

  //DrillScreen(this.drills);

  @override 
  DrillScreenState createState() => DrillScreenState();
}

class DrillScreenState extends State<DrillScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text("Drill Title")
      )
    );
  }
}