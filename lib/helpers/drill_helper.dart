import 'package:badminton_lesson_plan/helpers/drill.dart';
import 'package:badminton_lesson_plan/helpers/drill_type.dart';

class DrillHelper {
  final List<Drill> drills = 
  [Drill("In and Out", 2, DrillType.mixed, "Go in and out dipshit"),
  Drill("2 defend 1 attack", 3, DrillType.mixed, "Attack and defend???"),
  Drill("In and Out", 2, DrillType.mixed, "Go in and out dipshit"),]; 

  Drill getDrill(DrillType drillType, int numPlayers){
    return drills.firstWhere((x) => x.drillType == drillType && x.numPlayers == numPlayers);
  }
}