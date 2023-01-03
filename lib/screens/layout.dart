import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:kount/screens/auth/auth_navigator.dart';
import 'package:kount/screens/auth/auth_state.dart';
import 'package:kount/screens/create_countdown/create_countdown_navigator.dart';
import 'package:kount/screens/home/home_navigator.dart';
import 'package:kount/screens/partials/navbar.dart';
import 'package:kount/screens/profile/profile_navigator.dart';
import 'package:kount/screens/settings/settings_navigator.dart';
import 'package:kount/screens/styles/constants.dart';

enum TabItem { home, createCountdown, settings, profile }

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int currentIndex = 0;
  var user;

  void updatePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    AuthState state = AuthState();
    Account account = state.account;
    getUser(account);
  }

  void getUser(Account account) {
    Future result = account.get();
    result.then((response) {
      user = response;
    }).catchError((error) {
      print(error.response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: IndexedStack(
        index: currentIndex,
        children: [
          HomeNavigator(),
          CreateCountdownNavigator(),
          SettingsNavigator(),
          user != null ? ProfileNavigator() : AuthNavigator(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(onSelectTab: updatePage),
    );
  }
}
