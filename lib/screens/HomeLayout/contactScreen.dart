import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zomo/Shared/cubit/AppCubit.dart';
import 'package:zomo/Shared/cubit/Appstates.dart';
import 'package:zomo/Shared/network/remote/NotificationServices.dart';
import 'package:zomo/res/assets_res.dart';

import '../../Shared/component.dart';
import '../../Shared/cubit/themecubit/themecubit.dart';
import '../../Shared/styles/colores.dart';

class ContactScreen extends StatelessWidget {
  ContactScreen({Key? key}) : super(key: key);

  var search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return DefaultTabController(
            length: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
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
                          "My Contacts",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        Spacer(
                          flex: 8,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: defaulttextFaild(
                        fillcolor: ThemeCubit.obj(context).isDark
                            ? darktextfieldColor
                            : lighttextfieldColor,
                        height: 60.h,
                        controller: search,
                        keyboardtype: TextInputType.text,
                        lable: 'Search',
                        ispass: false,
                        radius: 10,
                        prefixicon: Icons.search),
                  ),
                  TabBar(
                      unselectedLabelColor: iconColor,
                      labelColor: Color(0xff246BFD),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                      tabs: [
                        Tab(
                          text: "All Contacts",
                        ),
                        Tab(
                          text: "Starred",
                        ),
                      ]),
                  Expanded(
                    child: TabBarView(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 20),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 55.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xff246BFD), width: 2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: Text("Connect Phone Contacts",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                            color: Color(0xff246BFD),
                                            fontSize: 18)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 20),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 55.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xff246BFD), width: 2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: Text("No Starred Contact",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                            color: Color(0xff246BFD),
                                            fontSize: 18)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
