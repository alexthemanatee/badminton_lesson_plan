import 'package:badminton_lesson_plan/ui/fields_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {

  final TextEditingController _durationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Badminton Lesson Plan"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
          children: <Widget>[
            TextField(
              textAlign: TextAlign.center,
              controller: _durationController,
              decoration: InputDecoration(
                hintText: 'Input Class Duration in Minutes'
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
            ),
            FlatButton(
              child: Text("Go"),
              onPressed: () {
                navigateToSubPage(context);
              },
            )
          ],
        )));
  }

  Future navigateToSubPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FieldScreen(int.parse(_durationController.text)))
        );
  }
}
