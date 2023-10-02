import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/infrastructure/models/todo_model.dart';
import 'package:todo_app/infrastructure/services/local_db.dart';

part 'calendar_bloc.freezed.dart';
part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(const _CalendarState()) {
    on<_InitDate>(_initDate);
    on<_NextMonth>(_nextMonth);
    on<_BackMonth>(_backMonth);
    on<_ChangeDropdown>(_changeDropdown);
    on<_SelectDate>(_selectDate);
    on<_GetAllToDo>(_getAllToDo);
    on<_GetByDate>(_getByDate);
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

  void _backMonth(_BackMonth event, Emitter<CalendarState> emit) {
    DateTime dateTime = DateTime(state.year, state.month);
    int year = state.year;
    int month = state.month - 1;
    String dayName = DateFormat('EEEE')
        .format(dateTime.copyWith(day: 1, month: month, year: year));
    int currentMonthLenth =
        DateTime(year, DateTime(year, month).month + 1, 0).day;
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

  void _changeDropdown(_ChangeDropdown event, Emitter<CalendarState> emit) {
    return emit(state.copyWith(dropDownValue: event.dropDownValue));
  }

  Future<void> _getAllToDo(
    _GetAllToDo event,
    Emitter<CalendarState> emit,
  ) async {
    List<TodoModel> todo = await LocalDatabase.getAllTodo();
    Map<String, List<TodoModel>> toDo = {};
    for (TodoModel el in todo) {
      if (toDo.keys.contains(el.date)) {
        toDo[el.date]?.add(el);
      } else {
        toDo[el.date ?? "0"] = [el];
      }
    }
    int currentMonthLenth =
        DateTime(state.selectedYear, state.selectedMonth + 1, 0).day;

    int prevMonthLenth = DateTime(state.selectedYear,
            DateTime(state.selectedYear, state.selectedMonth - 1).month - 1, 0)
        .day;

    String firstDayName = DateFormat('EEEE')
        .format(DateTime(state.selectedYear, state.selectedMonth, 1));
    int dayNumber = getDayNumber(firstDayName);

    emit(state.copyWith(
      dropDownValue: '#009FEE',
      currentMonthLenth: currentMonthLenth,
      prevMonthLenth: prevMonthLenth,
      toDoForCheck: toDo,
      dayNumber: dayNumber,
      day: state.selectedDay,
      month: state.selectedMonth,
      year: state.selectedYear,
    ));
  }

  FutureOr<void> _getByDate(event, Emitter<CalendarState> emit) async {
    List<TodoModel> model = await LocalDatabase.getByDate(
      '${state.selectedYear}-${state.selectedMonth}-${state.selectedDay}',
    );

    return emit(state.copyWith(todoModelList: model));
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

    String dayName =
        DateFormat('EEEE').format(dateTime.copyWith(day: dateTime.day));
    String firstDayName = DateFormat('EEEE').format(dateTime.copyWith(day: 1));

    int dayNumber = getDayNumber(firstDayName);
    emit(
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
        selectedDay: dateTime.day,
        selectedMonth: dateTime.month,
        selectedYear: dateTime.year,
      ),
    );
  }

  void _nextMonth(_NextMonth event, Emitter<CalendarState> emit) {
    DateTime dateTime = DateTime(state.year, state.month);
    int year = state.year;
    int month = state.month + 1;
    String dayName = DateFormat('EEEE')
        .format(dateTime.copyWith(day: 1, month: month, year: year));
    int currentMonthLenth =
        DateTime(year, DateTime(year, month).month + 1, 0).day;

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

  FutureOr<void> _selectDate(
      _SelectDate event, Emitter<CalendarState> emit) async {
    try {
      add(const CalendarEvent.getByDate());
      emit(
        state.copyWith(
          selectedDay: event.selectedDay,
          selectedMonth: event.selectedMonth,
          selectedYear: event.selectedYear,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          selectedDay: event.selectedDay,
          selectedMonth: event.selectedMonth,
          selectedYear: event.selectedYear,
          todoModelList: null,
        ),
      );
    }
  }
}
