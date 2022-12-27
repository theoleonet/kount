import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

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
        style: TextStyle(fontSize: 18),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.black),
      iconTheme: IconThemeData(color: Colors.black),
      leading: canPop(context)
          ? Padding(
              padding: EdgeInsets.only(left: 16),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: HeroIcon(
                  HeroIcons.arrowLeft,
                  size: 24,
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
