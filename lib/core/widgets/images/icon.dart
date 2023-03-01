
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/util/pixel_sizer.dart';

// Custom Icon
class CIcon extends StatelessWidget {
  static const double defaultSize = 20;

  final double size;
  final String iconPath;
  final Color? color;

  const CIcon({
    Key? key,
    this.size = defaultSize,
    required this.iconPath,
    this.color = CColors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.ph,
      height: size.ph,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: SvgPicture.asset(
          iconPath,
          color: color,
          height: size.pw,
          width: size.pw,
        ),
      ),
    );
  }
}
