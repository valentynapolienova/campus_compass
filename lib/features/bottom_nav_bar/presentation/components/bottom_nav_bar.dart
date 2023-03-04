import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:int20h/core/style/colors.dart';
import 'package:int20h/core/style/text_styles.dart';
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
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            backgroundColor: Colors.white,
            elevation: 10,
            selectedItemColor: CColors.black,
            selectedLabelStyle: gilroy.s13.w700.black,
            unselectedLabelStyle: gilroy.s12.w500.grey,
            unselectedItemColor: CColors.grey,
            currentIndex: state.currentIndex,
              onTap: (index){
                sl<BottomNavBarCubit>().changeIndex(index);
              },
              items: navBarItems);
        });
  }

  List<BottomNavigationBarItem> navBarItems = [
      const BottomNavigationBarItem(icon: Icon(Icons.schedule_outlined), label: 'Schedule'),
      const BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Explore'),
      const BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: 'Notifications'),
      const BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined), label: 'Profile'),

  ];

}
