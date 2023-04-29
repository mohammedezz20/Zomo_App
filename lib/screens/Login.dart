import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zomo/Shared/cubit/Logincubit/logincubit.dart';
import 'package:zomo/Shared/cubit/Logincubit/loginstate.dart';
import 'package:zomo/res/assets_res.dart';

import '../Shared/component.dart';
import '../Shared/cubit/themecubit/themecubit.dart';
import '../Shared/cubit/themecubit/themestate.dart';
import '../Shared/network/remote/auth.dart';
import '../Shared/styles/colores.dart';
import '../widget/Snackbar.dart';
import 'Register Screen.dart';
import 'HomeLayout/mianScreen.dart';
import 'authScreen.dart';

class LoginScreen extends StatelessWidget {
  final Auth _auth=Auth();
   LoginScreen({Key? key}) : super(key: key);

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
                      "Login to Your Account",
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
                        controller: Logincubit.obj(context).loginEmailController,
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
                          suffixpressed: (){
                            Logincubit.obj(context).changpasswordstate();
                          },
                          prefixicon: Icons.lock,
                          controller: Logincubit.obj(context).loginPasswordController,
                          keyboardtype: TextInputType.text,
                          lable: 'password',
                          ispass:Logincubit.obj(context).showpassword,
                          suffixicon: Logincubit.obj(context).icon),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 8),
                      child: defaultButton(
                        function: () {
                       if(Logincubit.obj(context).registerEmailController.text==''||
                       Logincubit.obj(context).registerPasswordController.text==''){
                         ShowSnackBar(context:context,  text:"Email & Password mustn't be empty");

                       }
                        else  {
                            _auth.Sign_in_with_EmailAndPassword(
                                context: context,
                                emailAddress: Logincubit.obj(context)
                                    .loginEmailController
                                    .text
                                    ,
                                password: Logincubit.obj(context)
                                    .loginPasswordController
                                    .text
                                    );


                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AuthScreen()));

                            Logincubit.obj(context).registerEmailController.text=='';
                                Logincubit.obj(context).registerPasswordController.text=='';

                          }
                        },
                        text: 'Sign in',
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
                      onTap: () async{
                        bool res=await _auth.Sign_in_with_google(context);


                        if(res)
                          {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>MianScreen()));
                          }
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
                        Text(
                          "Don't have an account?",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                            child: Text("Sign up", style:TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue,
                            ), ))
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
