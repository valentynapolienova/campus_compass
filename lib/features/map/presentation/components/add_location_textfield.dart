import 'package:flutter/material.dart';
import 'package:int20h/core/style/border_radiuses.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/style/text_styles.dart';
import 'package:int20h/core/util/pixel_sizer.dart';
import 'package:int20h/core/widgets/text_fields/base_text_field.dart';


class AddLocationTextField extends StatelessWidget {
  const AddLocationTextField({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.hintSize = 16,
    this.enabled = true,
    this.initValue,
    this.hintColor,
    this.maxLines, this.minLines,
  });

  final String hintText;
  final Function(String) onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final double hintSize;
  final bool enabled;
  final String? initValue;
  final Color? hintColor;
  final int? minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.pw),
      decoration:  BoxDecoration(
        color: CColors.white,
        borderRadius: CBorderRadius.all12,
        border: Border.all(
          color: CColors.borderGrey,
        ),
      ),
      child: BaseTextField(
        minLines: minLines,
        maxLines: maxLines,
        initialValue: initValue,
        enabled: enabled,
        cursorColor: Colors.green,
        onChanged: onChanged,
        keyboardType: keyboardType,
        style: gilroy.w500.s16.black,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: gilroy.w500.copyWith(fontSize: hintSize, color: hintColor ?? CColors.grey),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        obscureText: obscureText,
        obscuringCharacter: '●',
      ),
    );
  }
}
