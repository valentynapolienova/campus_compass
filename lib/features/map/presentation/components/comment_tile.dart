import 'package:flutter/material.dart';
import 'package:int20h/core/helper/images.dart';
import 'package:int20h/core/style/border_radiuses.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/style/text_styles.dart';
import 'package:int20h/features/map/domain/entities/comment.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({Key? key, required this.comment}) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: comment.isMyComment != true ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        comment.isMyComment != true ? const CircleAvatar(
          backgroundColor: CColors.white,
          backgroundImage: AssetImage(PngIcons.student),
          radius: 25,
        ) : const SizedBox(width: 35,),
        const SizedBox(width: 8,),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration:  BoxDecoration(
              color: comment.isMyComment != true ? CColors.lightGrey : CColors.lightGreen,
              borderRadius: CBorderRadius.all12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(comment.user?.name ?? 'User',  style: gilroy.w400.s13.black,),
                const SizedBox(height: 8,),
                Text(comment.text ?? '', style: gilroy.s15.black.w500,),
              ],
            ),
          ),
        )
      ],
    );
  }
}
