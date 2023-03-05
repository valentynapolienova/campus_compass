import 'package:flutter/material.dart';
import 'package:int20h/core/style/border_radiuses.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/style/text_styles.dart';
import 'package:int20h/core/util/pixel_sizer.dart';
import 'package:int20h/core/widgets/text_fields/base_text_field.dart';


class CommentTextField extends StatelessWidget {
   CommentTextField({
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
     required this.onTap, this.controller,
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
  final Function onTap;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.pw),
            decoration:  const BoxDecoration(
              color: CColors.lightGrey,
              borderRadius: CBorderRadius.all12,
            ),
            child: BaseTextField(
              controller: controller,
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
          ),
        ),
        const SizedBox(width: 8,),
        InkWell(
          onTap: (){
            onTap();
          },
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: CColors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
                child: Icon(Icons.send, color: CColors.white,)
            ),
          ),
        )
      ],
    );
  }
}
