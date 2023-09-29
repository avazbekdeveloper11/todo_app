import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/presentation/components/buttons/custom_buttons.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class CalendarWiget extends StatelessWidget {
  const CalendarWiget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Padding(
          padding: EdgeInsets.only(
            left: 28.w,
            right: 28.w,
            top: 34.h,
            bottom: 28.h,
          ),
          child: Row(
            children: [
              Text(
                'September',
                style: fonts.semiBold14,
              ),
              const Spacer(),
              CustomCircleButton(
                onTap: () {},
                icon: Icons.keyboard_arrow_left,
              ),
              SizedBox(width: 10.w),
              CustomCircleButton(
                onTap: () {},
                icon: Icons.keyboard_arrow_right,
              )
            ],
          ),
        );
      },
    );
  }
}
