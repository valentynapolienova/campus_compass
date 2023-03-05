import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:int20h/features/map/domain/entities/classrom.dart';
import 'package:int20h/features/map/domain/repositories/map_repository.dart';
import 'package:int20h/features/schedule/data/repositories/schedule_repository_impl.dart';
import 'package:int20h/features/schedule/domain/entities/schedule_item.dart';
import 'package:int20h/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:meta/meta.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit({required this.repository, required this.mapRepository})
      : super(ScheduleInitial());

  final ScheduleRepository repository;
  final MapRepository mapRepository;

  Future getSchedule() async {
    final result = await repository.getSchedule();
    emit(
      result.fold(
        (l) => ScheduleFailure(),
        (data) => ScheduleSuccess(
          schedule: data,
          groupedSchedule: getGroupedEvents(data),
        ),
      ),
    );
  }

  Map<String, List<ScheduleItem>> getGroupedEvents(List<ScheduleItem> events) {
    Map<String, List<ScheduleItem>> groupedEvents = {};
    groupedEvents = groupBy(events, (o) => o.dayOfWeek ?? '');
    return groupedEvents;
  }

  Future getClassrooms(int id) async {
    final result = await mapRepository.getClassrooms(id);
    emit(result.fold(
        (failure) => ScheduleSuccess(
            schedule: state.schedule, groupedSchedule: state.groupedSchedule),
        (data) => ScheduleSuccess(
            schedule: state.schedule,
            groupedSchedule: state.groupedSchedule,
            classrooms: data)));
  }

  changeClassroom(int id, int classId) async {
    final result = await repository.changeEventClassroom(id, classId);
    print(result);
  }

  changeTime(String prevDate, TimeOfDay? time, int id) async {
    print(prevDate);
    print(time?.hour);
    if (time != null) {
      String newTime = prevDate.substring(0, 11) +
          time.hour.toString() +
          ':' +
          time.minute.toString() +
          ':' +
          '00' +
          '.855+00:00';
      print(newTime);
      final result = await repository.changeEventDate(id, newTime);
      print(result);
    }
  }
}
