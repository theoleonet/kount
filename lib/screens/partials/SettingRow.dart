import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/routes/routes.dart';
import 'package:kount/screens/styles/constants.dart';

class SettingRow extends StatelessWidget {
  const SettingRow({
    required this.title,
    required this.route,
    required this.currentOption,
    super.key,
  });

  final String title;
  final String route;
  final String currentOption;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: kSettingsTitle,
        ),
        Spacer(),
        GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            route,
          ),
          child: Row(
            children: [
              Text(
                currentOption,
                style: kSettingsOption,
              ),
              SizedBox(
                width: kDefaultSpacer,
              ),
              HeroIcon(
                HeroIcons.arrowRight,
                size: kSettingOptionIconSize,
                color: kSettingOptionIconColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
