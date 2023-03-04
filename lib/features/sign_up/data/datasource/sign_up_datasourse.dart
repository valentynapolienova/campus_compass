import 'package:int20h/features/sign_up/data/models/group_model.dart';
import 'package:int20h/features/sign_up/domain/entities/group.dart';
import 'package:int20h/features/sign_up/data/models/university_model.dart';
import 'package:int20h/features/sign_up/domain/entities/university.dart';

import 'package:dio/dio.dart';
import 'package:int20h/features/sign_up/data/models/auth_response_model.dart';
import 'package:int20h/features/sign_up/domain/entities/auth_response.dart';

abstract class SignUpDatasource {

  Future<List<Group>> getGroups(int id);

  Future<List<University>> getUniversities();
  Future<AuthResponse> signUp(String name, String email, String password, int groupId);
}

class SignUpDatasourceImpl implements SignUpDatasource {
  final Dio dio;

  @override
  Future<List<Group>> getGroups(int id) async {
    final response = await dio.get('/group/university/$id');

    List<Group> groupList = [];
    response.data.forEach((element) => groupList.add(GroupModel.fromJson(element)));
    return groupList;
  }

  @override
  Future<List<University>> getUniversities() async {
    final response = await dio.get('/university');

    List<University> universityList = [];
    response.data.forEach((element) => universityList.add(UniversityModel.fromJson(element)));
    return universityList;
  }

  SignUpDatasourceImpl({required this.dio});

  @override
  Future<AuthResponse> signUp(
      String name, String email, String password, int groupId) async {
    final response = await dio.post('/auth/register',
        data: {"email": email, "password": password, "name": name, "groupId" : groupId});
    return AuthResponseModel.fromJson(response.data);
  }
}
