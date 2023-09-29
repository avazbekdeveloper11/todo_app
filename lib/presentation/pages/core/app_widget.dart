import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/infrastructure/services/shared_pref_service.dart';
import 'package:todo_app/presentation/pages/calendar_page/calendar_page.dart';
import 'package:todo_app/presentation/styles/theme.dart';
import 'package:todo_app/presentation/pages/core/splash_screen.dart';

class AppWidget extends StatelessWidget {
  final Uri? uri;
  const AppWidget({Key? key, this.uri}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        PreferenceService.create,
        GridTheme.create,
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snap) {
        if (snap.hasData && snap.data is List<dynamic>) {
          final data = snap.data;
          final GridTheme theme = data?[1];
          return ChangeNotifierProvider(
            create: (_) => theme,
            builder: (BuildContext context, _) {
              return MaterialApp(
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                home: const CalendarPage(),
              );
            },
          );
        } else {
          return const MediaQuery(
            data: MediaQueryData(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            ),
          );
        }
      },
    );
  }
}
