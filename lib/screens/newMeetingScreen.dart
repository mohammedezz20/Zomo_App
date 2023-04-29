import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zomo/Shared/cubit/AppCubit.dart';
import 'package:zomo/Shared/cubit/Appstates.dart';
import 'package:zomo/Shared/styles/colores.dart';

import '../Shared/component.dart';
import '../Shared/cubit/Logincubit/logincubit.dart';
import '../Shared/cubit/themecubit/themecubit.dart';
import '../widget/Snackbar.dart';
import '../widget/meeting item.dart';

class NewMeetingScreen extends StatelessWidget {
  const NewMeetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: statusBarHeight * 1.4,
                    right: 20.w,
                    left: 20.w,
                    bottom: 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(FontAwesomeIcons.arrowLeft,
                                size: 20, color: iconColor)),
                        Spacer(
                          flex: 1,
                        ),
                        Text(
                          "Create New Meeting",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Spacer(
                          flex: 6,
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Text(
                        "Meeting Topic",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: defaulttextFaild(
                        fillcolor: ThemeCubit.obj(context).isDark
                            ? darktextfieldColor
                            : lighttextfieldColor,
                        height: 60.h,
                        controller: AppCubit.get(context).createmeetingMeetingSubController,
                        keyboardtype: TextInputType.text,
                        lable: "${AppCubit.get(context).auth.user.displayName}'s Meeting",
                        ispass: false,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Text(
                        "Your Name",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: defaulttextFaild(
                        fillcolor: ThemeCubit.obj(context).isDark
                            ? darktextfieldColor
                            : lighttextfieldColor,
                        height: 60.h,
                        controller: AppCubit.get(context).createmeetingUserNameController,
                        keyboardtype: TextInputType.text,
                        lable: "${AppCubit.get(context).auth.user.displayName}",
                        ispass: false,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 10.w),
                      child: Separatoritem(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Text(
                        "Meeting Option",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Turn OFF My Video",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Spacer(),
                        Switch(
                          value: AppCubit.get(context).createMeetingIsvideomuted,
                          onChanged: (bool value) {
                            AppCubit.get(context).changeCreatevideostate();
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Turn OFF My Audio",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Spacer(),
                        Switch(
                          value: AppCubit.get(context).createMeetingIsaudiomuted,
                          onChanged: (bool value) {
                            AppCubit.get(context).changeCreateaudiostate();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    defaultButton(
                      function: () {
                        if (AppCubit.get(context)
                            .createmeetingMeetingSubController
                            .text ==''||
                            AppCubit.get(context)
                                .createmeetingUserNameController
                                .text =='') {
                         AppCubit.get(context).createmeetingMeetingSubController.text= "${AppCubit.get(context).auth.user.displayName}'s Meeting";
                         AppCubit.get(context).createmeetingUserNameController.text= "${AppCubit.get(context).auth.user.displayName}";
                         AppCubit.get(context).createNewMeeting();
                         AppCubit.get(context)
                             .createmeetingUserNameController.text='';
                         AppCubit.get(context)
                             .createmeetingMeetingSubController.text='';
                         Navigator.pop(context);
                        }
                        else{
                          AppCubit.get(context).createNewMeeting();
                          AppCubit.get(context)
                              .createmeetingMeetingSubController.text='';
                          AppCubit.get(context)
                              .createmeetingUserNameController.text='';
                          Navigator.pop(context);
                        }
                      },
                      text: 'Join',
                      radius: 50,
                      background: buttonColor,
                      isupper: false,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
