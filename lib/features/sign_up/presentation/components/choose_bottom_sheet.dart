import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:int20h/core/helper/images.dart';
import 'package:int20h/core/helper/widget_ext.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/style/text_styles.dart';
import 'package:int20h/core/util/pixel_sizer.dart';
import 'package:int20h/core/widgets/images/icon.dart';
import 'package:int20h/core/widgets/templates/bottom_sheet_template.dart';
import 'package:int20h/features/sign_up/presentation/cubit/sign_up_cubit/sign_up_cubit.dart';


class ChooseBottomSheet extends StatelessWidget {
  const ChooseBottomSheet(
      {Key? key, required this.title, required this.options, required this.onTap, required this.cubit})
      : super(key: key);

  final String title;
  final List<String> options;
  final Function() onTap;
  final SignUpCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      bloc: cubit,
      builder: (context, state) {
        return BottomSheetTemplate(
          child: Column(
            children: [
              BottomSheetMenuHeader(
                title: title,
              ),
              SizedBox(height: 13.ph),
              Expanded(
                child: Scrollbar(
                  thickness: 4.pw,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.pw),
                      child: Column(
                        children: List.generate(
                          options.length,
                              (index) =>
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.ph),
                                child: OptionTile(
                                  isChosen: true,
                                  title: options[index],
                                  onTap: onTap,
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 13.ph),
            ],
          ),
        );
      },
    );
  }
}

class BottomSheetMenuHeader extends StatelessWidget {
  const BottomSheetMenuHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 18.pw, vertical: 12.ph),
      color: CColors.lightGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: gilroy.w700.s10.grey,
          ),
        ],
      ),
    );
  }
}

class OptionTile extends StatelessWidget {
  const OptionTile(
      {Key? key, required this.isChosen, required this.title, required this.onTap})
      : super(key: key);

  final bool isChosen;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.pw, vertical: 4.ph),
        decoration: BoxDecoration(
          color: isChosen ? CColors.lightGreen : CColors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: gilroy.w500.s14.black,
              ),
            ),
            SizedBox(
              width: 8.pw,
            ),
            isChosen
                ? const CIcon(
              iconPath: SvgIcons.checkCircle,
              color: CColors.green,
            )
                : const SizedBox(),
          ],
        ),
      ),
    ).noSplash().withHapticFeedback();
  }
}

