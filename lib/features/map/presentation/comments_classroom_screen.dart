import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/widgets/app_bars/base_app_bar.dart';
import 'package:int20h/features/map/presentation/components/comment_text_field.dart';
import 'package:int20h/features/map/presentation/cubit/map_cubit.dart';
import 'package:int20h/injection_container.dart';

import 'components/comment_tile.dart';

class CommentsClassroomScreen extends StatefulWidget {
  const CommentsClassroomScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<CommentsClassroomScreen> createState() => _CommentsClassroomScreenState();
}

class _CommentsClassroomScreenState extends State<CommentsClassroomScreen> {

  String comment = '';
  late MapCubit cubit;
  late TextEditingController controller;
  
  @override
  void initState() {
    controller = TextEditingController();
    cubit = sl();
    cubit.getClassroomComments(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    cubit.cleanClassroomComments();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      bloc: cubit,
  builder: (context, state) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const BaseAppBar(
          title: 'Comments',
          isBackButton: true,
        ),
        body: state is MapSuccess ? Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: List.generate(state.classroomComments.length, (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: CommentTile(
                        comment: state.classroomComments[index],
                      ),
                    )),
                  ),),),
              const SizedBox(height: 10,),
              CommentTextField(
                controller: controller,
                onTap: () {
                  cubit.commentClassroom(widget.id, comment);
                  controller.clear();
                },
                onChanged: (s) {
                setState(() {
                  comment = s;
                });
              }, hintText: 'Comment...', minLines: 1, maxLines: 5,),

              const SizedBox(height: 20,),
            ],
          ),
        ) : const SizedBox(),
      ),
    );
  },
);
  }
}

