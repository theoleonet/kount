import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/routes/routes.dart';
import 'package:kount/screens/styles/constants.dart';

class ClickableIcon extends StatelessWidget {
  const ClickableIcon({required this.icon, required this.onTap, super.key});
  final HeroIcons icon;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: HeroIcon(
        icon,
        size: kBigIconSize,
      ),
    );
  }
}
