import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/aplication/calendar_bloc/calendar_bloc.dart';
import 'package:todo_app/infrastructure/models/todo_model.dart';
import 'package:todo_app/presentation/pages/add_event_page/add_event_page.dart';
import 'package:todo_app/presentation/pages/calendar_page/calendar_page.dart';
import 'package:todo_app/presentation/pages/core/app_widget.dart';
import 'package:todo_app/presentation/pages/event_details/event_details_page.dart';

class Routes {
  static PageRoute getAddEventPage(BuildContext context,
          [TodoModel? todoModel]) =>
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<CalendarBloc>(),
          child: AddEventPage(todoModel: todoModel),
        ),
      );

  static PageRoute getAppWidget() => MaterialPageRoute(
        builder: (_) => const AppWidget(),
      );

  static PageRoute getCalendarPage(BuildContext context) => MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<CalendarBloc>()
            ..add(const CalendarEvent.initDate())
            ..add(const CalendarEvent.getAllTodo()),
          child: const CalendarPage(),
        ),
      );

  static PageRoute getEventDetailsPage(
    TodoModel todoModel,
    BuildContext context,
  ) =>
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<CalendarBloc>(),
          child: EventDetailsPage(
            todoModel: todoModel,
          ),
        ),
      );
}
