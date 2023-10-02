import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/presentation/components/buttons/custom_buttons.dart';
import 'package:todo_app/presentation/routes/routes.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class AddEventWidget extends StatelessWidget {
  const AddEventWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (ctx, colors, fonts, icons, controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'schedule'.tr(),
                style: fonts.semiBold14,
              ),
              CustomButton(
                width: 102.w,
                title: 'add_event'.tr(),
                onPressed: () => Navigator.push(
                  context,
                  Routes.getAddEventPage(context),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
