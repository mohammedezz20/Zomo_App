import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zomo/Shared/cubit/AppCubit.dart';
import 'package:zomo/Shared/cubit/Appstates.dart';
import '../../Shared/network/remote/FireStoremethod.dart';
import '../../Shared/network/remote/auth.dart';
import '../../Shared/styles/colores.dart';
import '../../widget/meeting item.dart';
import '../../widget/optionWidget.dart';
import '../Createschadulemeeting.dart';
import '../meetingScreen.dart';
import '../newMeetingScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        Auth auth = Auth();
        FireStoreMethods fireMethod = FireStoreMethods();
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 28, // or any other radius you want
                      backgroundImage: NetworkImage(auth.user.photoURL ??
                          "https://firebasestorage.googleapis.com/v0/b/zomo-app-ed5e4.appspot.com/o/images%2FSecond_Logo.png?alt=media&token=afed0fe0-46d9-4342-abb7-92e8238bb725")),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppCubit.get(context).isMorning
                            ? 'Good Morning 👋'
                            : 'Good Afternoon 👋',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        auth.user.displayName ?? "user",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: 18,
                            ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                optionWidget(
                    icon: FontAwesomeIcons.video,
                    backgroundColor: newmeetingColor,
                    text: "New Meeting",
                    h: 100.h,
                    w: 100.w,
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewMeetingScreen()));
                    }),
                optionWidget(
                    icon: FontAwesomeIcons.squarePlus,
                    backgroundColor: joinmeetingColor,
                    text: "Join",
                    h: 100.h,
                    w: 100.w,
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JoinMeetingScreen()));
                    }),
                optionWidget(
                    icon: FontAwesomeIcons.calendarDays,
                    backgroundColor: schedulemeetingColor,
                    text: "Schedule",
                    h: 100.h,
                    w: 100.w,
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateScheduleMeeting()));
                    }),
              ]),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Separatoritem(),
              ),
              Row(
                children: [
                  Text(
                    "Meeting History",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Separatoritem(),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: fireMethod.meetingsHistory,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final List<QueryDocumentSnapshot<Map<String, dynamic>>>
                        documents = snapshot.data!.docs;
                    return ListView.separated(
                      padding: EdgeInsets.all(0),
                      itemCount: documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Map<String, dynamic> data =
                            documents[index].data();

                        return MeetingItem(
                          roomID: data['meetinID'],
                          roomName: data['meetingName'],
                          timestamp: data['createdAt'],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Separatoritem(),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
