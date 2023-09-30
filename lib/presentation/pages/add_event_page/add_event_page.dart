import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/presentation/components/buttons/custom_buttons.dart';
import 'package:todo_app/presentation/components/custom_text_field.dart';
import 'package:todo_app/presentation/components/un_focus.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  late FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return OnUnFocusTap(
      child: ThemeWrapper(
        builder: (context, colors, fonts, icons, controller) {
          return Scaffold(
            backgroundColor: colors.backgroundColor,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 40.h,
                        bottom: 32.h,
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(icons.arrowLeft),
                      ),
                    ),
                    CustomTextField(
                      title: 'event_name'.tr(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
                      child: Text(
                        'event_description'.tr(),
                        style: fonts.regular14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => focusNode.requestFocus(),
                      child: Container(
                        height: 92.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          color: colors.filledColor,
                          border: Border.all(color: colors.stroke),
                        ),
                        child: CustomTextField(
                          focusNode: focusNode,
                          maxLength: 150,
                          maxLines: 4,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: CustomTextField(
                        title: 'event_location'.tr(),
                        suffixIcon: SvgPicture.asset(
                          icons.location,
                          colorFilter: ColorFilter.mode(
                            colors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
                      child: Text(
                        'priority_color'.tr(),
                        style: fonts.regular14,
                      ),
                    ),
                    Container(
                      height: 32.h,
                      width: 72.w,
                      decoration: BoxDecoration(
                        color: colors.filledColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      title: 'event_time'.tr(),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom,
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
              child: CustomButton(
                verticalPadding: 12.h,
                title: 'save'.tr(),
                onPressed: () {},
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    focusNode = FocusNode();
    super.initState();
  }
}
