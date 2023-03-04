import 'package:flutter/material.dart';
import 'package:int20h/core/style/colors.dart';

class BottomSheetTemplate extends StatelessWidget {
  const BottomSheetTemplate({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: CColors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -6),
            blurRadius: 36,
            color: const Color(0xFF6B7280).withOpacity(0.25),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      child: child,
    );
  }
}
