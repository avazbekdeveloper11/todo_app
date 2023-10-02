import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/aplication/calendar_bloc/calendar_bloc.dart';
import 'package:todo_app/infrastructure/models/todo_model.dart';
import 'package:todo_app/presentation/pages/calendar_page/widgets/event_cart.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class CardsBuilder extends StatelessWidget {
  final CalendarState state;
  const CardsBuilder({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        List<TodoModel>? items = state.todoModelList ?? [];
        return items.isNotEmpty &&
                state.month == state.selectedMonth &&
                state.year == state.selectedYear
            ? ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return EventCart(
                    item: items[index],
                  );
                },
              )
            : Center(heightFactor: 10, child: Text('no_data'.tr()));
      },
    );
  }
}
