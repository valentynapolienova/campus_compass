
import 'package:flutter/material.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/style/paddings.dart';
import 'package:int20h/core/style/text_styles.dart';
import 'package:int20h/core/util/pixel_sizer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BaseAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget? leftWidget;
  final Widget? rightWidget;
  final String? title;
  final Color? backgroundColor;
  final bool isBackButton;


  const BaseAppBar({
    Key? key,
    this.leftWidget,
    this.rightWidget,
    this.title,
    this.backgroundColor,
    this.isBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 50,
      leading: Align(
        alignment: Alignment.centerLeft,
        child: isBackButton
            ? Padding(
          padding: CPaddings.horizontal12,
              child: IconButton(
          icon: const Icon(
              Icons.arrow_back_ios,
              color: CColors.grey,
          ),
          onPressed: () {
              Navigator.pop(context);
          },
        ),
            )
            : Padding(
          padding: CPaddings.horizontal12,
          child: leftWidget,
        ),
      ),
      actions: [
        Center(
          child: Padding(
            padding: CPaddings.horizontal16,
            child: rightWidget,
          ),
        )
      ],
      title: Text(title ?? '', style: gilroy.w700.s20.black,),
      backgroundColor: backgroundColor ?? CColors.white,
      elevation: 0,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size(100.w, 50.ph);
}
