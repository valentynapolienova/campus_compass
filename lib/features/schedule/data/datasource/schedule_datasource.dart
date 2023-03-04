import 'package:dio/dio.dart';

abstract class ScheduleDatasource {
}

class ScheduleDatasourceImpl extends ScheduleDatasource {
  ScheduleDatasourceImpl({required this.dio});

  final Dio dio;
}