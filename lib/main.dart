import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zomo/Shared/cubit/AppCubit.dart';
import 'package:zomo/Shared/cubit/themecubit/themestate.dart';
import 'package:zomo/screens/splashScreen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'Shared/bloc_observer.dart';
import 'Shared/cubit/Logincubit/logincubit.dart';
import 'Shared/cubit/themecubit/themecubit.dart';
import 'Shared/network/cache_helper.dart';
import 'Shared/network/remote/NotificationServices.dart';
import 'Shared/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CachHelper.init();
  bool? isDark = CachHelper.getData(key: 'isDark') ?? false;
  await Firebase.initializeApp();
  NotificationServices notificationServices = NotificationServices();
  notificationServices.initialiseNotification();
  tz.initializeTimeZones();
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<Logincubit>(
            create: (context) => Logincubit(),
          ),
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit()..changeappmode(isdark: isDark),
          ),
          BlocProvider<AppCubit>(
            create: (context) => AppCubit(),
          ),
        ],
        child: BlocConsumer<ThemeCubit, AppThemeState>(
            buildWhen: (previous, current) => previous != current,
            listener: (context, sate) {},
            builder: (context, AppThemeState) {
              return ScreenUtilInit(
                designSize: const Size(428, 926),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (context, child) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: lighttheme,
                    darkTheme: darktheme,
                    themeMode: context.read<ThemeCubit>().isDark
                        ? ThemeMode.dark
                        : ThemeMode.light,
                    home: child,
                  );
                },
                child: splashScreen(),
              );
            }));
  }
}
