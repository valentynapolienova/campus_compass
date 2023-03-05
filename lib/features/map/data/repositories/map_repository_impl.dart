import 'package:int20h/features/map/domain/entities/comment_param.dart';
import 'package:int20h/features/map/domain/entities/comment.dart';
import 'package:int20h/features/map/domain/entities/classrom.dart';
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
  FutureFailable<Comment> commentLocation(CommentParam commentParam) {
    return RepositoryRequestHandler<Comment>()(
      request: () => mapDatasource.commentLocation(commentParam),
      defaultFailure: Failure(),
    );

  }
  @override
  FutureFailable<Comment> commentClassroom(CommentParam commentParam) {
    return RepositoryRequestHandler<Comment>()(
      request: () => mapDatasource.commentClassroom(commentParam),
      defaultFailure: Failure(),
    );
  }
  @override
  FutureFailable<List<Comment>> getCommentsLocation(int id) {
    return RepositoryRequestHandler<List<Comment>>()(
      request: () => mapDatasource.getCommentsLocation(id),
      defaultFailure: Failure(),
    );
  }
  @override
  FutureFailable<List<Comment>> getClassroomComments(int id) {
    return RepositoryRequestHandler<List<Comment>>()(
      request: () => mapDatasource.getClassroomComments(id),
      defaultFailure: Failure(),
    );
  }
  @override
  FutureFailable<List<Classrom>> getClassrooms(int id) {
    return RepositoryRequestHandler<List<Classrom>>()(
      request: () => mapDatasource.getClassrooms(id),
      defaultFailure: Failure(),
    );
  }
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