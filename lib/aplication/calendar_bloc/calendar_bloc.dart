import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_bloc.freezed.dart';
part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(const _CalendarState()) {
    on<_InitDate>(_initDate);
  }
  void _initDate(
    _InitDate event,
    Emitter<CalendarState> emit,
  ) {
    DateTime dateTime = DateTime.now();

    String monthName =
        DateFormat.MMMM().format(DateTime(dateTime.year, dateTime.month));

    int currentMonthLenth = DateTime(
            dateTime.year, DateTime(dateTime.year, dateTime.month).month + 1, 0)
        .day;

    int prevMonthLenth = DateTime(dateTime.year,
            DateTime(dateTime.year, dateTime.month - 1).month + 1, 0)
        .day;

    List<String> weekName = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];

    String dayName = DateFormat('EEEE').format(dateTime.copyWith(day: 1));
    int dayNumber =
        (weekName.lastIndexWhere((String element) => element == dayName) + 1);

    return emit(
      state.copyWith(
        day: dateTime.day,
        month: dateTime.month,
        year: dateTime.year,
        dayName: dayName,
        dayNumber: dayNumber,
        currentMonthLenth: currentMonthLenth,
        prevMonthLenth: prevMonthLenth,
        monthName: monthName,
      ),
    );
  }
}
