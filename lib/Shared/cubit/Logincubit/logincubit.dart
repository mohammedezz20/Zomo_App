





import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zomo/res/assets_res.dart';

import '../../network/remote/FireStoremethod.dart';
import '../../network/remote/auth.dart';
import 'loginstate.dart';

class Logincubit extends Cubit<LoginStates> {
  Logincubit():super(LoginInitialState());
  static Logincubit obj(context) => BlocProvider.of(context);
var loginEmailController =TextEditingController();
var loginPasswordController =TextEditingController();
var registerEmailController =TextEditingController();
var registerPasswordController =TextEditingController();
var registernameController =TextEditingController();

Auth auth=Auth();
  FireStoreMethods firebase=FireStoreMethods();
var showpassword=true;
var icon=Icons.visibility_off_outlined;
  dynamic changpasswordstate(){
    showpassword=!showpassword;
    if(icon==Icons.visibility_off_outlined)icon=Icons.visibility_outlined;
    else icon=Icons.visibility_off_outlined;
    emit(changePasswordVisibiltyState());
  }

  XFile imageFile = XFile("https://firebasestorage.googleapis.com/v0/b/zomo-app-ed5e4.appspot.com/o/images%2FSecond_Logo.png?alt=media&token=afed0fe0-46d9-4342-abb7-92e8238bb725");
  File? file;

  Future<void> imageSelector(BuildContext context, String pickerType) async {
    switch (pickerType) {
      case "gallery":
        imageFile = (await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 90,
        ))!;
        break;
      case "camera":
        imageFile = (await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 90,
        ))!;
        break;
    }

    if (imageFile != null) {
      file = File(imageFile.path);
      print("You selected image : " + imageFile.path);
      emit(pickImageState());
    } else {
      print("You have not taken an image");
      emit(pickImagefaildState("You have not taken an image"));
    }
  }

}
