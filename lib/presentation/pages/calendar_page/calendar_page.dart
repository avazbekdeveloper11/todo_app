import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/aplication/calendar_bloc/calendar_bloc.dart';
import 'package:todo_app/infrastructure/services/db_service.dart';
import 'package:todo_app/presentation/pages/calendar_page/widgets/add_event_widget.dart';
import 'package:todo_app/presentation/pages/calendar_page/widgets/appbar_widget.dart';
import 'package:todo_app/presentation/pages/calendar_page/widgets/calendar_widget.dart';
import 'package:todo_app/presentation/pages/calendar_page/widgets/cards_builder.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        return ThemeWrapper(
          builder: (context, colors, fonts, icons, controller) {
            return Scaffold(
              backgroundColor: colors.backgroundColor,
              body: state.currentMonthLenth != 0
                  ? SafeArea(
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
                                CardsBuilder(state: state),
                                SizedBox(height: 20.h),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    LocalDatabase.getAllTodo();
    super.initState();
  }
}
