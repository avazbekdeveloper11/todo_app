import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/aplication/calendar_bloc/calendar_bloc.dart';
import 'package:todo_app/presentation/components/buttons/custom_buttons.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class CalendarWiget extends StatefulWidget {
  final CalendarState state;
  const CalendarWiget({super.key, required this.state});

  @override
  State<CalendarWiget> createState() => _CalendarWigetState();
}

class _CalendarWigetState extends State<CalendarWiget> {
  // late DateTime dateTime;
  // late int year;
  // late int month;
  // late int day;
  // late int monthLength;
  // late String dayName;
  // late int dayNumber;
  // late int? prevMonthLenth;
  List months = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

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
                  const Spacer(),
                  CustomCircleButton(
                    onTap: () {
                      // setState(
                      //   () {
                      //     month -= 1;
                      //     dayName = DateFormat('EEEE').format(dateTime.copyWith(
                      //         day: 1, month: month, year: year));
                      //     dayNumber = weekOfDay(dayName);
                      //     monthLength =
                      //         DateTime(year, DateTime(year, month).month + 1, 0)
                      //             .day;
                      //     prevMonthLenth = DateTime(
                      //             year, DateTime(year, month - 1).month + 1, 0)
                      //         .day;
                      //   },
                      // );
                    },
                    icon: Icons.keyboard_arrow_left,
                  ),
                  SizedBox(width: 10.w),
                  CustomCircleButton(
                    onTap: () {
                      // setState(() {
                      //   month += 1;
                      //   dayName = DateFormat('EEEE').format(
                      //     dateTime.copyWith(
                      //       day: 1,
                      //       month: month,
                      //       year: year,
                      //     ),
                      //   );
                      //   dayNumber = weekOfDay(dayName);
                      //   monthLength =
                      //       DateTime(year, DateTime(year, month).month + 1, 0)
                      //           .day;
                      //   prevMonthLenth = DateTime(
                      //           year, DateTime(year, month - 1).month + 1, 0)
                      //       .day;
                      // });
                    },
                    icon: Icons.keyboard_arrow_right,
                  )
                ],
              ),
            ),
            //

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
            //

            GridView.builder(
              itemCount: widget.state.dayNumber < 5 &&
                      widget.state.currentMonthLenth > 31
                  ? 37
                  : 42,
              shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              padding: EdgeInsets.only(left: 18.w, right: 14.w),
              //
              itemBuilder: (context, index) {
                if ((widget.state.dayNumber - 2) < index &&
                    (widget.state.currentMonthLenth +
                            (widget.state.dayNumber - 1)) >
                        index) {
                  return Center(
                    child: Text(
                      '${index - (widget.state.dayNumber - 2)}',
                      style: fonts.medium14.copyWith(fontSize: 12.sp),
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
          ],
        );
      },
    );
  }

  // @override
  // void initState() {
  //   dateTime = DateTime.now();
  //   day = dateTime.day;
  //   month = dateTime.month;
  //   year = dateTime.year;
  //   dayName = DateFormat('EEEE').format(dateTime.copyWith(day: 1));
  //   dayNumber = weekOfDay(dayName);
  //   monthLength = DateTime(year, DateTime(year, month).month + 1, 0).day;
  //   prevMonthLenth = DateTime(year, DateTime(year, month - 1).month + 1, 0).day;
  //   super.initState();
  // }

  // int weekOfDay(String dayName) {
  //   switch (dayName) {
  //     case 'Sunday':
  //       return 1;
  //     case 'Monday':
  //       return 2;
  //     case 'Tuesday':
  //       return 3;
  //     case 'Wednesday':
  //       return 4;
  //     case 'Thursday':
  //       return 5;
  //     case 'Friday':
  //       return 6;
  //     case 'Saturday':
  //       return 7;
  //     default:
  //       return 0;
  //   }
  // }
}
