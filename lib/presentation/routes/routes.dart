import 'package:flutter/material.dart';
import 'package:todo_app/presentation/pages/add_event_page/add_event_page.dart';
import 'package:todo_app/presentation/pages/calendar_page/calendar_page.dart';
import 'package:todo_app/presentation/pages/core/app_widget.dart';
import 'package:todo_app/presentation/pages/event_details/event_details_page.dart';

class Routes {
  static PageRoute getAppWidget() => MaterialPageRoute(
        builder: (_) => const AppWidget(),
      );

  static PageRoute getCalendarPage() => MaterialPageRoute(
        builder: (_) => const CalendarPage(),
      );

  static PageRoute getAddEventPage() => MaterialPageRoute(
        builder: (_) => const AddEventPage(),
      );

  static PageRoute getEventDetailsPage() => MaterialPageRoute(
        builder: (_) => const EventDetailsPage(),
      );
}
