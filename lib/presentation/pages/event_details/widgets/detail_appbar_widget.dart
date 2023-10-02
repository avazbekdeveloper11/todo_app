import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/infrastructure/models/todo_model.dart';
import 'package:todo_app/presentation/routes/routes.dart';
import 'package:todo_app/presentation/styles/theme.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class DetailAppbarWidget extends StatefulWidget {
  final TodoModel todoModel;
  const DetailAppbarWidget({
    super.key,
    required this.todoModel,
  });

  @override
  State<DetailAppbarWidget> createState() => _DetailAppbarWidgetState();
}

class _DetailAppbarWidgetState extends State<DetailAppbarWidget> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (ctx, colors, fonts, icons, controller) {
        return Container(
          width: 1.sw,
          height: (248 + MediaQuery.of(context).viewInsets.top).h,
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).viewInsets.top + 68).h,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: SvgPicture.asset(icons.back),
                        onTap: () => Navigator.pop(context),
                      ),
                      //
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          Routes.getAddEventPage(context, widget.todoModel),
                        ).then((value) {
                          Navigator.pop(context);
                        }),
                        child: Row(
                          children: [
                            SvgPicture.asset(icons.edit),
                            SizedBox(width: 4.w),
                            Text(
                              'edit'.tr(),
                              style: fonts.medium14.copyWith(
                                color: colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  widget.todoModel.name ?? '',
                  style: fonts.semiBold16.copyWith(
                    color: colors.white,
                    fontSize: 26.sp,
                  ),
                ),
                Text(
                  widget.todoModel.description ?? '...',
                  maxLines: 1,
                  style: fonts.regular12.copyWith(
                    color: colors.white,
                    fontSize: 8.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                rowTile(
                  icon: icons.clock,
                  text: widget.todoModel.time ?? '--:--',
                  fonts: fonts,
                  colors: colors,
                ),
                SizedBox(height: 12.h),
                rowTile(
                  icon: icons.location,
                  text: widget.todoModel.location ?? '...',
                  fonts: fonts,
                  colors: colors,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Row rowTile({
    required String icon,
    required String text,
    required FontSet fonts,
    required CustomColorSet colors,
  }) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        SizedBox(width: 4.w),
        Text(
          text,
          style: fonts.medium14.copyWith(
            fontSize: 10.sp,
            color: colors.white,
          ),
        ),
      ],
    );
  }
}
