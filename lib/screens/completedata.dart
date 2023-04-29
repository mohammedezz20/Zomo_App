import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zomo/Shared/cubit/AppCubit.dart';
import 'package:zomo/Shared/cubit/Appstates.dart';
import 'package:zomo/Shared/cubit/Logincubit/loginstate.dart';
import 'package:zomo/Shared/styles/colores.dart';
import 'package:zomo/res/assets_res.dart';
import 'package:zomo/screens/authScreen.dart';

import '../Shared/component.dart';
import '../Shared/cubit/Logincubit/logincubit.dart';
import '../Shared/cubit/themecubit/themecubit.dart';
import '../widget/Snackbar.dart';
import '../widget/meeting item.dart';

class CompleteDataScreen extends StatelessWidget {
  const CompleteDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return BlocConsumer<Logincubit, LoginStates>(
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
                          "Fill Your Profile",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Spacer(
                          flex: 7,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 200.h,
                            width: 200.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 2,color: iconColor),
                                image: DecorationImage(
                                  image: FileImage(File(
                                      Logincubit.obj(context).imageFile.path)),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Positioned(
                            bottom: 5.h,
                            right: 5.w,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      backgroundColor:
                                          ThemeCubit.obj(context).isDark
                                              ? darkBackgroundColor
                                              : lightBackgroundColor,
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              'Pick Image From',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                            SizedBox(height: 16.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Logincubit.obj(context)
                                                        .imageSelector(
                                                            context, "gallery");
                                                    Navigator.pop(context);
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                buttonColor),
                                                  ),
                                                  child: Text('Gallery'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Logincubit.obj(context)
                                                        .imageSelector(
                                                            context, "camera");
                                                    Navigator.pop(context);
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                buttonColor),
                                                  ),
                                                  child: Text('Camera'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 40.h,
                                width: 40.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: buttonColor,
                                    border: Border.all(
                                        color: Colors.white, width: 2)),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
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
                            Logincubit.obj(context).registernameController,
                        keyboardtype: TextInputType.text,
                        lable: 'Full name',
                        ispass: false,
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    defaultButton(
                      function: () {
                        if (Logincubit.obj(context)
                                .registernameController
                                .text ==
                            '') {
                          ShowSnackBar(
                              context: context, text: "Name mustn't be empty");
                        } else {
                          var downloadurl = Logincubit.obj(context)
                              .firebase
                              .uploadImageToFirebase(
                                  Logincubit.obj(context).file);
                          Logincubit.obj(context).auth.signUpWithEmail(
                              Logincubit.obj(context)
                                  .registerEmailController
                                  .text,
                              Logincubit.obj(context)
                                  .registerPasswordController
                                  .text,
                              context,
                              Logincubit.obj(context)
                                  .registernameController
                                  .text,
                              downloadurl);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AuthScreen()));
                          Logincubit.obj(context).registerEmailController.text='';
                          Logincubit.obj(context).registerPasswordController.text='';
                          Logincubit.obj(context).registernameController.text='';
                        }
                      },
                      text: 'Signup',
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
