import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/infrastructure/services/db_service.dart';
import 'package:todo_app/presentation/routes/routes.dart';
import 'package:todo_app/presentation/styles/theme.dart';

class AppWidget extends StatelessWidget {
  final DBService dbService;
  const AppWidget({Key? key, required this.dbService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GridTheme.create(dbService),
      builder: (BuildContext ctx, _) {
        return RepositoryProvider(
          create: (context) => dbService,
          child: Builder(builder: (context) {
            return MaterialApp(
              locale: context.locale,
              builder: EasyLoading.init(),
              debugShowCheckedModeBanner: false,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              onGenerateRoute: (settings) =>
                  Routes.onGenerateRoute(context: context),
            );
          }),
        );
      },
    );
  }
}
