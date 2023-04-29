import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:zomo/Shared/cubit/AppCubit.dart';
import 'package:zomo/Shared/cubit/Appstates.dart';
import 'package:zomo/Shared/cubit/themecubit/themecubit.dart';
import 'package:zomo/Shared/cubit/themecubit/themestate.dart';
import 'package:zomo/Shared/styles/colores.dart';

import '../../widget/optionWidget.dart';

class MianScreen extends StatelessWidget {
  MianScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var Appcubit = AppCubit.get(context);
          return BlocConsumer<ThemeCubit, AppThemeState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Scaffold(
                    bottomNavigationBar: SlidingClippedNavBar(
                      onButtonPressed: (index) {
                        Appcubit.changeScreen(index);
                      },
                      iconSize: 25,
                      activeColor: buttonColor,
                      backgroundColor: ThemeCubit.obj(context).isDark
                          ? darkBackgroundColor
                          : lightBackgroundColor,
                      inactiveColor: iconColor,
                      selectedIndex: Appcubit.currentIndex,
                      barItems: <BarItem>[
                        BarItem(
                          icon: FontAwesomeIcons.house,
                          title: 'Home',
                        ),
                        BarItem(
                          icon: FontAwesomeIcons.calendarDays,
                          title: 'Schedule',
                        ),
                        BarItem(
                          icon: FontAwesomeIcons.users,
                          title: 'Contacts',
                        ),
                        BarItem(
                          icon: Icons.settings_outlined,
                          title: 'Settings',
                        ),
                      ],
                    ),
                    body: Padding(
                      padding: EdgeInsets.only(top: statusBarHeight * 1.4),
                      child: Appcubit.screens[Appcubit.currentIndex],
                    ));
              });
        });
  }
}
