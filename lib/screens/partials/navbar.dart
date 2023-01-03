import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/routes/routes.dart';
import 'package:kount/screens/auth/auth_state.dart';
import 'package:kount/screens/layout.dart';
import 'package:kount/screens/partials/clickable_icon.dart';
import 'package:kount/screens/styles/constants.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({this.currentTab, this.onSelectTab, super.key});

  final TabItem? currentTab;
  final Function(int index)? onSelectTab;

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
            onTap: () {
              widget.onSelectTab!(0);
            },
          ),
          ClickableIcon(
            icon: HeroIcons.plusCircle,
            onTap: () {
              widget.onSelectTab!(1);
            },
          ),
          ClickableIcon(
            icon: HeroIcons.cog8Tooth,
            onTap: () {
              widget.onSelectTab!(2);
            },
          ),
          ClickableIcon(
            icon: HeroIcons.userCircle,
            onTap: () {
              widget.onSelectTab!(3);
            },
          ),
        ],
      ),
    );
  }
}
