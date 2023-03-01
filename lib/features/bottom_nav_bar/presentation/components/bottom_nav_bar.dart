import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:int20h/features/bottom_nav_bar/presentation/cubit/bottom_nav_bar_cubit.dart';
import 'package:int20h/injection_container.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        bloc: sl(),
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.currentIndex,
              onTap: (index){
                sl<BottomNavBarCubit>().changeIndex(index);
              },
              items: [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          ]);
        });
  }

}
