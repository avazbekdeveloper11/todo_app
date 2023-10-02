import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/aplication/calendar_bloc/calendar_bloc.dart';
import 'package:todo_app/infrastructure/models/todo_model.dart';
import 'package:todo_app/infrastructure/services/local_db.dart';
import 'package:todo_app/presentation/components/buttons/custom_buttons.dart';
import 'package:todo_app/presentation/pages/event_details/widgets/detail_appbar_widget.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class EventDetailsPage extends StatefulWidget {
  final TodoModel todoModel;
  const EventDetailsPage({super.key, required this.todoModel});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  String? desc;
  String? time;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        return ThemeWrapper(
          builder: (ctx, colors, fonts, icons, controller) {
            return Scaffold(
              body: Column(
                children: [
                  DetailAppbarWidget(todoModel: widget.todoModel),
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
                          time ?? widget.todoModel.time ?? '...',
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
                        desc ?? widget.todoModel.description ?? '...',
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
                  onPressed: () => deleteTodo(context),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void deleteTodo(BuildContext context) async {
    await LocalDatabase.deleteTodoById(widget.todoModel.id!).then((value) {
      context.read<CalendarBloc>()
        ..add(const CalendarEvent.getByDate())
        ..add(const CalendarEvent.getAllTodo());
      EasyLoading.showSuccess('success'.tr());
      Navigator.pop(context);
    });
  }
}
