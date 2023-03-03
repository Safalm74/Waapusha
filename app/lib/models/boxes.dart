import 'package:hive/hive.dart';
import 'hive_report.dart';

class boxes {
  static Box<RDDreport> getRddreports() => Hive.box('rdd_report');
}
