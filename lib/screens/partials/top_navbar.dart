import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/screens/styles/constants.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavBar({this.title = '', this.actions, super.key});

  final String title;
  final List<Widget>? actions;

  static bool canPop(BuildContext context) {
    final NavigatorState? navigator = Navigator.maybeOf(context);
    return navigator != null && navigator.canPop();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
      ),
      centerTitle: true,
      backgroundColor: kBackgroundColor,
      titleTextStyle: kTopNavBarTitleStyle,
      iconTheme: kTopNavBarIconsStyle,
      leading: canPop(context)
          ? Padding(
              padding: EdgeInsets.only(left: 16),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: HeroIcon(
                  HeroIcons.arrowLeft,
                  size: kBaseIconSize,
                ),
              ),
            )
          : Text(''),
      actions: actions,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size(
        double.maxFinite,
        80,
      );
}
