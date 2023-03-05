part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationSuccess extends NotificationState {
  List<Notification> notifications;

  NotificationSuccess({this.notifications = const []});
}

class NotificationFailure extends NotificationState {}
