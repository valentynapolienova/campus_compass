import 'package:int20h/features/map/data/models/location_model.dart';
import 'package:int20h/features/map/domain/entities/location.dart';
import 'package:dio/dio.dart';

abstract class MapDatasource {

  Future<List<Location>> getLocations();
}

class MapDatasourceImpl extends MapDatasource {
  MapDatasourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<List<Location>> getLocations() async {
    final response = await dio.get('/locations');

    List<Location> locationList = [];
    response.data.forEach((element) => locationList.add(LocationModel.fromJson(element)));
    return locationList;
  }
}