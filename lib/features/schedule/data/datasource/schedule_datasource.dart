import 'package:int20h/features/schedule/data/models/notification_model.dart';
import 'package:int20h/features/schedule/domain/entities/notification.dart';
import 'package:int20h/features/schedule/data/models/schedule_item_model.dart';
import 'package:int20h/features/schedule/domain/entities/schedule_item.dart';
import 'package:dio/dio.dart';

abstract class ScheduleDatasource {
  Future<ScheduleItem> changeEventDate(int id, String newDate);
  Future<ScheduleItem> changeEventClassroom(int id, int classId);
  Future<List<Notification>> getNotifications();
  Future<List<ScheduleItem>> getSchedule();
}

class ScheduleDatasourceImpl extends ScheduleDatasource {
  ScheduleDatasourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<ScheduleItem> changeEventDate(int id, String newDate) async {
    final response = await dio.put('/event', data: {"date": newDate, "id": id});

    return ScheduleItemModel.fromJson(response.data);
  }

  @override
  Future<ScheduleItem> changeEventClassroom(int id, int classId) async {
    final response = await dio.put('/event', data: { "auditory": {
      "id": classId
    }, "id": id});

    return ScheduleItemModel.fromJson(response.data);
  }

  @override
  Future<List<Notification>> getNotifications() async {
    final response = await dio.get('/userNotifications/user');
    print(response);
    List<Notification> notificationList = [];
    response.data.forEach(
        (element) => notificationList.add(NotificationModel.fromJson(element)));
    return notificationList;
  }

  @override
  Future<List<ScheduleItem>> getSchedule() async {
    final response = await dio.get('/schedule');
    List<ScheduleItem> scheduleItemList = [];
    response.data["events"].forEach(
        (element) => scheduleItemList.add(ScheduleItemModel.fromJson(element)));
    return scheduleItemList;
  }
}
