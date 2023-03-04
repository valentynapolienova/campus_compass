import 'package:int20h/core/error/repository_request_handler.dart';
import 'package:int20h/core/error/failures.dart';
import 'package:int20h/core/helper/type_aliases.dart';
import 'package:int20h/features/map/domain/entities/location.dart';
import 'package:int20h/features/map/data/datasource/map_datasource.dart';
import 'package:int20h/features/map/domain/repositories/map_repository.dart';

class MapRepositoryImpl extends MapRepository {
  final MapDatasource mapDatasource;

  MapRepositoryImpl({required this.mapDatasource,});
  @override
  FutureFailable<Location> addNewLocation(Location location) {
    return RepositoryRequestHandler<Location>()(
      request: () => mapDatasource.addNewLocation(location),
      defaultFailure: Failure(),
    );
  }
  @override
  FutureFailable<List<Location>> getLocations() {
    return RepositoryRequestHandler<List<Location>>()(
      request: () => mapDatasource.getLocations(),
      defaultFailure: Failure(),
    );
  }

}