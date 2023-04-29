import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:zomo/Shared/cubit/themecubit/themestate.dart';
import 'package:zomo/Shared/styles/colores.dart';
import '../Shared/cubit/themecubit/themecubit.dart';

class MeetingItem extends StatelessWidget {
  var timestamp;
  var roomName;
  var roomID;

  MeetingItem({
    required this.timestamp,
    required this.roomName,
    required this.roomID,
  });

  late String dateString;
  late String timeString;
  StringgetFormattedDate() {
    String dateString =
        DateFormat('MMM dd, yyyy').format(timestamp.toDate()).toString();
    return dateString;
  }

  StringgetFormattedTime() {
    String timeString = DateFormat.jm().format(timestamp.toDate()).toString();
    int x = timeString.indexOf(" ");
    String strWithNewLine =
        timeString.substring(0, x) + '\n' + timeString.substring(x);
    return strWithNewLine;
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
          return Row(
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
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Text(
                      getdateinfo() + StringgetFormattedDate(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 12,
                          color: cubit.isDark
                              ? Color(0xffE1E1E1)
                              : Color(0xff414141)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      roomName.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: !cubit.isDark
                              ? Color(0xff212121)
                              : Color(0xffffffff)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Text("Meeting ID : " + roomID.toString(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontSize: 12,
                            color: cubit.isDark
                                ? Color(0xffE1E1E1)
                                : Color(0xff414141))),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                height: 25.h,
                width: 80.w,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff246BFD), width: 1),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Text("Completed",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Color(0xff246BFD), fontSize: 9)),
                ),
              )
            ],
          );
        });
  }
}

class Separatoritem extends StatelessWidget {
  const Separatoritem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: iconColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
