import 'package:badminton_lesson_plan/helpers/drill_type.dart';

class Drill {
  String name;
  int numPlayers;
  DrillType drillType;
  String description;

  Drill(this.name, this.numPlayers, this.drillType, this.description);

}