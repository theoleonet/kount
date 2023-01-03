import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/routes/router.dart';
import 'package:kount/routes/routes.dart';
import 'package:kount/screens/styles/constants.dart';

class SettingRow extends StatefulWidget {
  const SettingRow({
    required this.title,
    required this.settingDetailPage,
    required this.currentOption,
    required this.notifyParent,
    super.key,
  });

  final String title;
  final Widget settingDetailPage;
  final String currentOption;
  final Function() notifyParent;

  @override
  State<SettingRow> createState() => _SettingRowState();
}

class _SettingRowState extends State<SettingRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.title,
          style: kSettingsTitle,
        ),
        Spacer(),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget.settingDetailPage),
          ).then((value) {
            widget.notifyParent();
          }),
          child: Row(
            children: [
              Text(
                widget.currentOption,
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
