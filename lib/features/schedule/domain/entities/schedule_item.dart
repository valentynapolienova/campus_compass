import 'package:int20h/features/map/domain/entities/classrom.dart';
import 'package:int20h/features/map/domain/entities/location.dart';

class ScheduleItem {
  int? id;
  String? name;
  String? description;
  String? date;
  String? type;
  bool? isRepeatable;
  bool? isRepeatableBy2;
  String? dayOfWeek;
  Location? location;
  Classrom? classrom;

  ScheduleItem({
    this.id,
    this.name,
    this.description,
    this.date,
    this.type,
    this.isRepeatable,
    this.isRepeatableBy2,
    this.dayOfWeek,
    this.location,
    this.classrom,
  });
}
