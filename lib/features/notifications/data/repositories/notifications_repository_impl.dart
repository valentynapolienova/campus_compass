import 'package:int20h/features/notifications/data/datasource/notifications_datasource.dart';
import 'package:int20h/features/notifications/domain/repositories/notifications_repository.dart';

class NotificationsRepositoryImpl extends NotificationsRepository {
  final NotificationsDatasource notificationsDatasource;

  NotificationsRepositoryImpl({required this.notificationsDatasource,});

}