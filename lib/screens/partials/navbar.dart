import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HeroIcon(
              HeroIcons.home,
              size: 32,
            ),
            HeroIcon(
              HeroIcons.cog8Tooth,
              size: 32,
            ),
            HeroIcon(
              HeroIcons.plusCircle,
              size: 32,
            ),
            HeroIcon(
              HeroIcons.userCircle,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }
}
