import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/aplication/calendar_bloc/calendar_bloc.dart';
import 'package:todo_app/presentation/components/buttons/custom_buttons.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class AppbarWidget extends StatelessWidget {
  final CalendarState state;
  const AppbarWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return SliverAppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: colors.backgroundColor,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.dayName ?? '',
                style: fonts.semiBold14,
              ),
              Text(
                '${state.day} ${DateFormat.MMMM().format(DateTime(state.month, state.month))} ${state.year}',
                style: fonts.regular12.copyWith(fontSize: 10),
              ),
            ],
          ),
          actions: [
            CustomIconButton(
              onPressed: () {},
              icon: icons.notification,
            )
          ],
        );
      },
    );
  }
}
