import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

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
    );
  }
}
