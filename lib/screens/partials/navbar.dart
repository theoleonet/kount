import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/routes/routes.dart';
import 'package:kount/screens/auth/auth_state.dart';
import 'package:kount/screens/partials/clickable_icon.dart';
import 'package:kount/screens/styles/constants.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    checkIfUserIsLoggedIn();
  }

  bool loggedIn = false;

  Future checkIfUserIsLoggedIn() async {
    if (loggedIn) {
      return;
    }
    AuthState state = AuthState();
    Account account = state.account;

    Future promise = account.get();

    promise.then((response) {
      print(response);
      loggedIn = true;
      setState(() {});
    }).catchError((error) {
      print(error);
      loggedIn = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kBottomNavBarHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: kTopBorderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClickableIcon(
            icon: HeroIcons.home,
            route: kHomeRoute,
          ),
          ClickableIcon(
            icon: HeroIcons.plusCircle,
            route: kCreateCountdownRoute,
          ),
          ClickableIcon(
            icon: HeroIcons.cog8Tooth,
            route: kSettingsRoute,
          ),
          ClickableIcon(
            icon: HeroIcons.userCircle,
            route: loggedIn ? kProfileRoute : kRegisterRoute,
          ),
        ],
      ),
    );
  }
}
