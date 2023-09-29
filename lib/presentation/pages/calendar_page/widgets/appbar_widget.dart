import 'package:flutter/material.dart';
import 'package:todo_app/presentation/components/buttons/custom_buttons.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({
    super.key,
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
                'Sunday',
                style: fonts.semiBold14,
              ),
              Text(
                '28 September 2021',
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
