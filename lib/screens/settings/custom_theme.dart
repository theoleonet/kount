import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/screens/partials/navbar.dart';
import 'package:kount/screens/partials/top_navbar.dart';
import 'package:kount/screens/styles/constants.dart';

class CustomTheme extends StatefulWidget {
  const CustomTheme({super.key});

  @override
  State<CustomTheme> createState() => _CustomThemeState();
}

enum Themes { light, dark }

class _CustomThemeState extends State<CustomTheme> {
  String selected = "";

  Themes? _theme = Themes.light;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: TopNavBar(title: 'Countdown size'),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: ((context, index) {
                  return Column(children: [
                    RadioListTile<Themes>(
                      activeColor: kRadioButtonActiveColor,
                      title: const Text('Light'),
                      value: Themes.light,
                      groupValue: _theme,
                      onChanged: (Themes? value) {
                        setState(() {
                          _theme = value;
                        });
                      },
                    ),
                    RadioListTile<Themes>(
                      activeColor: kRadioButtonActiveColor,
                      title: const Text('Dark'),
                      value: Themes.dark,
                      groupValue: _theme,
                      onChanged: (Themes? value) {
                        setState(() {
                          _theme = value;
                        });
                      },
                    ),
                  ]);
                })),
          ),
        ],
      ),
    );
  }
}
