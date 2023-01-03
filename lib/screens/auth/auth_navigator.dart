import 'package:flutter/material.dart';
import 'package:kount/screens/auth/login.dart';
import 'package:kount/screens/auth/register.dart';
import 'package:kount/screens/profile/profile_navigator.dart';

class AuthNavigator extends StatefulWidget {
  const AuthNavigator({super.key});

  @override
  State<AuthNavigator> createState() => _AuthNavigatorState();
}

class _AuthNavigatorState extends State<AuthNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            print(settings.name);
            switch (settings.name) {
              case '/login':
                return Login();
              case '/profile':
                return ProfileNavigator();
              default:
                return Register();
            }
          });
    });
  }
}
