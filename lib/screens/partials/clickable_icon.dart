import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/routes/routes.dart';
import 'package:kount/screens/styles/constants.dart';

class ClickableIcon extends StatelessWidget {
  const ClickableIcon({required this.icon, required this.route, super.key});
  final HeroIcons icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: HeroIcon(
        icon,
        size: kBigIconSize,
      ),
    );
  }
}
