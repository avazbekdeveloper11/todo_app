part of 'calendar_bloc.dart';

@freezed
abstract class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent.initDate() = _InitDate;
  const factory CalendarEvent.nextMonth() = _NextMonth;
  const factory CalendarEvent.backMonth() = _BackMonth;
}
