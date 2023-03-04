import 'dart:convert';

import 'package:int20h/features/map/data/models/location_model.dart';
import 'package:int20h/features/map/domain/entities/location.dart';
import 'package:dio/dio.dart';

abstract class MapDatasource {

  Future<Location> addNewLocation(Location location);

  Future<List<Location>> getLocations();
}

class MapDatasourceImpl extends MapDatasource {
  MapDatasourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<Location> addNewLocation(Location location) async {
    final response = await dio.post('location/user', data: {
      "name": location.name,
      "latitude": location.latitude,
      "longitude": location.longitude,
      "type": location.type,
      "description": location.description,
    });
    print(response);
    return LocationModel.fromJson(response.data);
  }

  @override
  Future<List<Location>> getLocations() async {
    final response = await dio.get('/location/user');
    List<Location> locationList = [];
    response.data.forEach((element) => locationList.add(LocationModel.fromJson(element)));
    return locationList;
  }
}