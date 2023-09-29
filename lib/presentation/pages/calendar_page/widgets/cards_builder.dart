import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/presentation/routes/routes.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class CardsBuilder extends StatelessWidget {
  const CardsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
              child: ListTile(
                onTap: () => Navigator.push(
                  context,
                  Routes.getEventDetailsPage(),
                ),
                tileColor: colors.primary,
              ),
            );
          },
        );
      },
    );
  }
}
