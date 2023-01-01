import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/screens/styles/constants.dart';

class ColorButton extends StatelessWidget {
  const ColorButton({
    super.key,
    this.color,
    this.icon,
    /* this.border = false */
  });

  final int? color;
  final HeroIcons? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kColorButtonRadius,
      height: kColorButtonRadius,
      decoration: BoxDecoration(
        color: color == null ? Color(kBaseColorPickerColor) : Color(color!),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: icon == null
            ? null
            : HeroIcon(
                icon!,
                color: kColorButtonIconColor,
              ),
      ),
    );
  }
}
