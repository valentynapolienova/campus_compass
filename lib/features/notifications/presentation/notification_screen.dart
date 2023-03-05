import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:int20h/core/helper/images.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/style/text_styles.dart';
import 'package:int20h/core/util/pixel_sizer.dart';
import 'package:int20h/core/widgets/app_bars/base_app_bar.dart';
import 'package:int20h/core/widgets/loading/loading_screen.dart';
import 'package:int20h/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:int20h/injection_container.dart';
import 'package:intl/intl.dart';
import 'package:int20h/features/schedule/domain/entities/notification.dart'
    as n;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    sl<NotificationCubit>().getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationState>(
      bloc: sl(),
      listener: (context, state) {
        if (state is NotificationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Unexpected error occurred',
                style: gilroy.s14.white.w500,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: CColors.white,
          appBar: const BaseAppBar(
            title: "Notifications",
          ),
          body: state is NotificationSuccess
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: state.notifications.isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                                state.notifications.length,
                                (index) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: NotificationTile(
                                        notification:
                                            state.notifications[index],
                                      ),
                                    )),
                          ),
                        )
                      : const NoInvites(),
                )
              : const LoadingScreen(
                  withoutBackButton: true,
                ),
        );
      },
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({Key? key, required this.notification})
      : super(key: key);

  final n.Notification notification;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(11),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: CColors.lightGrey,
          border: Border(
            left: BorderSide(
              color: CColors.green,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                notificationBody(size),
              ],
            ),
            Text(
              getFormattedTimeWeekDate(notification.date ?? ''),
              style: gilroy.w500.grey.s14,
            ),
          ],
        ),
      ),
    );
  }

  SizedBox notificationBody(Size size) {
    return SizedBox(
      width: size.width * 0.65,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notification.title ?? 'Notification',
            style: gilroy.w700.black.s16,
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            notification.description ?? '',
            style: gilroy.w500.black.s14,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  String getFormattedTimeWeekDate(String date) {
    DateTime dateTime = getDateTimeFromString(date);
    String formattedDate = DateFormat('dd.MM.yy').format(dateTime);
    return formattedDate;
  }

  DateTime getDateTimeFromString(String date) {
    return DateTime.parse(date);
  }
}

class NoInvites extends StatelessWidget {
  const NoInvites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 150.ph,
          ),
          Text(
            'You don\'t have any notifications yet',
            style: gilroy.s18.w500.black,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30.ph,
          ),
          Image.asset(
            PngIcons.noMessages,
            color: CColors.green,
            height: 150.pw,
            width: 150.pw,
          ),
          SizedBox(
            height: 30.ph,
          ),
        ],
      ),
    );
  }
}
