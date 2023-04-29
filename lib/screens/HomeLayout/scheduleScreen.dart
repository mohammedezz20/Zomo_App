import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zomo/Shared/cubit/AppCubit.dart';
import 'package:zomo/Shared/cubit/Appstates.dart';
import 'package:zomo/Shared/network/remote/FireStoremethod.dart';
import 'package:zomo/res/assets_res.dart';
import '../../widget/meeting item.dart';
import '../../widget/scheduledmeeting.dart';

class ScheduledScreen extends StatelessWidget {
  ScheduledScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          var fireMetho = FireStoreMethods();
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
                          "Scheduled Meeting",
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
                  Expanded(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: fireMetho.schedulemeetingsHistory,
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

                            return ScheduledmeetingItem(
                              timestamp: data['Date'],
                              roomName: data['meetingName'],
                              roomID: data['meetinID'],
                              time: data['Time'],
                              id: documents[index].id,
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
            ),
          );
        },
        listener: (context, state) {});
  }
}

//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:zomo/Shared/cubit/AppCubit.dart';
// import 'package:zomo/Shared/cubit/Appstates.dart';
// import 'package:zomo/Shared/network/remote/FireStoremethod.dart';
// import 'package:zomo/res/assets_res.dart';
//
// import '../../widget/meeting item.dart';
// import '../../widget/scheduledmeeting.dart';
//
//
// class ScheduledScreen extends StatelessWidget {
//   ScheduledScreen({Key? key}) : super(key: key);
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  BlocConsumer<AppCubit,AppStates>(builder: (context,state){
//       var fireMetho=FireStoreMethods();
//       return DefaultTabController(
//         length: 2,
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 25.w),
//           child:Column(
//
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 0, vertical: 15),
//                 child: Row(
//                   children: [
//                     Image.asset(AssetsRes.SECOND_LOGO,height: 23.h,width: 23.h,),
//                     Spacer(flex: 1,),
//                     Text(
//                       "Scheduled Meeting",
//                       style: Theme.of(context).textTheme.titleSmall?.copyWith
//                         (fontSize: 22,fontWeight: FontWeight.w500),
//                     ),
//                     Spacer(flex: 8,),
//                   ],
//
//
//                 ),
//               ),
//               Expanded(
//                 child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//                   stream: fireMetho.schedulemeetingsHistory,
//                   builder: (BuildContext context,
//                       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//                     if (!snapshot.hasData) {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                     final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
//                         snapshot.data!.docs;
//                     return ListView.separated(
//                       padding: EdgeInsets.all(0),
//                       itemCount: documents.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         final Map<String, dynamic> data = documents[index].data();
//                         return ScheduledmeetingItem(
//                             timestamp: data['Date'],
//                             roomName: data['meetingName'],
//                             roomID: data['meetinID']);
//                       }, separatorBuilder: (BuildContext context, int index) =>Separatoritem(),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }, listener: (context,state){});
//   }
// }
