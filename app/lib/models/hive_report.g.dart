// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_report.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RDDreportAdapter extends TypeAdapter<RDDreport> {
  @override
  final int typeId = 1;

  @override
  RDDreport read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RDDreport(
      report_name: fields[0] as String,
      disease: fields[1] as String,
      overview: fields[2] as String,
      preventive_measure: fields[4] as String,
      symptoms: fields[3] as String,
      solution: fields[5] as String,
      seg_img: fields[6] as String,
      org_img: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RDDreport obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.report_name)
      ..writeByte(1)
      ..write(obj.disease)
      ..writeByte(2)
      ..write(obj.overview)
      ..writeByte(3)
      ..write(obj.symptoms)
      ..writeByte(4)
      ..write(obj.preventive_measure)
      ..writeByte(5)
      ..write(obj.solution)
      ..writeByte(6)
      ..write(obj.seg_img)
      ..writeByte(7)
      ..write(obj.org_img);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RDDreportAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
