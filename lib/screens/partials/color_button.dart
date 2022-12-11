import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class ColorButton extends StatelessWidget {
  const ColorButton({super.key, this.color, this.icon, this.border = false});

  final Color? color;
  final HeroIcons? icon;
  final bool border;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      decoration: BoxDecoration(
        color: color == null ? Color(0xFFEEEEEE) : color!,
        shape: BoxShape.circle,
        border: border ? Border.all() : null,
      ),
      child: Center(
        child: icon == null
            ? null
            : HeroIcon(
                icon!,
                color: Colors.grey,
              ),
      ),
    );
  }
}
