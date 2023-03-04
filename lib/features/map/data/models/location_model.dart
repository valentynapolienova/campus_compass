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

}