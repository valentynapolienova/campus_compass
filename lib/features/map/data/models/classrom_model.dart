import 'package:int20h/features/map/domain/entities/classrom.dart';

class ClassromModel extends Classrom {
  ClassromModel({ super.latitude, super.longitude, super.name, super.description});

  ClassromModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    name = json["name"];
    description = json["description"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['name'] = this.name;
    data['description'] = this.description;
    data['id'] = this.id;
    return data;
  }

}