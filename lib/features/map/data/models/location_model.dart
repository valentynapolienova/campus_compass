import 'package:int20h/features/map/domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel({super.imgUrl, super.latitude, super.longitude, super.name, super.type, super.description});

  LocationModel.fromJson(Map<String, dynamic> json) {
    imgUrl = json["imgUrl"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    name = json["name"];
    description = json["description"];
    type = json["type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgUrl'] = this.imgUrl;
    data['type'] = this.type;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }

}