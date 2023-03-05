import 'package:int20h/features/map/data/models/classrom_model.dart';
import 'package:int20h/features/map/data/models/location_model.dart';
import 'package:int20h/features/map/domain/entities/classrom.dart';
import 'package:int20h/features/schedule/domain/entities/schedule_item.dart';

class ScheduleItemModel extends ScheduleItem {
  ScheduleItemModel(
      {super.id,
      super.name,
      super.description,
      super.date,
      super.type,
      super.isRepeatable,
      super.isRepeatableBy2,
      super.dayOfWeek,
      super.location,
      super.classrom});

  ScheduleItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    date = json['date'];
    type = json['type'];
    isRepeatable = json['isRepeatable'];
    isRepeatableBy2 = json['isRepeatableBy2'];
    dayOfWeek = json['dayOfWeek'];
    location = json['location'] != null
        ? LocationModel.fromJson(json['location'])
        : null;
    classrom = json['auditory'] != null
        ? ClassromModel.fromJson(json['auditory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['date'] = this.date;
    data['type'] = this.type;
    data['isRepeatable'] = this.isRepeatable;
    data['isRepeatableBy2'] = this.isRepeatableBy2;
    data['dayOfWeek'] = this.dayOfWeek;
    return data;
  }
}
