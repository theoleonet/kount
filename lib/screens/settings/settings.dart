import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/routes/routes.dart';
import 'package:kount/screens/auth/auth_state.dart';
import 'package:kount/screens/partials/setting_row.dart';
import 'package:kount/screens/partials/button.dart';
import 'package:kount/screens/partials/navbar.dart';
import 'package:kount/screens/partials/top_navbar.dart';
import 'package:kount/screens/styles/constants.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String? format;

  @override
  void initState() {
    getUserPrefs();
  }

  void getUserPrefs() {
    AuthState state = AuthState();
    Account account = state.account;

    Future response = account.getPrefs();
    response.then((result) {
      format = result.data['countdown_format'];
      setState(() {});
    }).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopNavBar(
        title: 'Settings',
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: format != null
            ? Column(
                children: [
                  SizedBox(
                    height: kDefaultSpacer * 2.5,
                  ),
                  SettingRow(
                    title: 'Countdown format',
                    route: kCountdownFormatRoute,
                    currentOption: format!,
                  ),
                  SizedBox(
                    height: kDefaultSpacer * 2.5,
                  ),
                  SettingRow(
                    title: 'Countdown size',
                    route: kCountdownSizeRoute,
                    currentOption: 'Small',
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SettingRow(
                    title: 'Theme',
                    route: kThemeRoute,
                    currentOption: 'Light',
                  ),
                  SizedBox(
                    height: kDefaultSpacer * 2.5,
                  ),
                  Button(
                    text: 'Contact us',
                  ),
                ],
              )
            : Container(),
      )),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
