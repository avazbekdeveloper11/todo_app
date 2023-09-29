import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/domain/common/app_init.dart';
import 'presentation/pages/core/app_widget.dart';

void main() async {
  await AppInit().appInitialized();
  // RUN APP
  runApp(
    ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      builder: (context, child) {
        return EasyLocalization(
          supportedLocales: const [Locale('en', 'US')],
          path: 'assets/translation',
          fallbackLocale: const Locale('en', 'US'),
          child: const AppWidget(),
        );
      },
    ),
  );
}
