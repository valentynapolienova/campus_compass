part of 'schedule_cubit.dart';

@immutable
abstract class ScheduleState {
  List<ScheduleItem> get schedule => [];
  Map<String, List<ScheduleItem>> get groupedSchedule => {};
}

class ScheduleInitial extends ScheduleState {}

class ScheduleSuccess extends ScheduleState {
  final List<ScheduleItem> schedule;
  final Map<String, List<ScheduleItem>> groupedSchedule;
  final List<Classrom> classrooms;

  ScheduleSuccess({
    this.schedule = const [],
    this.groupedSchedule = const {},
    this.classrooms = const [],
  });
}

class ScheduleFailure extends ScheduleState {}
