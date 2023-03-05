import 'package:int20h/features/map/domain/entities/comment_param.dart';
import 'package:int20h/features/map/domain/entities/comment.dart';
import 'package:int20h/features/map/domain/entities/classrom.dart';
import 'package:int20h/core/helper/type_aliases.dart';
import 'package:int20h/features/map/domain/entities/location.dart';

abstract class MapRepository{

  FutureFailable<Comment> commentLocation(CommentParam commentParam);

  FutureFailable<Comment> commentClassroom(CommentParam commentParam);

  FutureFailable<List<Comment>> getCommentsLocation(int id);

  FutureFailable<List<Comment>> getClassroomComments(int id);

  FutureFailable<List<Classrom>> getClassrooms(int id);

  FutureFailable<Location> addNewLocation(Location location);

  FutureFailable<List<Location>> getLocations();

}