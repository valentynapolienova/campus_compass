import 'package:flutter/material.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/style/paddings.dart';
import 'package:int20h/core/style/text_styles.dart';
import 'package:int20h/core/util/pixel_sizer.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile(
      {Key? key,
      required this.onTap,
      required this.label,
      required this.iconColor,
      this.bgColor,
      required this.icon})
      : super(key: key);

  final String label;
  final IconData icon;
  final Color iconColor;
  final Color? bgColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: CColors.white,
          border: Border.all(color: CColors.borderGrey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: bgColor ?? CColors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              SizedBox(
                width: 10.pw,
              ),
              Text(
                label,
                style: gilroy.s15.w500.black,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(5, 6, 4, 6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: CColors.grey, width: 1),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: CColors.grey,
                      size: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
