
import 'package:flutter/material.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/style/paddings.dart';
import 'package:int20h/core/util/pixel_sizer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BaseAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget? leftWidget;
  final Widget? rightWidget;
  final Widget? centerWidget;
  final Color? backgroundColor;
  final bool isBackButton;


  const BaseAppBar({
    Key? key,
    this.leftWidget,
    this.rightWidget,
    this.centerWidget,
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
            ? IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: CColors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
            : Padding(
          padding: CPaddings.horizontal16,
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
      title: centerWidget,
      backgroundColor: backgroundColor ?? CColors.white,
      elevation: 0,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size(100.w, 50.ph);
}
