import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/aplication/calendar_bloc/calendar_bloc.dart';
import 'package:todo_app/presentation/pages/calendar_page/widgets/add_event_widget.dart';
import 'package:todo_app/presentation/pages/calendar_page/widgets/appbar_widget.dart';
import 'package:todo_app/presentation/pages/calendar_page/widgets/calendar_widget.dart';
import 'package:todo_app/presentation/pages/calendar_page/widgets/cards_builder.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        return ThemeWrapper(
          builder: (context, colors, fonts, icons, controller) {
            return Scaffold(
              backgroundColor: colors.backgroundColor,
              body: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    AppbarWidget(state: state),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          CalendarWiget(state: state),
                          SizedBox(height: 28.h),
                          const AddEventWidget(),
                          SizedBox(height: 20.h),
                          const CardsBuilder(),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
