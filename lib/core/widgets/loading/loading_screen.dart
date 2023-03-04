import 'package:flutter/material.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/util/pixel_sizer.dart';
import 'package:int20h/core/widgets/app_bars/base_app_bar.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key, this.withoutBackButton = false})
      : super(key: key);

  final bool withoutBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.white,
      appBar: BaseAppBar(
        isBackButton: !withoutBackButton,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 100.ph),
          child: const CircularProgressIndicator(
            color: CColors.green,
          ),
        ),
      ),
    );
  }
}
