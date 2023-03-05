part of 'map_cubit.dart';

@immutable
abstract class MapState {
  List<Location> get locations => [];
  List<Classrom> get classrooms => [];
}

class MapInitial extends MapState {}

class MapSuccess extends MapState {
  @override
  final List<Location> locations;
  @override
  final List<Classrom> classrooms;
  final List<Comment> classroomComments;
  final List<Comment> locationComments;

  MapSuccess({this.locations = const [], this.classrooms = const [], this.classroomComments = const [], this.locationComments = const [],});
}

