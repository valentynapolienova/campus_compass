
import 'package:flutter/material.dart';
import 'package:int20h/core/helper/widget_ext.dart';
import 'package:int20h/core/style/border_radiuses.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/style/paddings.dart';
import 'package:int20h/core/style/text_styles.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.onTap,
    required this.label,
    this.color,
    this.padding,
    this.isActive = true,
    this.isLoading = false,
    this.isGradient = false,
  });

  final String label;
  final Color? color;
  final Function() onTap;
  final EdgeInsetsGeometry? padding;
  final bool isActive;
  final bool isLoading;
  final bool isGradient;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isActive ? 1 : 0.6,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: color ?? CColors.green,
          borderRadius: CBorderRadius.all8,
          onTap: () {
            if (isActive && !isLoading) {
              onTap();
            }
          },
          child: Ink(
            padding: padding ?? CPaddings.all12,
            decoration: BoxDecoration(
              color: color ?? CColors.green,
              gradient: isGradient ? const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF99FDAC),
                  Color(0xff03B79C),
                ],
              ) : null,
              borderRadius: CBorderRadius.all8,
            ),
            child: Center(
              child: !isLoading
                  ? Text(
                      label,
                      style: gilroy.w700.s16.white,
                      textAlign: TextAlign.center,
                    )
                  : const SizedBox(
                      height: 17,
                      width: 17,
                      child: CircularProgressIndicator(
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
