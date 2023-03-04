part of 'map_cubit.dart';

@immutable
abstract class MapState {}

class MapInitial extends MapState {}

class MapSuccess extends MapState {
  final List<Location> locations;

  MapSuccess({this.locations = const []});
}

