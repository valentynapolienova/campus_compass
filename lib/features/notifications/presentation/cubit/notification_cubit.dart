import 'package:bloc/bloc.dart';
import 'package:int20h/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:int20h/features/schedule/domain/entities/notification.dart';
import 'package:int20h/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({required this.repository}) : super(NotificationInitial());

  final ScheduleRepository repository;

  Future getNotifications() async {
    final result = await repository.getNotifications();
    emit(result.fold((l) => NotificationFailure(),
        (r) => NotificationSuccess(notifications: r)));
  }
}
