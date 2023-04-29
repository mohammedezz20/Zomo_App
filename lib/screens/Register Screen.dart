import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:zomo/Shared/cubit/Logincubit/logincubit.dart';
import 'package:zomo/Shared/cubit/Logincubit/loginstate.dart';
import 'package:zomo/res/assets_res.dart';
import 'package:zomo/screens/Login.dart';
import '../Shared/network/remote/auth.dart';
import '../Shared/component.dart';
import '../Shared/cubit/themecubit/themecubit.dart';
import '../Shared/cubit/themecubit/themestate.dart';
import '../Shared/styles/colores.dart';
import '../widget/Snackbar.dart';
import 'completedata.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Logincubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              body: SingleChildScrollView(
                child: Center(
                    child: BlocConsumer<ThemeCubit, AppThemeState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 110.h,
                            ),
                            Image.asset(
                              AssetsRes.SECOND_LOGO,
                              height: 100.h,
                              width: 100.w,
                            ),
                            SizedBox(
                              height: 55.h,
                            ),
                            Text(
                              "Create New Account",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8),
                              child: defaulttextFaild(
                                fillcolor: ThemeCubit.obj(context).isDark?darktextfieldColor:lighttextfieldColor,
                                height: 60.h,
                                prefixicon: Icons.email_rounded,
                                controller: Logincubit.obj(context).registerEmailController,
                                keyboardtype: TextInputType.text,
                                lable: 'email',
                                ispass: false,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8),
                              child: defaulttextFaild(
                                  fillcolor: ThemeCubit.obj(context).isDark?darktextfieldColor:lighttextfieldColor,
                                  height: 60.h,
                                  prefixicon: Icons.lock,
                                  controller: Logincubit.obj(context).registerPasswordController,
                                  keyboardtype: TextInputType.text,
                                  lable: 'password',
                                  ispass: Logincubit.obj(context).showpassword,
                                  suffixicon:Logincubit.obj(context).icon,
                              suffixpressed:() {
                            Logincubit.obj(context).changpasswordstate();
                          }),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8),
                              child: defaultButton(
                                function: () async {
                                 if(Logincubit.obj(context).registerEmailController.text==''||
                                     Logincubit.obj(context).registerPasswordController.text==''
                                 )
                                   {
                                     ShowSnackBar(
                                         context: context,
                                         text: "Email & Password mustn't be empty");
                                   }
                                  else {
                                   String text=await Logincubit.obj(context)
                                       .auth
                                       .checkEmail(Logincubit.obj(context)
                                       .registerEmailController
                                       .text.trim());

                            bool isweek= await Logincubit.obj(context)
                                .auth
                                .isPasswordWeak(Logincubit.obj(context)
                                .registerPasswordController
                                .text);
                            if (text!='Email address is available.') {
                              ShowSnackBar(
                                  context: context,
                                  text:text );
                            }else  if (isweek) {
                              ShowSnackBar(
                                  context: context,
                                  text: "Password is to weeek.");
                            }
                            else {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CompleteDataScreen()));
                            }
                          }
                        },
                                text: 'Continue',
                                radius: 50,
                                background: buttonColor,
                                isupper: false,
                              ),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 1,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    color: iconColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                Text("or continue with", style: Theme.of(context).textTheme.labelSmall,),
                                Container(
                                  height: 1,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    color: iconColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            InkWell(
                              onTap: (){
                                Logincubit.obj(context).auth.Sign_in_with_google(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 8),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: buttonColor,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    children: [
                                      Spacer(
                                        flex: 2,
                                      ),
                                      Image.asset(AssetsRes.GOOGLE_LOGO),
                                      Spacer(
                                        flex: 1,
                                      ),
                                      Text(
                                        "Sign in with Google",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Spacer(
                                        flex: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an account?",style: Theme.of(context).textTheme.labelSmall,),
                                TextButton(onPressed: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                }, child: Text("Sign in",style:TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue,
                                ),))
                              ],
                            )
                          ],
                        );
                      },
                    )),
              ));
        });
  }
}
