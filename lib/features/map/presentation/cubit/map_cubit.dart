import 'package:bloc/bloc.dart';
import 'package:int20h/features/map/domain/entities/location.dart';
import 'package:int20h/features/map/domain/repositories/map_repository.dart';
import 'package:meta/meta.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit({required this.repository}) : super(MapInitial());

  final MapRepository repository;

  Future getLocations() async{
    final result = await repository.getLocations();
    emit(result.fold((failure) => MapInitial(), (data) => MapSuccess(locations: data)));
  }

}
