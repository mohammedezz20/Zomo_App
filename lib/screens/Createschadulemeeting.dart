import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:zomo/Shared/cubit/AppCubit.dart';
import 'package:zomo/Shared/cubit/Appstates.dart';
import 'package:zomo/Shared/styles/colores.dart';
import '../Shared/component.dart';
import '../Shared/cubit/themecubit/themecubit.dart';
import '../Shared/network/remote/NotificationServices.dart';
import '../widget/meeting item.dart';

class CreateScheduleMeeting extends StatelessWidget {
  const CreateScheduleMeeting({Key? key}) : super(key: key);

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
                              AppCubit.get(context)
                                  .scheduleMeetingController
                                  .text = '';
                              AppCubit.get(context).selectedDate =
                                  DateTime.now();
                              AppCubit.get(context).selectedTime = TimeOfDay(
                                  hour: DateTime.now().hour + 1, minute: 0);
                              Navigator.pop(context);
                            },
                            child: Icon(FontAwesomeIcons.arrowLeft,
                                size: 20, color: iconColor)),
                        Spacer(
                          flex: 1,
                        ),
                        Text(
                          "Schedule Meeting",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Spacer(
                          flex: 3,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
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
                        controller:
                            AppCubit.get(context).scheduleMeetingController,
                        keyboardtype: TextInputType.text,
                        lable:
                            "${AppCubit.get(context).auth.user.displayName}'s Meeting",
                        ispass: false,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Separatoritem(),
                    Row(
                      children: [
                        Text(
                          "Date",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 20),
                        ),
                        Spacer(
                          flex: 10,
                        ),
                        Text(
                          "${AppCubit.get(context).selectedDate.toString().substring(0, 10)}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 20),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: GestureDetector(
                              onTap: () {
                                AppCubit.get(context).selectDate(context);
                              },
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: ThemeCubit.obj(context).isDark
                                    ? Colors.white
                                    : Colors.black,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Time",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 20),
                        ),
                        Spacer(
                          flex: 10,
                        ),
                        Text(
                          "${AppCubit.get(context).selectedTime.toString().substring(10, 15)}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 20),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: GestureDetector(
                              onTap: () {
                                AppCubit.get(context).selectTime(context);
                              },
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: ThemeCubit.obj(context).isDark
                                    ? Colors.white
                                    : Colors.black,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    defaultButton(
                      function: () {
                        if (AppCubit.get(context)
                                .scheduleMeetingController
                                .text ==
                            '') {
                          AppCubit.get(context).scheduleMeetingController.text =
                              "${AppCubit.get(context).auth.user.displayName}'s Meeting";
                          String date = AppCubit.get(context)
                              .selectedDate
                              .toString()
                              .substring(0, 10);
                          String time = AppCubit.get(context)
                              .selectedTime
                              .format(context)
                              .toString();
                          String otherDateString = '$date $time';
                          DateTime otherDate = DateFormat('yyyy-M-d hh:mm a')
                              .parse(otherDateString);

                          Duration difference =
                              otherDate.difference(DateTime.now());
                          int days = difference.inDays;
                          int hours = difference.inHours % 24;
                          int minutes = difference.inMinutes % 60;
                          NotificationServices().scheduleNotification(
                              id: 1,
                              title:
                                  "Hi ${AppCubit.get(context).auth.user.displayName}",
                              body:

                                  "👋 Time to shine! 🌟 Join your awesome team for a productive meeting. Let’s talk about ${AppCubit.get(context).scheduleMeetingController.text} goals and strategies and brainstorm some creative ideas. 💡",
                              days: days,
                              hour: hours,
                              minutes: minutes);
                          AppCubit.get(context).addSchedule(context);
                          AppCubit.get(context).scheduleMeetingController.text =
                              '';
                          AppCubit.get(context).selectedDate = DateTime.now();
                          AppCubit.get(context).selectedTime = TimeOfDay(
                              hour: DateTime.now().hour + 1, minute: 0);
                          Navigator.pop(context);
                        } else {
                          String date = AppCubit.get(context)
                              .selectedDate
                              .toString()
                              .substring(0, 10);
                          String time = AppCubit.get(context)
                              .selectedTime
                              .format(context)
                              .toString();
                          String otherDateString = '$date $time';
                          DateTime otherDate = DateFormat('yyyy-M-d hh:mm a')
                              .parse(otherDateString);

                          Duration difference =
                              otherDate.difference(DateTime.now());
                          int days = difference.inDays;
                          int hours = difference.inHours % 24;
                          int minutes = difference.inMinutes % 60;
                          NotificationServices().scheduleNotification(
                              id: 1,
                              title:
                                  "Hi ${AppCubit.get(context).auth.user.displayName}",
                              body:
                                  "👋 Hey, it’s time to shine! 🌟 Don’t miss the chance to join your awesome team for a productive meeting. ",
                              days: days,
                              hour: hours,
                              minutes: minutes);
                          AppCubit.get(context).addSchedule(context);
                          AppCubit.get(context).scheduleMeetingController.text =
                              '';
                          AppCubit.get(context).selectedDate = DateTime.now();
                          AppCubit.get(context).selectedTime = TimeOfDay.now();
                          Navigator.pop(context);
                        }
                      },
                      text: 'Schedule',
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
