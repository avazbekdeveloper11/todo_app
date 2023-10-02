part of 'calendar_bloc.dart';

@freezed
abstract class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent.initDate() = _InitDate;

  const factory CalendarEvent.nextMonth() = _NextMonth;

  const factory CalendarEvent.backMonth() = _BackMonth;

  const factory CalendarEvent.getAllTodo() = _GetAllToDo;

  const factory CalendarEvent.getByDate() = _GetByDate;

  const factory CalendarEvent.changeDropdown({
    required String dropDownValue,
  }) = _ChangeDropdown;

  const factory CalendarEvent.selectDate({
    required int selectedDay,
    required int selectedMonth,
    required int selectedYear,
  }) = _SelectDate;
}
