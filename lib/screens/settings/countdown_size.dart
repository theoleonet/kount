import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/screens/cards/countdown_card.dart';
import 'package:kount/screens/partials/navbar.dart';
import 'package:kount/screens/partials/top_navbar.dart';
import 'package:kount/screens/styles/constants.dart';

class CountdownSize extends StatefulWidget {
  const CountdownSize({super.key});

  @override
  State<CountdownSize> createState() => _CountdownSizeState();
}

enum Sizes { small, medium, big }

class _CountdownSizeState extends State<CountdownSize> {
  Sizes? _size = Sizes.small;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: TopNavBar(title: 'Countdown size'),
      body: Column(
        children: [
          // CountdownCard(),
          Flexible(
            child: Column(
              children: [
                RadioListTile<Sizes>(
                  activeColor: kRadioButtonActiveColor,
                  title: const Text('Small'),
                  value: Sizes.small,
                  groupValue: _size,
                  onChanged: (Sizes? value) {
                    setState(() {
                      _size = value;
                    });
                  },
                ),
                RadioListTile<Sizes>(
                  activeColor: kRadioButtonActiveColor,
                  title: const Text('Medium'),
                  value: Sizes.medium,
                  groupValue: _size,
                  onChanged: (Sizes? value) {
                    setState(() {
                      _size = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
