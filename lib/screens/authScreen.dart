


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../Shared/cubit/themecubit/themecubit.dart';
import '../Shared/network/remote/auth.dart';
import '../Shared/styles/colores.dart';
import 'Login.dart';
import 'HomeLayout/mianScreen.dart';

class AuthScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: Auth().authChanges,

        builder: ((context,snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingIndicator(
                  indicatorType: Indicator.ballRotateChase,
                  colors: [Colors.blue],
                  strokeWidth: 2,
                  backgroundColor: ThemeCubit.obj(context).isDark
                      ? darkBackgroundColor
                      : lightBackgroundColor,
                  pathBackgroundColor: Colors.white),
            );
          }
          if(snapshot.hasData) {
            return  MianScreen();
          } else {
            return  LoginScreen();
          }
        }),

      ),
    );
  }
}