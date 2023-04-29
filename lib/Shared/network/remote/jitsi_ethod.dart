import 'package:flutter/foundation.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

import 'FireStoremethod.dart';
import 'auth.dart';

class JitsiMeetingMethod{
  final Auth _authMethods = Auth();
  final FireStoreMethods _fireStoreMethods = FireStoreMethods();
  void create_meeting({
    required String roomID,
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  })async{
    try{
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = true;

      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; //
      String? name;

      if (username.isEmpty) {
        name = _authMethods.user.displayName;
      } else {
        name = username;
      }

      var options = JitsiMeetingOptions(room: roomID,)..subject=roomName
        ..userDisplayName = name
        ..userEmail = _authMethods.user.email
        ..audioMuted = isAudioMuted
        ..userAvatarURL=_authMethods.user.photoURL
        ..videoMuted = isVideoMuted;

      _fireStoreMethods.addToMeetingHistory(roomName,roomID);
      await JitsiMeet.joinMeeting(
         options,
      );

    }catch(error){
      if (kDebugMode) {
        print("error: $error");
      }
    }
  }


}