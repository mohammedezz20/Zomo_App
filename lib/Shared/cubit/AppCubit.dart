import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zomo/Shared/network/remote/FireStoremethod.dart';
import '../../screens/HomeLayout/scheduleScreen.dart';
import '../../screens/HomeLayout/contactScreen.dart';
import '../../screens/HomeLayout/homeScreen.dart';
import '../../screens/HomeLayout/settingScreen.dart';
import '../network/remote/auth.dart';
import '../network/remote/jitsi_ethod.dart';
import 'Appstates.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  Auth auth = Auth();
  FireStoreMethods fireStoreMethods = FireStoreMethods();
  var joinmeetingidController = TextEditingController();
  var joinmeetingUserNameController = TextEditingController();
  var createmeetingUserNameController = TextEditingController();
  var createmeetingMeetingSubController = TextEditingController();

  final screens = [
    HomeScreen(),
    ScheduledScreen(),
    ContactScreen(),
    SettingScreen(),
  ];
  var currentIndex = 0;
  late PageController _pageController =
      PageController(initialPage: currentIndex);

  void changeScreen(int index) {
    currentIndex = index;
    emit(changeScreenState());
  }

  var _jitsiMeetMethods = JitsiMeetingMethod();
  var createMeetingIsvideomuted = true;
  var createMeetingIsaudiomuted = true;
  void changeCreatevideostate() {
    createMeetingIsvideomuted = !createMeetingIsvideomuted;
    emit(ChangeCreatevideoState());
  }

  void changeCreateaudiostate() {
    createMeetingIsaudiomuted = !createMeetingIsaudiomuted;
    emit(ChangeCreateaudioState());
  }

  void createNewMeeting() {
    var random = Random();
    String roomID = (random.nextInt(10000000) + 10000000).toString();
    _jitsiMeetMethods.create_meeting(
      roomID: roomID,
      roomName: createmeetingMeetingSubController.text,
      isAudioMuted: createMeetingIsaudiomuted,
      isVideoMuted: createMeetingIsvideomuted,
    );

    emit(CreateMeetingState());
  }

  var joinisvideomuted = true;
  var joinisaudiomuted = true;
  void changevideostate() {
    joinisvideomuted = !joinisvideomuted;
    emit(ChangevideoState());
  }

  void changeaudiostate() {
    joinisaudiomuted = !joinisaudiomuted;
    emit(ChangeaudioState());
  }

  void joinmeeting({roomName, roomID, userName}) {
    _jitsiMeetMethods.create_meeting(
        roomName: roomName ?? joinmeetingidController.text,
        roomID: roomID ?? joinmeetingidController.text,
        isAudioMuted: joinisaudiomuted,
        isVideoMuted: joinisvideomuted,
        username: userName ?? joinmeetingUserNameController.text);
  }

  bool isMorning = int.parse(DateFormat('HH').format(DateTime.now())) < 12;

  var darkSwitch = false;
  void changedarkSwitchstate() {
    darkSwitch = !darkSwitch;
    emit(AppchangedarkSwitchstate());
  }

  var scheduleMeetingController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: DateTime.now().hour + 1, minute: 0);
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
    emit(selectDateState());
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.inputOnly,
    );
    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
    }
    emit(selectTimeState());
  }

  addSchedule(context) {
    var random = Random();
    String roomID = (random.nextInt(10000000) + 10000000).toString();

    fireStoreMethods.addToScheduleMeetingHistory(
      meetingName: scheduleMeetingController.text,
      meetingID: roomID,
      date: selectedDate,
      time: selectedTime.format(context),
    );
  }
}
