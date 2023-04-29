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
import '../widget/meeting item.dart';

class ScheduledMeetingDetails extends StatelessWidget {
  var timestamp;
  var roomName;
  var roomID;
  var docID;
  var time;

  ScheduledMeetingDetails({
    required this.timestamp,
    required this.roomName,
    required this.roomID,
    required this.docID,
    required this.time,
  });

  late String dateString;
  late String timeString;
  StringgetFormattedDate() {
    String dateString =
        DateFormat('MMM dd, yyyy').format(timestamp.toDate()).toString();
    return dateString;
  }

  StringgetFormattedTime() {
    int x = time.indexOf(" ");
    String strWithNewLine =
        time.substring(0, x) + time.substring(x);
    return strWithNewLine;
  }

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
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Row(
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
                            "Meeting Details",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Spacer(
                            flex: 6,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Row(
                        children: [
                          Container(
                            width: 1.5 * MediaQuery.of(context).size.width / 6,
                            child: Text(
                              "Date ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontSize: 18),
                            ),
                          ),
                          Text(
                            ": ",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Container(
                            width: 3.7 * MediaQuery.of(context).size.width / 6,
                            child: Text(
                              "${StringgetFormattedDate()}",
                              style: Theme.of(context).textTheme.titleSmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Separatoritem(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Row(
                        children: [
                          Container(
                            width: 1.5 * MediaQuery.of(context).size.width / 6,
                            child: Text(
                              "Time ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontSize: 18),
                            ),
                          ),
                          Text(
                            ": ",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Container(
                            width: 3.7 * MediaQuery.of(context).size.width / 6,
                            child: Text(
                              "${StringgetFormattedTime()}",
                              style: Theme.of(context).textTheme.titleSmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Separatoritem(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Row(
                        children: [
                          Container(
                            width: 1.5 * MediaQuery.of(context).size.width / 6,
                            child: Text(
                              "Topic ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontSize: 18),
                            ),
                          ),
                          Text(
                            ": ",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Container(
                            width: 3.7 * MediaQuery.of(context).size.width / 6,
                            child: Text(
                              "${roomName}",
                              style: Theme.of(context).textTheme.titleSmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Separatoritem(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Row(
                        children: [
                          Container(
                            width: 1.5 * MediaQuery.of(context).size.width / 6,
                            child: Text(
                              "Meeting ID ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontSize: 16),
                            ),
                          ),
                          Text(
                            ": ",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Container(
                            width: 3.7 * MediaQuery.of(context).size.width / 6,
                            child: Text(
                              "${roomID}",
                              style: Theme.of(context).textTheme.titleSmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Separatoritem(),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child: defaultButton(
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
                              .deleteDoc(docID);

                          Navigator.pop(context);
                        },
                        text: 'Join',
                        radius: 50,
                        background: buttonColor,
                        isupper: false,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child: defaultButton(
                        function: () {
                          AppCubit.get(context)
                              .fireStoreMethods
                              .deleteDoc(docID);
                          Navigator.pop(context);
                        },
                        text: 'Delete',
                        radius: 50,
                        background: Colors.redAccent,
                        isupper: false,
                      ),
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
