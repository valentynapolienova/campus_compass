import 'package:int20h/features/schedule/domain/entities/notification.dart';
import 'package:int20h/core/error/repository_request_handler.dart';
import 'package:int20h/core/error/failures.dart';
import 'package:int20h/core/helper/type_aliases.dart';
import 'package:int20h/features/schedule/domain/entities/schedule_item.dart';
import 'package:int20h/features/schedule/data/datasource/schedule_datasource.dart';
import 'package:int20h/features/schedule/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  final ScheduleDatasource scheduleDatasource;

  ScheduleRepositoryImpl({
    required this.scheduleDatasource,
  });
  @override
  FutureFailable<ScheduleItem> changeEventDate(int id, String newDate) {
    return RepositoryRequestHandler<ScheduleItem>()(
      request: () => scheduleDatasource.changeEventDate(id, newDate),
      defaultFailure: Failure(),
    );
  }

  @override
  FutureFailable<ScheduleItem> changeEventClassroom(int id, int classId) {
    return RepositoryRequestHandler<ScheduleItem>()(
      request: () => scheduleDatasource.changeEventClassroom(id, classId),
      defaultFailure: Failure(),
    );
  }

  @override
  FutureFailable<List<Notification>> getNotifications() {
    return RepositoryRequestHandler<List<Notification>>()(
      request: () => scheduleDatasource.getNotifications(),
      defaultFailure: Failure(),
    );
  }

  @override
  FutureFailable<List<ScheduleItem>> getSchedule() {
    return RepositoryRequestHandler<List<ScheduleItem>>()(
      request: () => scheduleDatasource.getSchedule(),
      defaultFailure: Failure(),
    );
  }
}
