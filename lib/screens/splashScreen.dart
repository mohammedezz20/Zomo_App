import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:zomo/Shared/cubit/themecubit/themecubit.dart';
import 'package:zomo/Shared/cubit/themecubit/themestate.dart';
import 'package:zomo/res/assets_res.dart';

import '../Shared/network/remote/auth.dart';
import '../Shared/styles/colores.dart';
import 'Login.dart';
import 'authScreen.dart';
import 'HomeLayout/mianScreen.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AuthScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, AppThemeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                children: [
                  Spacer(
                    flex: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 60.w,
                            height: 60.h,
                            decoration: BoxDecoration(
                              color: lightBackgroundColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          Image.asset(
                            AssetsRes.LOGO,
                            height: 65.h,
                            width: 65.w,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text("Zomo",
                            style: Theme.of(context).textTheme.bodyLarge),
                      )
                    ],
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Container(
                    height: 66,
                    width: 66,
                    child: LoadingIndicator(
                        indicatorType: Indicator.ballRotateChase,
                        colors: [Colors.blue],
                        strokeWidth: 2,
                        backgroundColor: ThemeCubit.obj(context).isDark
                            ? darkBackgroundColor
                            : lightBackgroundColor,
                        pathBackgroundColor: Colors.white),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
