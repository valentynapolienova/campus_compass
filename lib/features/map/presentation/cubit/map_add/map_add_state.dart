part of 'map_add_cubit.dart';

@immutable
abstract class MapAddState {}

class MapAdding extends MapAddState {}

class MapLoading extends MapAddState {}

class MapAddSuccess extends MapAddState {}

class MapAddFailure extends MapAddState {}
