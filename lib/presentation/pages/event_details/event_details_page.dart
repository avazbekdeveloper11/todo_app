import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/presentation/components/buttons/custom_buttons.dart';
import 'package:todo_app/presentation/pages/event_details/widgets/detail_appbar_widget.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({super.key});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          body: Column(
            children: [
              const DetailAppbarWidget(),
              //
              Padding(
                padding: EdgeInsets.only(top: 18.h, bottom: 14.h),
                child: ListTile(
                  title: Text(
                    'reminder'.tr(),
                    style: fonts.semiBold16,
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Text(
                      '15 minutes befor',
                      style: fonts.medium16.copyWith(
                        color: colors.subtitle,
                      ),
                    ),
                  ),
                ),
              ),
              //
              ListTile(
                title: Text(
                  'description'.tr(),
                  style: fonts.semiBold16,
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus vel ex sit amet neque dignissim mattis non eu est. Etiam pulvinar est mi, et porta magna accumsan nec. Ut vitae urna nisl. Integer gravida sollicitudin massa, ut congue orci posuere sit amet. Aenean laoreet egestas est, ut auctor nulla suscipit non. ',
                    style: fonts.regular12.copyWith(
                      fontSize: 10.sp,
                      color: colors.subtitle,
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
              bottom: (MediaQuery.of(context).viewInsets.bottom + 50),
              left: 28.w,
              right: 28.w,
            ),
            child: CustomButton(
              icon: icons.delete,
              color: colors.redLight,
              titleColor: colors.black,
              verticalPadding: 12.h,
              title: 'delete_event'.tr(),
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }
}
