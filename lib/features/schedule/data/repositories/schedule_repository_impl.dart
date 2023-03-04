import 'package:int20h/features/schedule/data/datasource/schedule_datasource.dart';
import 'package:int20h/features/schedule/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  final ScheduleDatasource scheduleDatasource;

  ScheduleRepositoryImpl({required this.scheduleDatasource,});

}