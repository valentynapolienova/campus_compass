import 'package:int20h/core/helper/type_aliases.dart';
import 'package:int20h/features/map/domain/entities/location.dart';

abstract class MapRepository{

  FutureFailable<Location> addNewLocation(Location location);

  FutureFailable<List<Location>> getLocations();

}