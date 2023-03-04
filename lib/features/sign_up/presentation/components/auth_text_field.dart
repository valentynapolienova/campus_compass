import 'package:flutter/material.dart';
import 'package:int20h/core/style/border_radiuses.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/style/text_styles.dart';
import 'package:int20h/core/util/pixel_sizer.dart';
import 'package:int20h/core/widgets/text_fields/base_text_field.dart';


class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.hintSize = 16,
    this.enabled = true,
  });

  final String hintText;
  final Function(String) onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final double hintSize;
  final bool enabled;

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
        enabled: enabled,
        cursorColor: Colors.green,
        textAlign: TextAlign.center,
        onChanged: onChanged,
        keyboardType: keyboardType,
        style: gilroy.w500.s16.black,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: gilroy.w500.grey.copyWith(fontSize: hintSize),
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
