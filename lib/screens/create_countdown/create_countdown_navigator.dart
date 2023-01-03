import 'package:flutter/material.dart';
import 'package:kount/screens/create_countdown/create_countdown.dart';

class CreateCountdownNavigator extends StatefulWidget {
  const CreateCountdownNavigator({super.key});

  @override
  State<CreateCountdownNavigator> createState() =>
      _CreateCountdownNavigatorState();
}

class _CreateCountdownNavigatorState extends State<CreateCountdownNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return CreateCountdown();
          });
    });
  }
}
