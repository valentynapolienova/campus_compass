import 'package:int20h/features/map/data/models/comment_model.dart';
import 'package:int20h/features/map/domain/entities/comment.dart';
import 'package:int20h/features/map/data/models/classrom_model.dart';
import 'package:int20h/features/map/domain/entities/classrom.dart';
import 'dart:convert';

import 'package:int20h/features/map/data/models/location_model.dart';
import 'package:int20h/features/map/domain/entities/comment_param.dart';
import 'package:int20h/features/map/domain/entities/location.dart';
import 'package:dio/dio.dart';

abstract class MapDatasource {

  Future<List<Comment>> getCommentsLocation(int id);

  Future<List<Comment>> getClassroomComments(int id);

  Future<List<Classrom>> getClassrooms(int id);

  Future<Location> addNewLocation(Location location);

  Future<List<Location>> getLocations();

  Future<Comment> commentLocation(CommentParam commentParam);

  Future<Comment> commentClassroom(CommentParam commentParam);
}

class MapDatasourceImpl extends MapDatasource {
  MapDatasourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<List<Comment>> getCommentsLocation(int id) async {
    final response = await dio.get('/comment/location/$id');
    print(response);
    List<Comment> commentList = [];
    response.data.forEach((element) => commentList.add(CommentModel.fromJson(element)));
    return commentList;
  }

  @override
  Future<Comment> commentLocation(CommentParam commentParam) async {
    final response = await dio.post('/comment/location/${commentParam.id}', data: {
      "text" : commentParam.comment
    });
    return CommentModel.fromJson(response.data);
  }

  @override
  Future<Comment> commentClassroom(CommentParam commentParam) async {
    final response = await dio.post('/comment/auditory/${commentParam.id}', data: {
      "text" : commentParam.comment
    });
    return CommentModel.fromJson(response.data);
  }

  @override
  Future<List<Comment>> getClassroomComments(int id) async {
    final response = await dio.get('/comment/auditory/$id');

    List<Comment> commentList = [];
    response.data.forEach((element) => commentList.add(CommentModel.fromJson(element)));
    return commentList;
  }

  @override
  Future<List<Classrom>> getClassrooms(int id) async {
    final response = await dio.get('/auditory/location/$id');
    List<Classrom> classromList = [];
    response.data.forEach((element) => classromList.add(ClassromModel.fromJson(element)));
    return classromList;
  }

  @override
  Future<Location> addNewLocation(Location location) async {
    final response = await dio.post('location/user', data: {
      "name": location.name,
      "latitude": location.latitude,
      "longitude": location.longitude,
      "type": location.type,
      "description": location.description,
    });
    return LocationModel.fromJson(response.data);
  }

  @override
  Future<List<Location>> getLocations() async {
    final response = await dio.get('/location/user');
    List<Location> locationList = [];
    response.data.forEach((element) => locationList.add(LocationModel.fromJson(element)));
    return locationList;
  }
}