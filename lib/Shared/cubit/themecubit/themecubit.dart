import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:zomo/Shared/cubit/themecubit/themestate.dart';

import '../../network/cache_helper.dart';





class ThemeCubit extends Cubit<AppThemeState> {
  ThemeCubit() : super(initappthememode());
  static ThemeCubit obj(context) => BlocProvider.of(context);

  bool isDark = false;
  changeappmode({bool? isdark}) {
    if (isdark != null) {
      isDark = isdark;
    } else {
      isDark = !isDark;
    }
    CachHelper.putData(key: 'isDark', value: isDark).then((value) {
      emit(changeappthememode());

    });
  }
}
