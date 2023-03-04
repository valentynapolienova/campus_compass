import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/features/profile/presentation/profile_screen.dart';
import 'package:int20h/features/sign_up/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:int20h/injection_container.dart';

import 'components/bottom_nav_bar.dart';
import 'cubit/bottom_nav_bar_cubit.dart';

class BottomNavBarParentScreen extends StatefulWidget {
  const BottomNavBarParentScreen({Key? key, required this.authCubit})
      : super(key: key);

  final AuthCubit authCubit;

  @override
  State<BottomNavBarParentScreen> createState() =>
      _BottomNavBarParentScreenState();
}

class _BottomNavBarParentScreenState extends State<BottomNavBarParentScreen> {
  late final List<Widget> pages = [
    Scaffold(),
    Scaffold(),
    Scaffold(),
    ProfileScreen(authCubit: widget.authCubit),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      bloc: sl(),
      builder: (context, state) {
        return Scaffold(
          backgroundColor: CColors.white,
          bottomNavigationBar: BottomNavBar(),
          body: pages[state.currentIndex],
        );
      },
    );
  }
}
