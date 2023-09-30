import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/presentation/routes/routes.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class CardsBuilder extends StatelessWidget {
  const CardsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return EventCart(color: index.isEven ? colors.primary : colors.red);
          },
        );
      },
    );
  }
}

class EventCart extends StatelessWidget {
  final Color color;
  const EventCart({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return GestureDetector(
        onTap: () => Navigator.push(context, Routes.getAddEventPage()),
        child: Container(
          height: 96.h,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.r),
          ),
          margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 10.h,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10.r),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.h, left: 12.w),
                child: Text(
                  "Watching Football ",
                  style: fonts.semiBold14.copyWith(
                    color: color,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.w, top: 4.h),
                child: Text(
                  "Manchester United vs Arsenal (Premiere League)",
                  style: fonts.regular12.copyWith(
                    fontSize: 8.sp,
                    color: color,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 14.h, left: 12.w),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      icons.location,
                      colorFilter: ColorFilter.mode(
                        color,
                        BlendMode.srcIn,
                      ),
                    ),
                    Text(
                      "17:00 - 18:30",
                      style: fonts.medium14.copyWith(
                        fontSize: 10.sp,
                        color: color,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    SvgPicture.asset(
                      icons.clock,
                      colorFilter: ColorFilter.mode(
                        color,
                        BlendMode.srcIn,
                      ),
                    ),
                    Text(
                      "Stamford Bridge",
                      style: fonts.medium14.copyWith(
                        fontSize: 10.sp,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
