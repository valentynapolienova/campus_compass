import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:int20h/core/helper/consts.dart';
import 'package:int20h/core/helper/images.dart';
import 'package:int20h/core/helper/widget_ext.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/style/text_styles.dart';
import 'package:int20h/core/util/bottom_sheet_opener.dart';
import 'package:int20h/core/util/pixel_sizer.dart';
import 'package:int20h/core/widgets/app_bars/base_app_bar.dart';
import 'package:int20h/core/widgets/loading/loading_screen.dart';
import 'package:int20h/core/widgets/templates/bottom_sheet_template.dart';
import 'package:int20h/features/map/domain/entities/classrom.dart';
import 'package:int20h/features/profile/presentation/cubit/user/user_cubit.dart';
import 'package:int20h/features/schedule/domain/entities/schedule_item.dart';
import 'package:int20h/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:int20h/features/schedule/presentation/schedule_map_screen.dart';
import 'package:int20h/features/sign_up/presentation/components/choose_bottom_sheet.dart';
import 'package:intl/intl.dart';
import 'package:int20h/injection_container.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late ScheduleCubit cubit;

  @override
  void initState() {
    cubit = sl();
    cubit.getSchedule();
    sl<UserCubit>().getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScheduleCubit, ScheduleState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is ScheduleFailure) {
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
        return state is ScheduleSuccess
            ? Scaffold(
                appBar: const BaseAppBar(
                  title: "Schedule",
                ),
                backgroundColor: CColors.white,
                body: state.schedule.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                                state.groupedSchedule.length, (index) {
                              List<String> days =
                                  state.groupedSchedule.keys.toList();
                              List<List<ScheduleItem>> schedule =
                                  state.groupedSchedule.values.toList();
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      days[index],
                                      style: gilroy.black.w700.s20,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ...List.generate(
                                      schedule[index].length,
                                      (newIndex) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: TimeRow(
                                          number: newIndex + 1,
                                          scheduleItem: schedule[index]
                                              [newIndex],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      )
                    : const NoSchedule(),
              )
            : const LoadingScreen(
                withoutBackButton: true,
              );
      },
    );
  }
}

class TimeRow extends StatelessWidget {
  const TimeRow({
    super.key,
    required this.number,
    required this.scheduleItem,
  });

  final int number;
  final ScheduleItem scheduleItem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleCubit, ScheduleState>(
      bloc: sl(),
      builder: (context, state) {
        return Row(
          children: [
            SizedBox(
              width: 20,
              child: Text(
                number.toString(),
                style: gilroy.w500.s14.grey,
              ),
            ),
            SizedBox(
              width: 8.pw,
            ),
            Container(
              width: 1,
              color: CColors.green.withOpacity(0.5),
              height: 50,
            ),
            SizedBox(
              width: 8.pw,
            ),
            Expanded(
              child: state is ScheduleSuccess
                  ? InkWell(
                      onTap: () {
                        if (sl<UserCubit>().state.user.isTeacher == true) {
                          sl<ScheduleCubit>()
                              .getClassrooms(scheduleItem.location?.id ?? -1);
                          showCustomBottomSheet(
                              context,
                              SingleChildScrollView(
                                child: BottomSheetTemplate(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 20),
                                  child: Column(
                                    children: [
                                      ChangeTile(
                                        onTap: () {
                                          changeTime(context);
                                        },
                                        label: 'Change class time',
                                        icon: Icons.access_time_outlined,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ChangeTile(
                                        onTap: () {
                                          changeClassroom(
                                              context, state.classrooms);
                                        },
                                        label: 'Change classroom',
                                        icon: Icons.place_outlined,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                              true);
                        } else {
                          if (scheduleItem.location != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ScheduleMapScreen(
                                    location: scheduleItem.location!),
                              ),
                            );
                          }
                        }
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: CColors.white,
                          border: Border.all(color: CColors.borderGrey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  color: CColors.lightGreen,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.edit_note_sharp,
                                  color: CColors.green,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    scheduleItem.name ?? 'Class',
                                    style: gilroy.s16.w500.black,
                                  ),
                                  scheduleItem.description != null
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2.0),
                                          child: Text(
                                            scheduleItem.description!,
                                            style: gilroy.s14.w500.grey,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      : const SizedBox(),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text(
                                      getFormattedTimeWeekDate(
                                          scheduleItem.date ?? ''),
                                      style: gilroy.s14.w500.grey,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 6, 4, 6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: CColors.grey, width: 1),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: CColors.grey,
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        );
      },
    );
  }

  String getFormattedTimeWeekDate(String date) {
    DateTime dateTime = getDateTimeFromString(date);
    String formattedDate = DateFormat('hh:mm a').format(dateTime);
    return formattedDate;
  }

  DateTime getDateTimeFromString(String date) {
    return DateTime.parse(date);
  }

  changeClassroom(BuildContext context, List<Classrom> classrooms) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ChangeClassroomDialog(
            locationId: scheduleItem.location?.id ?? -1,
            name: scheduleItem.classrom?.name ?? '',
            scheduleId: scheduleItem.id ?? -1,
          );
        });
  }

/*
  Future<DateTime?> changeDate(BuildContext context) async {
    DateTime? selectedDate;
    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: Consts.firstDay,
      lastDate: Consts.lastDay,
      builder: (context, child) {
        return _darkTheme(child!, context);
      },
    );
    return selectedDate;
  }*/

  changeTime(BuildContext context) async {
    TimeOfDay? selectedTime;
    selectedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      builder: (context, child) {
        return _darkTheme(child!, context);
      },
    );
    sl<ScheduleCubit>().changeTime(
        scheduleItem.date ?? '', selectedTime, scheduleItem.id ?? -1);
  }

  Theme _darkTheme(Widget child, BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        timePickerTheme: TimePickerThemeData(
          dayPeriodTextColor: Colors.black,
          hourMinuteColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected)
                ? CColors.lightGreen
                : CColors.lightGreen,
          ),
          hourMinuteTextColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected)
                ? CColors.black
                : CColors.black,
          ),
          dialBackgroundColor: CColors.lightGreen,
        ),
        dialogBackgroundColor: CColors.white,
        colorScheme: const ColorScheme.light(
          surface: CColors.white,
          onSurface: CColors.black,
          primary: CColors.green,
          onPrimary: CColors.white,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: CColors.green,
          ),
        ),
      ),
      child: child,
    );
  }
}

class ChangeTile extends StatelessWidget {
  const ChangeTile(
      {Key? key, required this.onTap, required this.label, required this.icon})
      : super(key: key);

  final Function() onTap;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Future.delayed(const Duration(milliseconds: 10), () {
          onTap();
        });
      },
      child: Row(
        children: [
          Ink(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: CColors.lightOrange,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: CColors.orange,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            label,
            style: gilroy.black.w500.s18,
          )
        ],
      ),
    ).withHapticFeedback();
  }
}

class ChangeClassroomDialog extends StatefulWidget {
  const ChangeClassroomDialog(
      {Key? key,
      required this.locationId,
      required this.name,
      required this.scheduleId})
      : super(key: key);

  final int locationId;
  final int scheduleId;
  final String name;

  @override
  State<ChangeClassroomDialog> createState() => _ChangeClassroomDialogState();
}

class _ChangeClassroomDialogState extends State<ChangeClassroomDialog> {
  late ScheduleCubit cubit;
  late String name = widget.name;

  @override
  void initState() {
    cubit = sl();
    cubit.getClassrooms(widget.locationId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleCubit, ScheduleState>(
      bloc: cubit,
      builder: (context, state) {
        return state is ScheduleSuccess
            ? AlertDialog(
                backgroundColor: CColors.white,
                title: Text(
                  'Choose another classroom',
                  style: gilroy.s18.black.w500,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButton<String>(
                      value: name,
                      onChanged: (String? newValue) {
                        setState(() {
                          name = newValue!;
                        });
                      },
                      items: List.generate(
                        state.classrooms.length,
                        (index) => DropdownMenuItem(
                          value: state.classrooms[index].name ?? '',
                          child: Text(
                            state.classrooms[index].name ?? '',
                            style: gilroy.black.s14.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: gilroy.s14.black.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      sl<ScheduleCubit>().changeClassroom(
                          widget.scheduleId,
                          state.classrooms
                                  .firstWhere((element) => element.name == name,
                                      orElse: () => Classrom())
                                  .id ??
                              -1,
                          () {});
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Edit',
                      style: gilroy.s14.green.w400,
                    ),
                  ),
                ],
              )
            : const SizedBox();
      },
    );
  }
}

class NoSchedule extends StatelessWidget {
  const NoSchedule({Key? key}) : super(key: key);

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
            'You don\'t have an actual schedule',
            style: gilroy.s18.w500.black,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50.ph,
          ),
          Image.asset(
            PngIcons.calendar,
            color: CColors.green,
            height: 120.pw,
            width: 120.pw,
          ),
          SizedBox(
            height: 30.ph,
          ),
        ],
      ),
    );
  }
}
