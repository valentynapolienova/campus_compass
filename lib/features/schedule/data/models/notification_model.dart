import 'package:int20h/features/schedule/domain/entities/notification.dart';

class NotificationModel extends Notification {
  NotificationModel({super.date, super.description, super.title});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    date = json["date"];
    description = json["content"];
    title = json["subject"];
  }
}
