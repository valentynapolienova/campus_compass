import 'package:bloc/bloc.dart';
import 'package:int20h/features/map/domain/entities/location.dart';
import 'package:int20h/features/map/domain/repositories/map_repository.dart';
import 'package:meta/meta.dart';

part 'map_add_state.dart';

class MapAddCubit extends Cubit<MapAddState> {
  MapAddCubit({required this.repository}) : super(MapAdding());

  final MapRepository repository;

  Future addLocation(Location location) async{
    emit(MapLoading());
    final result = await repository.addNewLocation(location);
    emit(result.fold((l) => MapAddFailure(), (r) => MapAddSuccess()));
  }

}
