import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zomo/Shared/cubit/AppCubit.dart';
import 'package:zomo/Shared/cubit/Appstates.dart';
import 'package:zomo/Shared/cubit/themecubit/themestate.dart';
import 'package:zomo/res/assets_res.dart';

import '../../Shared/component.dart';
import '../../Shared/cubit/themecubit/themecubit.dart';
import '../../Shared/network/remote/auth.dart';
import '../../Shared/styles/colores.dart';
import '../../widget/meeting item.dart';
import '../authScreen.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {

          return BlocConsumer<ThemeCubit, AppThemeState>(
              builder: (context, state) {
                Auth auth = Auth();
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 15),
                        child: Row(
                          children: [
                            Image.asset(
                              AssetsRes.SECOND_LOGO,
                              height: 23.h,
                              width: 23.h,
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Text(
                              "Settings",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                            ),
                            Spacer(
                              flex: 8,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 15),
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 35, // or any other radius you want
                                backgroundImage: NetworkImage(auth
                                        .user.photoURL ??
                                    "https://firebasestorage.googleapis.com/v0/b/zomo-app-ed5e4.appspot.com/o/images%2FSecond_Logo.png?alt=media&token=afed0fe0-46d9-4342-abb7-92e8238bb725")),
                            SizedBox(
                              width: 15.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.6,
                                  child: Text(
                                    auth.user.displayName ?? "user",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                            fontSize: 18,
                                            overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.6,
                                  child: Text(
                                    "${auth.user.email}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Separatoritem(),
                      Row(
                        children: [
                          Icon(
                            Icons.visibility_outlined,
                            color: ThemeCubit.obj(context).isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Text(
                            "Dark Mode",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Spacer(
                            flex: 12,
                          ),
                          Switch(
                            value: AppCubit.get(context).darkSwitch,
                            onChanged: (bool value) {
                              AppCubit.get(context).changedarkSwitchstate();
                              ThemeCubit.obj(context).changeappmode();
                            },
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                builder: (context) => AuthScreen()));

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                color: Color(0xffF75555),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Text(
                                "Logout",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Color(0xffF75555),
                                    ),
                              ),
                              Spacer(
                                flex: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              listener: (context, state) {});
        },
        listener: (context, state) {});
  }
}
