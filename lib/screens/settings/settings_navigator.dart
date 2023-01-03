import 'package:flutter/material.dart';
import 'package:kount/screens/settings/settings.dart';

class SettingsNavigator extends StatefulWidget {
  const SettingsNavigator({super.key});

  @override
  State<SettingsNavigator> createState() => _SettingsNavigatorState();
}

class _SettingsNavigatorState extends State<SettingsNavigator> {
  @override
  Widget build(BuildContext context) {
    return Settings();
  }
}
