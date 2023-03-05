import 'package:int20h/features/schedule/domain/entities/notification.dart';
import 'package:int20h/core/helper/type_aliases.dart';
import 'package:int20h/features/schedule/domain/entities/schedule_item.dart';

abstract class ScheduleRepository {
  FutureFailable<ScheduleItem> changeEventDate(int id, String newDate);

  FutureFailable<ScheduleItem> changeEventClassroom(int id, int classId);

  FutureFailable<List<Notification>> getNotifications();

  FutureFailable<List<ScheduleItem>> getSchedule();
}
