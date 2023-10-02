part of 'calendar_bloc.dart';

@immutable
@freezed
class CalendarState with _$CalendarState {
  const CalendarState._();

  const factory CalendarState({
    @Default(0) int day,
    @Default(0) int month,
    @Default(0) int year,
    @Default(0) int dayNumber,
    @Default('') String? dayName,
    @Default('') String? monthName,
    @Default(0) int? currentday,
    @Default(0) int currentYear,
    @Default(0) int currentMonth,
    @Default(0) int currentDayNumber,
    @Default('') String? currentDayName,
    @Default('') String? currentMonthName,
    @Default(0) int currentMonthLenth,
    @Default(0) int prevMonthLenth,
    @Default('#009FEE') String dropDownValue,
    @Default(0) int selectedDay,
    @Default(0) int selectedMonth,
    @Default(0) int selectedYear,
    @Default(null) List<TodoModel>? todoModelList,
    @Default(null) Map<String, List<TodoModel>>? toDoForCheck,
  }) = _CalendarState;
}
