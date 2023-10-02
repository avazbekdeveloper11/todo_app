import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/domain/common/app_init.dart';

import 'presentation/pages/core/app_widget.dart';

void main() async {
  await Hive.initFlutter();
  await AppInit.create;
  // RUN APP

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => EasyLocalization(
        supportedLocales: const [Locale('en', 'US')],
        path: 'assets/translation',
        fallbackLocale: const Locale('en', 'US'),
        child: AppWidget(
          dbService: AppInit.dbService!,
        ),
      ),
    ),
  );
}
