import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:zomo/Shared/cubit/AppCubit.dart';

import '../Shared/component.dart';
import '../Shared/cubit/themecubit/themecubit.dart';
import '../Shared/cubit/themecubit/themestate.dart';
import '../Shared/styles/colores.dart';
import '../screens/scheduledMeetingDetails.dart';

class ScheduledmeetingItem extends StatelessWidget {
  var timestamp;
  var roomName;
  var roomID;
  var time;
  var id;

  ScheduledmeetingItem({
    required this.timestamp,
    required this.roomName,
    required this.roomID,
    required this.time,
    required this.id,
  });

  late String dateString;
  late String timeString;
  StringgetFormattedDate() {
    String dateString =
        DateFormat('MMM dd, yyyy').format(timestamp.toDate()).toString();
    return dateString;
  }

  StringgetFormattedTime() {
   int val =time.toString().indexOf(' ');
   String newTime=time.toString().replaceFirst(' ', "\n",0);
   return newTime;
  }

  String getdateinfo() {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));

    String day = '';
    if (StringgetFormattedDate() == DateFormat('MMM dd, yyyy').format(now)) {
      day = "Today, ";
    } else if (StringgetFormattedDate() ==
        DateFormat('MMM dd, yyyy').format(yesterday)) {
      day = "Yasterday, ";
    }
    return day;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, AppThemeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ThemeCubit.obj(context);
          return MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScheduledMeetingDetails(
                        time: time,
                            timestamp: timestamp,
                            roomName: roomName,
                            roomID: roomID,
                            docID: id,
                          )));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(StringgetFormattedTime(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 13,
                          color: cubit.isDark
                              ? Color(0xffE1E1E1)
                              : Color(0xff414141))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Text("Date : " + StringgetFormattedDate(),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    fontSize: 12,
                                    color: cubit.isDark
                                        ? Color(0xffE1E1E1)
                                        : Color(0xff414141))),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          roomName.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: !cubit.isDark
                                      ? Color(0xff212121)
                                      : Color(0xffffffff)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Text("Meeting ID : " + roomID.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    fontSize: 12,
                                    color: cubit.isDark
                                        ? Color(0xffE1E1E1)
                                        : Color(0xff414141))),
                      ),
                    ],
                  ),
                  defaultButton(
                      function: () {
                        AppCubit.get(context).joinmeeting(
                            roomID: roomID,
                            roomName: roomName,
                            userName: AppCubit.get(context)
                                .auth
                                .user
                                .displayName);
                        AppCubit.get(context)
                            .fireStoreMethods
                            .deleteDoc(id);
                      },
                      text: 'Join',
                      width: 70.w,
                      height: 35.h,
                      radius: 15,
                      Fsize: 13,
                      background: buttonColor,
                      isupper: false,
                      fontcolor: Colors.white),
                ],
              ),
            ),
          );
        });
  }
}
