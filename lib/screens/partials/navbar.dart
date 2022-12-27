import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/routes/routes.dart';
import 'package:kount/screens/partials/clickable_icon.dart';
import 'package:kount/screens/styles/constants.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kBottomNavBarHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: kTopBorderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClickableIcon(
            icon: HeroIcons.home,
            route: kHomeRoute,
          ),
          ClickableIcon(
            icon: HeroIcons.plusCircle,
            route: kCreateCountdownRoute,
          ),
          ClickableIcon(
            icon: HeroIcons.cog8Tooth,
            route: kSettingsRoute,
          ),
          ClickableIcon(
            icon: HeroIcons.userCircle,
            route: kProfileRoute,
          ),
        ],
      ),
    );
  }
}
