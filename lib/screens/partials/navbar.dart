import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/routes/routes.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, kHomeRoute);
            },
            child: HeroIcon(
              HeroIcons.home,
              size: 32,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, kCreateCountdownRoute);
            },
            child: HeroIcon(
              HeroIcons.plusCircle,
              size: 32,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, kSettingsRoute);
            },
            child: HeroIcon(
              HeroIcons.cog8Tooth,
              size: 32,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, kProfileRoute);
            },
            child: HeroIcon(
              HeroIcons.userCircle,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
