import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:int20h/core/helper/images.dart';
import 'package:int20h/core/style/border_radiuses.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/style/paddings.dart';
import 'package:int20h/core/style/text_styles.dart';
import 'package:int20h/core/widgets/app_bars/base_app_bar.dart';
import 'package:int20h/features/map/domain/entities/classrom.dart';
import 'package:int20h/features/map/domain/entities/location.dart';
import 'package:int20h/features/map/presentation/comments_classroom_screen.dart';
import 'package:int20h/features/map/presentation/components/comment_text_field.dart';
import 'package:int20h/features/map/presentation/components/comment_tile.dart';
import 'package:int20h/features/map/presentation/cubit/map_cubit.dart';
import 'package:int20h/injection_container.dart';

class LocationDetails extends StatelessWidget {
  LocationDetails({Key? key, required this.location}) : super(key: key);

  final Location location;

  @override
  Widget build(BuildContext context) {
    return location.type == 'UNI_BUILDING'
        ? DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: CColors.white,
              appBar: const BaseAppBar(
                title: 'Details',
                isBackButton: true,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 36,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: CColors.white,
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(color: CColors.borderGrey),
                      ),
                      child: TabBar(
                        tabs: [
                          Tab(
                            child: Text(
                              "Details",
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Classrooms",
                            ),
                          ),
                        ],
                        labelStyle: gilroy.w700,
                        unselectedLabelStyle: gilroy.w500,
                        labelColor: CColors.white,
                        unselectedLabelColor: CColors.black,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: CColors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: tabPages,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: CColors.white,
            appBar: const BaseAppBar(
              title: 'Details',
              isBackButton: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: tabPages[0],
            ),
          );
  }

  late List<Widget> tabPages = [
    Details(location: location),
    Audiences(id: location.id ?? -1),
  ];
}

class Details extends StatefulWidget {
  const Details({Key? key, required this.location}) : super(key: key);

  final Location location;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String comment = '';
  late TextEditingController controller;

  @override
  void initState() {
    sl<MapCubit>().getLocationComments(widget.location.id ?? -1);
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    sl<MapCubit>().cleanLocationComments();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: BlocBuilder<MapCubit, MapState>(
          bloc: sl(),
          builder: (context, state) {
            return state is MapSuccess
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: CBorderRadius.all12,
                            child: widget.location.imgUrl != null
                                ? Image.network(
                                    widget.location.imgUrl!,
                                    height: 250,
                                    width: double.infinity,
                                    fit: BoxFit.fitWidth,
                                  )
                                : Image.asset(
                                    PngImages.location,
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.fitWidth,
                                  )),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${widget.location.name}  ${getEmoji(widget.location.type)}',
                          style: gilroy.w700.black.s20,
                        ),
                        widget.location.description != null &&
                                widget.location.description!.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  widget.location.description!,
                                  style: gilroy.s18.w500.black,
                                ))
                            : const SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Comments',
                          style: gilroy.w700.black.s20,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ...List.generate(
                          state.locationComments.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: CommentTile(
                                comment: state.locationComments[index]),
                          ),
                        ),
                        CommentTextField(
                            controller: controller,
                            onChanged: (s) {
                              setState(() {
                                comment = s;
                              });
                            },
                            hintText: 'Comment...',
                            onTap: () {
                              sl<MapCubit>().commentLocation(
                                  widget.location.id ?? -1, comment);
                              controller.clear();
                            }),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                : const SizedBox();
          }),
    );
  }

  String getEmoji(String? type) {
    String emoji = '';
    switch (type) {
      case "GYM":
        emoji = '💪';
        break;
      case "CANTEEN":
        emoji = '🍔';
        break;
      case "UNI_BUILDING":
        emoji = '🎓';
        break;
      default:
        emoji = '✨';
        break;
    }
    return emoji;
  }
}

class Audiences extends StatefulWidget {
  const Audiences({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<Audiences> createState() => _AudiencesState();
}

class _AudiencesState extends State<Audiences> {
  @override
  void initState() {
    sl<MapCubit>().getClassrooms(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      bloc: sl(),
      builder: (context, state) {
        return state is MapSuccess
            ? SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    state.classrooms.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ClassroomTile(
                        classrom: state.classrooms[index],
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }
}

class ClassroomTile extends StatelessWidget {
  const ClassroomTile({Key? key, required this.classrom}) : super(key: key);

  final Classrom classrom;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CommentsClassroomScreen(id: classrom.id ?? -1),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: CColors.white,
          border: Border.all(color: CColors.borderGrey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: CColors.lightGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.school_rounded,
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
                    classrom.name ?? 'Classroom',
                    style: gilroy.s16.w500.black,
                  ),
                  classrom.description != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            classrom.description!,
                            style: gilroy.s14.w500.grey,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(5, 6, 4, 6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: CColors.grey, width: 1),
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
    );
  }
}
