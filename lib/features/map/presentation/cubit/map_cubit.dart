import 'package:bloc/bloc.dart';
import 'package:int20h/features/map/domain/entities/classrom.dart';
import 'package:int20h/features/map/domain/entities/comment.dart';
import 'package:int20h/features/map/domain/entities/comment_param.dart';
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

  Future getClassrooms(int id) async{
    final result = await repository.getClassrooms(id);
    emit(result.fold((failure) => MapSuccess(locations: state.locations), (data) => MapSuccess(locations: state.locations, classrooms: data)));
  }

  Future getClassroomComments(int id) async{
    final result = await repository.getClassroomComments(id);
    emit(result.fold((failure) => MapSuccess(locations: state.locations, classrooms: state.classrooms), (data) => MapSuccess(locations: state.locations, classrooms: state.classrooms, classroomComments: data)));
  }

  Future getLocationComments(int id) async{
    final result = await repository.getCommentsLocation(id);
    emit(result.fold((failure) => MapSuccess(locations: state.locations, classrooms: state.classrooms), (data) => MapSuccess(locations: state.locations, classrooms: state.classrooms, locationComments: data)));
  }

  Future commentClassroom(int id, String comment) async{
    final result = await repository.commentClassroom(CommentParam(comment: comment, id: id));
    getClassroomComments(id);
  }

  Future commentLocation(int id, String comment) async{
    final result = await repository.commentLocation(CommentParam(comment: comment, id: id));
    getLocationComments(id);
  }

  cleanClassroomComments() {
    emit(MapSuccess(classroomComments: const [], classrooms: state.classrooms, locations: state.locations));
  }

  cleanLocationComments() {
    emit(MapSuccess( classroomComments: const [],locationComments: const [], classrooms: state.classrooms, locations: state.locations));
  }

}
