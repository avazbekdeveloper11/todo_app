import 'package:flutter/material.dart';
import 'package:todo_app/presentation/pages/calendar_page/widgets/add_event_widget.dart';
import 'package:todo_app/presentation/pages/calendar_page/widgets/appbar_widget.dart';
import 'package:todo_app/presentation/pages/calendar_page/widgets/calendar_widget.dart';
import 'package:todo_app/presentation/pages/calendar_page/widgets/cards_builder.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.backgroundColor,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                const AppbarWidget(),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const CalendarWiget(),
                      const SizedBox(height: 200),
                      const AddEventWidget(),
                      const SizedBox(height: 20),
                      const CardsBuilder(),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
