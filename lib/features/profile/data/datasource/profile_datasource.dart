import 'package:int20h/features/profile/data/models/user_model.dart';
import 'package:int20h/features/profile/domain/entities/user.dart';
import 'package:dio/dio.dart';

abstract class ProfileDatasource {

  Future<User> getUser();
}

class ProfileDatasourceImpl extends ProfileDatasource {
  ProfileDatasourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<User> getUser() async {
    final response = await dio.get('/user');
    User user = UserModel.fromJson(response.data);
    return user;
  }
}