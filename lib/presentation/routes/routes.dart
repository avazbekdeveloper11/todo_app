import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/aplication/calendar_bloc/calendar_bloc.dart';
import 'package:todo_app/presentation/pages/add_event_page/add_event_page.dart';
import 'package:todo_app/presentation/pages/calendar_page/calendar_page.dart';
import 'package:todo_app/presentation/pages/core/app_widget.dart';
import 'package:todo_app/presentation/pages/event_details/event_details_page.dart';

class Routes {
  static PageRoute getAddEventPage() => MaterialPageRoute(
        builder: (_) => const AddEventPage(),
      );

  static PageRoute getAppWidget() => MaterialPageRoute(
        builder: (_) => const AppWidget(),
      );

  static PageRoute getCalendarPage() => MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => CalendarBloc(),
          child: const CalendarPage(),
        ),
      );

  static PageRoute getEventDetailsPage() => MaterialPageRoute(
        builder: (_) => const EventDetailsPage(),
      );
}
