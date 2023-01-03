import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:kount/screens/auth/auth_state.dart';
import 'package:kount/screens/partials/setting_row.dart';
import 'package:kount/screens/partials/button.dart';
import 'package:kount/screens/partials/top_navbar.dart';
import 'package:kount/screens/settings/countdown_format.dart';
import 'package:kount/screens/settings/countdown_size.dart';
import 'package:kount/screens/settings/custom_theme.dart';
import 'package:kount/screens/styles/constants.dart';
import 'package:strings/strings.dart';

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

  refresh() {
    getUserPrefs();
  }

  void getUserPrefs() {
    AuthState state = AuthState();
    Account account = state.account;

    Future response = account.getPrefs();
    response.then((result) {
      format = capitalize(result.data['countdown_format']);
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
                    settingDetailPage: CountdownFormat(),
                    currentOption: format!,
                    notifyParent: refresh,
                  ),
                  SizedBox(
                    height: kDefaultSpacer * 2.5,
                  ),
                  SettingRow(
                    title: 'Countdown size',
                    settingDetailPage: CountdownSize(),
                    currentOption: 'Small',
                    notifyParent: refresh,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SettingRow(
                    title: 'Theme',
                    settingDetailPage: CustomTheme(),
                    currentOption: 'Light',
                    notifyParent: refresh,
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
    );
  }
}
