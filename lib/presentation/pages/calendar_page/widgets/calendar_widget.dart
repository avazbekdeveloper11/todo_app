import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/aplication/calendar_bloc/calendar_bloc.dart';
import 'package:todo_app/infrastructure/extensions/extensions.dart';
import 'package:todo_app/infrastructure/models/todo_model.dart';
import 'package:todo_app/presentation/components/buttons/custom_buttons.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class CalendarWiget extends StatefulWidget {
  final CalendarState state;
  const CalendarWiget({super.key, required this.state});

  @override
  State<CalendarWiget> createState() => _CalendarWigetState();
}

class _CalendarWigetState extends State<CalendarWiget> {
  List months = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  Timer? _searchTimer;
  late List<TodoModel> todoList;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 28.w,
                right: 28.w,
                top: 34.h,
                bottom: 20.h,
              ),
              child: Row(
                children: [
                  Text(
                    DateFormat.MMMM().format(
                      DateTime(
                        widget.state.year,
                        widget.state.month,
                      ),
                    ),
                    style: fonts.semiBold14,
                  ),
                  Text(
                    widget.state.year.toString(),
                    style: fonts.semiBold14,
                  ),
                  const Spacer(),
                  CustomCircleButton(
                    onTap: () {
                      context.read<CalendarBloc>().add(
                            const CalendarEvent.backMonth(),
                          );
                    },
                    icon: Icons.keyboard_arrow_left,
                  ),
                  SizedBox(width: 10.w),
                  CustomCircleButton(
                    onTap: () {
                      context.read<CalendarBloc>().add(
                            const CalendarEvent.nextMonth(),
                          );
                    },
                    icon: Icons.keyboard_arrow_right,
                  )
                ],
              ),
            ),
            GridView.builder(
              itemCount: 7,
              shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7, mainAxisExtent: 18.h),
              padding: EdgeInsets.only(left: 18.w, right: 14.w),
              //
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    months[index],
                    style: fonts.medium14.copyWith(
                      fontSize: 12.sp,
                      color: colors.textColor2,
                    ),
                  ),
                );
              },
            ),
            GestureDetector(
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                _searchTimer!.cancel();
                _searchTimer = Timer(
                  const Duration(milliseconds: 50),
                  () {
                    if (details.delta.direction == 0) {
                      context.read<CalendarBloc>().add(
                            const CalendarEvent.backMonth(),
                          );
                    } else {
                      context.read<CalendarBloc>().add(
                            const CalendarEvent.nextMonth(),
                          );
                    }
                  },
                );
              },
              child: GridView.builder(
                itemCount: 42,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7),
                padding: EdgeInsets.only(left: 18.w, right: 14.w),
                itemBuilder: (context, index) {
                  if ((widget.state.dayNumber - 2) < index &&
                      (widget.state.currentMonthLenth +
                              (widget.state.dayNumber - 1)) >
                          index) {
                    bool currentDate =
                        widget.state.year == widget.state.currentYear &&
                            widget.state.currentMonth == widget.state.month &&
                            widget.state.currentday ==
                                (index - (widget.state.dayNumber - 2));

                    bool isSelected = (index - (widget.state.dayNumber - 2)) ==
                            widget.state.selectedDay &&
                        widget.state.month == widget.state.selectedMonth &&
                        widget.state.year == widget.state.selectedYear;
                    todoList = widget.state.toDoForCheck?[
                            "${widget.state.year}-${widget.state.month}-${index - (widget.state.dayNumber - 2)}"] ??
                        [];

                    return GestureDetector(
                      onTap: () {
                        context.read<CalendarBloc>().add(
                              CalendarEvent.selectDate(
                                selectedMonth: widget.state.month,
                                selectedYear: widget.state.year,
                                selectedDay:
                                    (index - (widget.state.dayNumber - 2)),
                              ),
                            );
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10.sp),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? colors.primary
                                    : colors.transparent,
                              ),
                              color: currentDate
                                  ? colors.primary
                                  : colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                '${index - (widget.state.dayNumber - 2)}',
                                style: fonts.medium14.copyWith(
                                  fontSize: 12.sp,
                                  color:
                                      currentDate ? colors.white : colors.black,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            child: todoList.isNotEmpty
                                ? Wrap(
                                    spacing: 4.w,
                                    children: List.generate(
                                      todoList.length > 3 ? 3 : todoList.length,
                                      (i) => CircleAvatar(
                                        radius: 2.r,
                                        backgroundColor:
                                            HexColor.fromHex(todoList[i].color),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        '${(widget.state.dayNumber - 2) >= index ? (widget.state.prevMonthLenth - (widget.state.dayNumber - index - 2)) : ((index + 1) - (widget.state.currentMonthLenth + (widget.state.dayNumber - 1)))}',
                        style: fonts.medium14.copyWith(
                          fontSize: 12.sp,
                          color: colors.grey,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchTimer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _searchTimer = Timer(Duration.zero, () {});
    todoList = [];
    super.initState();
  }
}
