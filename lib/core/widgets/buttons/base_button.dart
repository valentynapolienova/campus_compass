
import 'package:flutter/material.dart';
import 'package:int20h/core/helper/widget_ext.dart';
import 'package:int20h/core/style/border_radiuses.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/style/paddings.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.onTap,
    required this.label,
    this.color,
    this.padding,
    this.isActive = true,
    this.isLoading = false,
  });

  final String label;
  final Color? color;
  final Function() onTap;
  final EdgeInsetsGeometry? padding;
  final bool isActive;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isActive ? 1 : 0.6,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: color ?? CColors.white,
          borderRadius: CBorderRadius.all10,
          onTap: () {
            if (isActive && !isLoading) {
              onTap();
            }
          },
          child: Ink(
            padding: padding ?? CPaddings.all10,
            decoration: BoxDecoration(
              color: color ?? CColors.white,
              borderRadius: CBorderRadius.all12,
            ),
            child: Center(
              child: !isLoading
                  ? Text(
                      label,
                      //style: montserrat.w700.s14.white,
                      textAlign: TextAlign.center,
                    )
                  : const SizedBox(
                      height: 17,
                      width: 17,
                      child: const CircularProgressIndicator(
                        color: CColors.white,
                        strokeWidth: 2,
                      ),
                    ),
            ),
          ),
        ).withHapticFeedback(),
      ),
    );
  }
}
