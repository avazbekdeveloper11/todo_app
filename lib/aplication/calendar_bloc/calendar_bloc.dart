import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_bloc.freezed.dart';
part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(const _CalendarState()) {
    on<_InitDate>(_initDate);
    on<_NextMonth>(_nextMonth);
    on<_BackMonth>(_backMonth);
  }

  int getDayNumber(String dayName) {
    List<String> weekName = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    int index =
        (weekName.lastIndexWhere((String element) => element == dayName) + 1);
    return index == -1 ? 0 : index;
  }

  void _initDate(
    _InitDate event,
    Emitter<CalendarState> emit,
  ) {
    DateTime dateTime = DateTime.now();

    String monthName = DateFormat.MMMM().format(dateTime);

    int currentMonthLenth = DateTime(dateTime.year, dateTime.month + 1, 0).day;

    int prevMonthLenth = DateTime(dateTime.year,
            DateTime(dateTime.year, dateTime.month - 1).month + 1, 0)
        .day;

    String dayName = DateFormat('EEEE').format(dateTime.copyWith(day: 1));
    int dayNumber = getDayNumber(dayName);

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
        currentMonth: dateTime.month,
        currentYear: dateTime.year,
        currentDayNumber: dayNumber,
        currentMonthName: monthName,
        currentday: dateTime.day,
        currentDayName: dayName,
      ),
    );
  }

  void _nextMonth(_NextMonth event, Emitter<CalendarState> emit) {
    DateTime dateTime = DateTime(state.year, state.month);
    int year = state.year;
    int month = state.month + 1;
    String dayName = DateFormat('EEEE')
        .format(dateTime.copyWith(day: 1, month: month, year: year));
    int currentMonthLenth = DateTime(year, dateTime.month + 1, 0).day;

    int prevMonthLenth =
        DateTime(year, DateTime(year, month - 1).month + 1, 0).day;

    int dayNumber = getDayNumber(dayName);

    String monthName = DateFormat.MMMM().format(dateTime);
    if (month == 13) {
      month = 1;
      year += 1;
    }

    return emit(
      state.copyWith(
        month: month,
        year: year,
        dayName: dayName,
        dayNumber: dayNumber,
        currentMonthLenth: currentMonthLenth,
        prevMonthLenth: prevMonthLenth,
        monthName: monthName,
      ),
    );
  }

  void _backMonth(_BackMonth event, Emitter<CalendarState> emit) {
    DateTime dateTime = DateTime(state.year, state.month);
    int year = state.year;
    int month = state.month - 1;
    String dayName = DateFormat('EEEE')
        .format(dateTime.copyWith(day: 1, month: month, year: year));
    int currentMonthLenth = DateTime(year, dateTime.month + 1, 0).day;

    int prevMonthLenth =
        DateTime(year, DateTime(year, month - 1).month - 1, 0).day;

    int dayNumber = getDayNumber(dayName);

    String monthName = DateFormat.MMMM().format(dateTime);
    if (month == 0) {
      month = 12;
      year -= 1;
    }

    return emit(
      state.copyWith(
        month: month,
        year: year,
        dayName: dayName,
        dayNumber: dayNumber,
        currentMonthLenth: currentMonthLenth,
        prevMonthLenth: prevMonthLenth,
        monthName: monthName,
      ),
    );
  }
}
