import 'package:hive/hive.dart';

part 'hive_report.g.dart';

@HiveType(typeId: 1)
class RDDreport extends HiveObject {
  RDDreport({
    required this.report_name,
    required this.disease,
    required this.overview,
    required this.preventive_measure,
    required this.symptoms,
    required this.solution,
    required this.seg_img,
    required this.org_img,
  });
  @HiveField(0)
  String report_name;

  @HiveField(1)
  String disease;

  @HiveField(2)
  String overview;

  @HiveField(3)
  String symptoms;

  @HiveField(4)
  String preventive_measure;

  @HiveField(5)
  String solution;

  @HiveField(6)
  String seg_img;

  @HiveField(7)
  String org_img;
}
