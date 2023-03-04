import 'package:dio/dio.dart';

abstract class NotificationsDatasource {
}

class NotificationsDatasourceImpl extends NotificationsDatasource {
  NotificationsDatasourceImpl({required this.dio});

  final Dio dio;
}