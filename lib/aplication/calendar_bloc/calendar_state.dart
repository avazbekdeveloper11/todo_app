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
    @Default(0) int currentMonthLenth,
    @Default(0) int prevMonthLenth,
    @Default('') String? dayName,
    @Default('') String? monthName,
  }) = _CalendarState;
}
