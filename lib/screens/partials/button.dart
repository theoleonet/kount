import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kount/screens/styles/constants.dart';

class Button extends StatelessWidget {
  const Button(
      {this.text = '',
      this.color = kDefaultButtonColor,
      this.width,
      this.onTap,
      super.key});

  final String text;
  final Color color;
  final double? width;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: kDefaultButtonHeight,
        width: width,
        decoration: BoxDecoration(
          borderRadius: kBaseBorderRadius,
          color: color,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: kDefaultButtonTextStyle,
        ),
      ),
    );
  }
}
