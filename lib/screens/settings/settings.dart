import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/routes/routes.dart';
import 'package:kount/screens/partials/SettingRow.dart';
import 'package:kount/screens/partials/button.dart';
import 'package:kount/screens/partials/navbar.dart';
import 'package:kount/screens/partials/top_navbar.dart';
import 'package:kount/screens/styles/constants.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TopNavBar(
        title: 'Settings',
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(
              height: kDefaultSpacer * 2.5,
            ),
            const SettingRow(
              title: 'Countdown format',
              route: kCountdownFormatRoute,
              currentOption: 'Days',
            ),
            const SizedBox(
              height: kDefaultSpacer * 2.5,
            ),
            const SettingRow(
              title: 'Countdown size',
              route: kCountdownSizeRoute,
              currentOption: 'Small',
            ),
            const SizedBox(
              height: 40,
            ),
            const SettingRow(
              title: 'Theme',
              route: kThemeRoute,
              currentOption: 'Light',
            ),
            const SizedBox(
              height: kDefaultSpacer * 2.5,
            ),
            Button(
              text: 'Contact us',
            ),
          ],
        ),
      )),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
